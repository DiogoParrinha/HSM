/*
 * SecComm.c
 *
 *  Created on: 20/02/2017
 *      Author: diogo
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "mbedtls/pkcs5.h"
#include "SecComm.h"

mbedtls_ecp_keypair * temp_pair;

////// Perform ECIES: ECDH + KDF (PKCS#5) + AES-256
BOOL SecComm()
{
	int ret = 0;

	const char pers[] = "ecdh";

	mbedtls_entropy_context SecComm_entropy;
	mbedtls_ctr_drbg_context SecComm_ctr_drbg;

	mbedtls_ctr_drbg_init(&SecComm_ctr_drbg);
	mbedtls_entropy_init(&SecComm_entropy);

	// add entropy source
	if((ret = mbedtls_entropy_add_source(&SecComm_entropy, mbedtls_hardware_poll,
									NULL, ENTROPY_MIN_BYTES_RELEASE,
									MBEDTLS_ENTROPY_SOURCE_STRONG)) != 0)
	{
		return FALSE;
	}

	// seed seed for drbg
	if( ( ret = mbedtls_ctr_drbg_seed(&SecComm_ctr_drbg, mbedtls_entropy_func, &SecComm_entropy,
							   (const unsigned char *) pers,
							   strlen( pers ) ) ) != 0 )
	{
		mbedtls_entropy_free(&SecComm_entropy);

		return FALSE;
	}

	mbedtls_ecdh_context ctx_srv;
	mbedtls_ecdh_init(&ctx_srv);

	////// Parse private and public and transform them into ec key pairs
	mbedtls_pk_context pk_ctx_pri;
	mbedtls_pk_init(&pk_ctx_pri);

	// Parse private key
	ret = mbedtls_pk_parse_key(&pk_ctx_pri, SESS_PRIVATE_KEY, strlen(SESS_PRIVATE_KEY)+1, NULL, 0);
	if(ret != 0)
	{
		mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
		mbedtls_entropy_free(&SecComm_entropy);

		mbedtls_ecdh_free(&ctx_srv);
		mbedtls_pk_free(&pk_ctx_pri);

		return FALSE;
	}

	// pk -> ec pair
	temp_pair = mbedtls_pk_ec(pk_ctx_pri);

	// grp
	ctx_srv.grp = temp_pair->grp;

	// private
	mbedtls_mpi oldD = ctx_srv.d;
	ctx_srv.d = temp_pair->d;

	temp_pair = NULL;

	///// Receive ciphertext + IV/salt + public key + HMAC(C | IV | P)

	UART_sendOK(); //  confirmation to receive

	uint8_t ciphertext[32] = {0};
	UART_receive(&ciphertext[0], 32u); // ciphertext

	uint8_t salt_IV[16] = {0};
	UART_receive(&salt_IV[0], 16u); // salt / IV

	uint8_t cli_pub_x[48] = {0};
	UART_receive(&cli_pub_x[0], 48u); // public key X

	uint8_t cli_pub_y[48] = {0};
	UART_receive(&cli_pub_y[0], 48u); // public key Y

	uint8_t recHMAC[32] = {0};
	UART_receive(&recHMAC[0], 32u); // HMAC

	//// Compute shared secret

	// store client's public key X into ctx_srv public key
	ret = mbedtls_mpi_read_binary(&ctx_srv.Qp.X, cli_pub_x, 48u);
	if( ret != 0 )
	{
		mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
		mbedtls_entropy_free(&SecComm_entropy);

		mbedtls_pk_free(&pk_ctx_pri);
		ctx_srv.d = oldD;
		mbedtls_ecdh_free(&ctx_srv);

		return FALSE;
	}

	// store client's public key Y into ctx_srv public key
	ret = mbedtls_mpi_read_binary(&ctx_srv.Qp.Y, cli_pub_y, 48u);
	if( ret != 0 )
	{
		mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
		mbedtls_entropy_free(&SecComm_entropy);

		mbedtls_pk_free(&pk_ctx_pri);
		ctx_srv.d = oldD;
		mbedtls_ecdh_free(&ctx_srv);

		return FALSE;
	}

	ret = mbedtls_mpi_lset(&ctx_srv.Qp.Z, 1);
	if( ret != 0 )
	{
		mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
		mbedtls_entropy_free(&SecComm_entropy);

		mbedtls_pk_free(&pk_ctx_pri);
		ctx_srv.d = oldD;
		mbedtls_ecdh_free(&ctx_srv);

		return FALSE;
	}

	// compute shared secret
	int len = 0;
	uint8_t shared_secret[128] = {0};
	if((ret = mbedtls_ecdh_calc_secret(&ctx_srv, &len, shared_secret, 128u, mbedtls_ctr_drbg_random, &SecComm_ctr_drbg)) != 0)
	{
		mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
		mbedtls_entropy_free(&SecComm_entropy);

		mbedtls_pk_free(&pk_ctx_pri);
		ctx_srv.d = oldD;
		mbedtls_ecdh_free(&ctx_srv);

		return FALSE;
	}

	///// PKCS#5 Key derivation to obtain sessionKey and HMAC Key

	const mbedtls_md_info_t *md_info;
	mbedtls_md_type_t md_type = MBEDTLS_MD_SHA256;
	mbedtls_md_context_t md_ctx;
	mbedtls_md_init( &md_ctx );
	uint8_t expandedKey[64] = {0};

	md_info = mbedtls_md_info_from_type( md_type );
	if( md_info == NULL )
	{
		mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
		mbedtls_entropy_free(&SecComm_entropy);

		mbedtls_pk_free(&pk_ctx_pri);
		ctx_srv.d = oldD;
		mbedtls_ecdh_free(&ctx_srv);

		mbedtls_md_free(&md_ctx);

		return FALSE;
	}

	if( ( ret = mbedtls_md_setup( &md_ctx, md_info, 1 ) ) != 0 )
	{
		mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
		mbedtls_entropy_free(&SecComm_entropy);

		mbedtls_pk_free(&pk_ctx_pri);
		ctx_srv.d = oldD;
		mbedtls_ecdh_free(&ctx_srv);

		mbedtls_md_free(&md_ctx);

		return FALSE;
	}

	ret = mbedtls_pkcs5_pbkdf2_hmac(&md_ctx, shared_secret, len, salt_IV, 16, 1, 64, expandedKey);
	if(ret != 0)
	{
		mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
		mbedtls_entropy_free(&SecComm_entropy);

		mbedtls_pk_free(&pk_ctx_pri);
		ctx_srv.d = oldD;
		mbedtls_ecdh_free(&ctx_srv);

		mbedtls_md_free(&md_ctx);

		return FALSE;
	}
	mbedtls_md_free(&md_ctx);

	uint8_t sessKey[32] = {0}, hmacKey[32] = {0};
	memcpy(&sessKey[0], expandedKey, 32);
	memcpy(&hmacKey[0], &expandedKey[32], 32);

	///// Compute HMAC and verify it (we only have the HMAC key now!)

	mbedtls_md_context_t sha_ctx;
	uint8_t HMAC[32] = { 0 };
	mbedtls_md_init(&sha_ctx);

	ret = mbedtls_md_setup(&sha_ctx, mbedtls_md_info_from_type(MBEDTLS_MD_SHA256), 1);
	if (ret != 0)
	{
		mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
		mbedtls_entropy_free(&SecComm_entropy);

		mbedtls_pk_free(&pk_ctx_pri);
		ctx_srv.d = oldD;
		mbedtls_ecdh_free(&ctx_srv);

		mbedtls_md_free(&sha_ctx);

		return FALSE;
	}

	mbedtls_md_hmac_starts(&sha_ctx, hmacKey, 32);

	mbedtls_md_hmac_update(&sha_ctx, ciphertext, 32); // ciphertext
	mbedtls_md_hmac_update(&sha_ctx, salt_IV, 16); // salt / IV
	mbedtls_md_hmac_update(&sha_ctx, cli_pub_x, 48); // public key X
	mbedtls_md_hmac_update(&sha_ctx, cli_pub_y, 48); // public key Y
	mbedtls_md_hmac_finish(&sha_ctx, HMAC);
	mbedtls_md_free(&sha_ctx);

	// Compare HMACs
	unsigned char diff = 0;
	for (int i = 0; i < 32; i++)
		diff |= HMAC[i] ^ recHMAC[i]; // XOR = 1 if one is different from the other

	if (diff != 0)
	{
		mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
		mbedtls_entropy_free(&SecComm_entropy);

		mbedtls_pk_free(&pk_ctx_pri);
		ctx_srv.d = oldD;
		mbedtls_ecdh_free(&ctx_srv);

		return FALSE;
	}

	//// Decrypt ciphertext
	mbedtls_aes_context aes_ctx;
	mbedtls_aes_init(&aes_ctx);
	mbedtls_aes_setkey_dec(&aes_ctx, sessKey, 256);
	uint8_t plaintext[32];
	memset(plaintext, 0, 32);
	uint8_t IV_copy[16] = { 0 };
	memcpy(IV_copy, salt_IV, 16);
	mbedtls_aes_crypt_cbc(&aes_ctx, MBEDTLS_AES_DECRYPT, 32, IV_copy, ciphertext, &plaintext[0]);
	mbedtls_aes_free(&aes_ctx);

	//// Modify nonce
	// (plaintext mod 6)
	uint8_t mod_nonce[32];
	int a = 0;
	for (a = 0; a < 32; a++)
	{
		mod_nonce[a] = plaintext[a] % 6; // TODO: plaintext[a] mod 6 for now...
	}

	//// Send modified nonce using normal secure comm
	UART_setKey(sessKey, hmacKey);
	UART_send(mod_nonce, 32u);

	//// Expect a new modified nonce to confirm the other party has the session key
	for (a = 0; a < 32; a++)
	{
		mod_nonce[a] = mod_nonce[a] % 16; // TODO: mod_nonce[a] mod 16 for now...
	}

	uint8_t ver_challenge[32] = {0};
	UART_receive(&ver_challenge[0], 32);
	for(a=0;a<32;a++)
	{
		if(ver_challenge[a] != mod_nonce[a])
		{
			mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
			mbedtls_entropy_free(&SecComm_entropy);

			mbedtls_pk_free(&pk_ctx_pri);
			ctx_srv.d = oldD;
			mbedtls_ecdh_free(&ctx_srv);

			return FALSE;
		}
	}

	// Send SUCCESS
	UART_send("SUCCESS", 7);

	mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
	mbedtls_entropy_free(&SecComm_entropy);

	// The actual values (mbedtls_mpi) of Q and d contain pointers to mbedtls_mpi_uint so this is freed here only
	mbedtls_pk_free(&pk_ctx_pri);
	ctx_srv.d = oldD;
	mbedtls_ecdh_free(&ctx_srv);

	return TRUE;
}

