/*
 * PKC.c
 *
 *  Created on: 10/02/2017
 *      Author: diogo
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "PKC.h"

BOOL PKC_genKeyPair(uint8_t * pub, uint8_t * pri)
{
    mbedtls_pk_context ctx;
    mbedtls_entropy_context entropy;
    mbedtls_ctr_drbg_context ctr_drbg;
    const char *pers = "ecdsa";

    int ret = PKC_init(&ctx, &entropy, &ctr_drbg, pers, TRUE);
    if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

    // Generate key pair
    ret = mbedtls_ecp_gen_key(MBEDTLS_ECP_DP_SECP192R1, mbedtls_pk_ec(ctx), mbedtls_ctr_drbg_random, &ctr_drbg);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

    // Write a PEM string for the public key (we can use strlen of pub to find out how many bytes are in the string)
	ret = mbedtls_pk_write_pubkey_pem(&ctx, pub, ECC_PUBLIC_KEY_SIZE);
	if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

    // Write a PEM string for the private key (we can use strlen of pri to find out how many bytes are in the string)
    ret = mbedtls_pk_write_key_pem(&ctx, pri, ECC_PRIVATE_KEY_SIZE);
	if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

	/*
	////// TEST

	mbedtls_pk_context ctx_sign;
	mbedtls_pk_init(&ctx_sign);

	// Parse private key
	ret = mbedtls_pk_parse_key(&ctx_sign, pri, strlen(pri)+1, NULL, 0);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

	uint8_t data[32] = {
			0x8d, 0x96, 0x9e, 0xef, 0x6e, 0xca, 0xd3, 0xc2, 0x9a, 0x3a, 0x62, 0x92, 0x80, 0xe6, 0x86, 0xcf,
			0x0c, 0x3f, 0x5d, 0x5a, 0x86, 0xaf, 0xf3, 0xca, 0x12, 0x02, 0x0c, 0x92, 0x3a, 0xdc, 0x6c, 0x92
	};

	uint8_t signature[512];
	size_t signature_len = 0;
	if( ( ret = mbedtls_pk_sign(&ctx_sign, MBEDTLS_MD_SHA256, data, 32, signature, &signature_len, mbedtls_ctr_drbg_random, &ctr_drbg ) ) != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

	mbedtls_pk_context ctx_verify;
	mbedtls_pk_init(&ctx_verify);

	// Parse public key
	ret = mbedtls_pk_parse_public_key(&ctx_verify, pub, strlen(pub)+1);
	if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

	//Verify signature
	ret = mbedtls_pk_verify(&ctx, MBEDTLS_MD_SHA256, data, 32, signature, signature_len);
	if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

	mbedtls_pk_free(&ctx_sign);
	mbedtls_pk_free(&ctx_verify);

	*/

	PKC_free(&ctx, &entropy, &ctr_drbg);

    return TRUE;
}

uint8_t PKC_signData(uint8_t * private, uint8_t * data, size_t data_len, uint8_t * signature, size_t * signature_len)
{
	mbedtls_pk_context ctx;
    mbedtls_entropy_context entropy;
    mbedtls_ctr_drbg_context ctr_drbg;
    const char *pers = "mbedtls_pk_sign";

    int ret = PKC_init(&ctx, &entropy, &ctr_drbg, pers, FALSE);
    if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return 1;
	}

    // Parse private key
    ret = mbedtls_pk_parse_key(&ctx, private, strlen(private)+1, NULL, 0);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return 2;
	}

	if( ( ret = mbedtls_pk_sign(&ctx, MBEDTLS_MD_SHA256, data, 32, signature, signature_len,
	                         mbedtls_ctr_drbg_random, &ctr_drbg ) ) != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return 3;
	}

    PKC_free(&ctx, &entropy, &ctr_drbg);

    return 1;
}

int PKC_verifySignature(uint8_t * public, uint8_t * data, size_t data_len, uint8_t * signature, size_t signature_len)
{
	mbedtls_pk_context ctx;
    mbedtls_entropy_context entropy;
    mbedtls_ctr_drbg_context ctr_drbg;
    const char *pers = "mbedtls_pk_sign";

    int ret = PKC_init(&ctx, &entropy, &ctr_drbg, pers, FALSE);
    if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return 1;
	}

    // Parse public key
	ret = mbedtls_pk_parse_public_key(&ctx, public, strlen(public)+1);
	if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return 2;
	}

	//Verify signature
	ret = mbedtls_pk_verify(&ctx, MBEDTLS_MD_SHA256, data, 32, signature, signature_len);
	if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return 3;
	}

	PKC_free(&ctx, &entropy, &ctr_drbg);

    return 0;
}

