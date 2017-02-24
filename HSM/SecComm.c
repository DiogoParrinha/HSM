/*
 * SecComm.c
 *
 *  Created on: 20/02/2017
 *      Author: diogo
 */

#include "SecComm.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

BOOL SecComm_establishSessionKey(uint8_t * sessionKey)
{
	const char pers[] = "ecdh";

	mbedtls_md_context_t sha_ctx;
	mbedtls_md_init(&sha_ctx);

	// TODO: something must be used to stop Man-in-the-Middle and Replay Attacks (think if the latter is possible to do)

	// add entropy source
	int ret = 0;
	if( ( ret = mbedtls_entropy_add_source(&SecComm_entropy, mbedtls_hardware_poll,
									NULL, 4,
									MBEDTLS_ENTROPY_SOURCE_STRONG ) ) != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// seed seed for drbg
	if( ( ret = mbedtls_ctr_drbg_seed(&SecComm_ctr_drbg, mbedtls_entropy_func, &SecComm_entropy,
							   (const unsigned char *) pers,
							   strlen( pers ) ) ) != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// load group
	ret = mbedtls_ecp_group_load(&ctx_srv.grp, MBEDTLS_ECP_DP_CURVE25519);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// generate key pair
	ret = mbedtls_ecdh_gen_public(&ctx_srv.grp, &ctx_srv.d, &ctx_srv.Q, mbedtls_ctr_drbg_random, &SecComm_ctr_drbg);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// write public key into srv_to_cli (unsigned binary data)
	ret = mbedtls_mpi_write_binary(&ctx_srv.Q.X, srv_to_cli, 32u);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	UART_sendOK();

	// write client's public key into cli_to_srv (unsigned binary data)
	UART_receive(&cli_to_srv[0], 32u);

	// send our srv_to_cli
	UART_send(srv_to_cli, 32);

	ret = mbedtls_mpi_lset(&ctx_srv.Qp.Z, 1);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// store client's public key X into ctx_srv public key
	ret = mbedtls_mpi_read_binary(&ctx_srv.Qp.X, cli_to_srv, 32u);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// compute shared secret
	int len = 0;
	uint8_t shared_secret[32];
	if((ret = mbedtls_ecdh_calc_secret(&ctx_srv, &len, shared_secret, 128u, mbedtls_ctr_drbg_random, &SecComm_ctr_drbg)) != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// calculate SHA-256
	mbedtls_sha256(shared_secret, len, sessionKey, 0);

	mbedtls_md_free(&sha_ctx);

	return TRUE;
}

BOOL SecComm_validateSessionKey(uint8_t * key)
{
	int ret = 0;

	mbedtls_aes_context aes_ctx;
	mbedtls_aes_init(&aes_ctx);

	mbedtls_md_context_t sha_ctx;
	mbedtls_md_init(&sha_ctx);

	// Set AES key
	mbedtls_aes_setkey_enc(&aes_ctx, key, 256);
	mbedtls_aes_setkey_dec(&aes_ctx, key, 256);

	// TODO: Generate random IV of 16B
	uint8_t IV[16] = {0x72, 0x88, 0xd4, 0x11, 0x94, 0xea, 0xf7, 0x1c, 0x31, 0xac, 0xc3, 0x8c, 0xc7, 0xdc, 0x82, 0x4b};

	// Calculate HMAC-256 of IV
	uint8_t HMAC[32] = {0};
	ret = mbedtls_md_setup(&sha_ctx, mbedtls_md_info_from_type(MBEDTLS_MD_SHA256), 1);
	if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	mbedtls_md_hmac_starts(&sha_ctx, key, 32);
	mbedtls_md_hmac_update(&sha_ctx, IV, 16);

	//Finally write the HMAC.
	mbedtls_md_hmac_finish(&sha_ctx, HMAC);

	// Send HMAC-256 of IV
	UART_send(HMAC, 32);

	// Set session key
	UART_setKey(key);

	// Send 32-bit challenge (4B)
	// TODO: Generate random challenge
	uint8_t challenge[4] = {
			0x72, 0x88, 0xd4, 0x11};
	UART_send(challenge, 4);

	// Expect 32-bit modification
	// (challenge XOR 0x7a52f2d1)
	uint8_t mod_challenge[4] = {0};
	mod_challenge[0] = challenge[0] ^ 0x7a;
	mod_challenge[1] = challenge[1] ^ 0x52;
	mod_challenge[2] = challenge[2] ^ 0xf2;
	mod_challenge[3] = challenge[3] ^ 0xd1;
	uint8_t ver_challenge[4] = {0};
	UART_receive(&ver_challenge[0], 4);
	if(ver_challenge[0] != mod_challenge[0] ||
			ver_challenge[1] != mod_challenge[1] ||
			ver_challenge[2] != mod_challenge[2] ||
			ver_challenge[3] != mod_challenge[3])
	{
		char error[10];
		sprintf(error, "E: invalid challenge");
		__printf(error);
		return FALSE;
	}

	mbedtls_md_free(&sha_ctx);
	mbedtls_aes_free(&aes_ctx);

	return TRUE;
}

BOOL SecComm_start(uint8_t * key)
{
	mbedtls_ecdh_init(&ctx_cli);
	mbedtls_ecdh_init(&ctx_srv);
	mbedtls_ctr_drbg_init(&SecComm_ctr_drbg);
	mbedtls_entropy_init(&SecComm_entropy);

	if(!SecComm_establishSessionKey(key))
	{
		return FALSE;
	}

	if(!SecComm_validateSessionKey(key))
	{
		return FALSE;
	}

	mbedtls_ecdh_free(&ctx_srv);
	mbedtls_ecdh_free(&ctx_cli);
	mbedtls_ctr_drbg_free(&SecComm_ctr_drbg);
	mbedtls_entropy_free(&SecComm_entropy);

	return TRUE;
}

