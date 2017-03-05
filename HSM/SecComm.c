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
#include "SecComm.h"

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
	int a = 0;

	// Set session key
	UART_setKey(key);

	// TODO: Generate 128-bit challenge
	uint8_t challenge[16] = {0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28};
	if(UART_send(challenge, 16) != 0)
	{
		return FALSE;
	}

	// Expect modified challenge
	// (challenge mod 6)
	uint8_t mod_challenge[16];
	for (a = 0; a < 16; a++)
	{
		mod_challenge[a] = challenge[a] % 6; // TODO: challenge[a] mod 6 for now...
	}

	uint8_t ver_challenge[16] = {0};
	UART_receive(&ver_challenge[0], 16);
	for(a=0;a<16;a++)
	{
		if(ver_challenge[a] != mod_challenge[a])
		{
			char error[10];
			sprintf(error, "E: invalid challenge");
			__printf(error);
			return FALSE;
		}
	}

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