BOOL PKC_createCertificate(uint8_t* public, uint8_t * subject_name, uint16_t key_usage, uint8_t* certificate, uint32_t bufsize)
{
	mbedtls_entropy_context entropy;
	mbedtls_ctr_drbg_context ctr_drbg;
	mbedtls_pk_context issuer_key, subject_key;
	mbedtls_x509write_cert crt;
	const char *pers = "crt_issue";
	mbedtls_mpi serial;

    mbedtls_x509write_crt_init( &crt );
    mbedtls_x509write_crt_set_md_alg( &crt, MBEDTLS_MD_SHA256 );

	mbedtls_pk_init(&issuer_key);
	mbedtls_pk_init(&subject_key);
	mbedtls_mpi_init(&serial);

	// Load our issuer key (context doesn't matter becaues last param is FALSE)
    volatile int ret = PKC_init(&issuer_key, &entropy, &ctr_drbg, pers, FALSE);
    if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

    // Parse issuer private key
	ret = mbedtls_pk_parse_key(&issuer_key, ISSUER_PRIVATE_KEY, strlen(ISSUER_PRIVATE_KEY)+1, NULL, 0);
	if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// Parse subject public key
	ret = mbedtls_pk_parse_public_key(&subject_key, public, strlen(public)+1);
	if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// Set issuer and subject keys
	mbedtls_x509write_crt_set_subject_key(&crt, &subject_key);
	mbedtls_x509write_crt_set_issuer_key(&crt, &issuer_key);

	// Set subject and issuer names
	if((ret = mbedtls_x509write_crt_set_subject_name(&crt, subject_name)) != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	if((ret = mbedtls_x509write_crt_set_issuer_name(&crt, "CN=HSM-INESC,C=PT")) != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// TODO: Get next serial to use (last serial is stored in the first sector of SPI Flash) - it's "1" for now
	if((ret = mbedtls_mpi_read_string(&serial, 10, "1")) != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// Set serial
    ret = mbedtls_x509write_crt_set_serial(&crt, &serial);
    if(ret != 0)
    {
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
    }

    // Set validity (format: 20301231235959)
    ret = mbedtls_x509write_crt_set_validity(&crt, "20010101000000", "20301231235959");
    if(ret != 0)
    {
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
    }

    // Set basic constraints (is_ca and max_pathlen)
	ret = mbedtls_x509write_crt_set_basic_constraints(&crt, 0, -1);
	if(ret != 0)
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// Set key usage extension
	ret = mbedtls_x509write_crt_set_key_usage(&crt, key_usage);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

	// Write certificate
    memset(certificate, 0, bufsize);
    if((ret = mbedtls_x509write_crt_pem(&crt, certificate, bufsize, mbedtls_ctr_drbg_random, &ctr_drbg)) < 0)
    {
		char error[10];
		sprintf(error, "E: %d", ret);
		__printf(error);
		return FALSE;
	}

    mbedtls_x509write_crt_free(&crt);
    mbedtls_pk_free(&subject_key);

	PKC_free(&issuer_key, &entropy, &ctr_drbg);

    return TRUE;
}

int PKC_init(mbedtls_pk_context *ctx, mbedtls_entropy_context * entropy, mbedtls_ctr_drbg_context * ctr_drbg, const char * pers, BOOL loadGroup)
{
	mbedtls_pk_init(ctx);
	mbedtls_ctr_drbg_init(ctr_drbg);
	mbedtls_entropy_init(entropy);

	int ret = 0;
	if( ( ret = mbedtls_entropy_add_source(entropy, mbedtls_hardware_poll,
									NULL, ENTROPY_MIN_BYTES_RELEASE,
									MBEDTLS_ENTROPY_SOURCE_STRONG ) ) != 0 )
	{
		return ret;
	}

	if( ( ret = mbedtls_ctr_drbg_seed(ctr_drbg, mbedtls_entropy_func, entropy,
							   (const unsigned char *) pers,
							   strlen( pers ) ) ) != 0 )
	{
		return ret;
	}

	if(loadGroup)
	{
		if((ret = mbedtls_pk_setup(ctx, mbedtls_pk_info_from_type(MBEDTLS_PK_ECKEY))) != 0)
		{
			return FALSE;
		}
	}

	return 0;
}

void PKC_free(mbedtls_pk_context *ctx, mbedtls_entropy_context * entropy, mbedtls_ctr_drbg_context * ctr_drbg)
{
	mbedtls_pk_free(ctx);
	mbedtls_ctr_drbg_free(ctr_drbg);
	mbedtls_entropy_free(entropy);
}


