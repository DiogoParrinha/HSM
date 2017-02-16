/*
 * PKC.c
 *
 *  Created on: 10/02/2017
 *      Author: diogo
 */

#include "PKC.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "drivers/mss_pdma/mss_pdma.h"
#include "drivers/mss_spi/mss_spi.h"
#include "drivers/w25q64fvssig/w25q64fvssig.h"

BOOL PKC_genKeyPair(uint8_t * pri, uint8_t * pub)
{
	/*const struct uECC_Curve_t * curve = uECC_secp256r1();
    uint8_t private[32] = {0};
    uint8_t public[64] = {0};
    uint8_t hash[32] = {0};
    uint8_t sig[64] = {0};

    // Define random number generator
    uECC_set_rng(myRandom);

    if (!uECC_make_key(public, private, curve)) {
    	__printf("uECC_make_key() failed\n");
        return FALSE;
    }
    memcpy(hash, public, sizeof(hash));

    if (!uECC_sign(private, hash, sizeof(hash), sig, curve)) {
    	__printf("uECC_sign() failed\n");
        return FALSE;
    }

    if (!uECC_verify(public, hash, sizeof(hash), sig, curve)) {
        __printf("uECC_verify() failed\n");
        return FALSE;
    }

    // Copy private and public
    memcpy(pri, private, 32);
    memcpy(pub, public, 64);*/

    mbedtls_ecdsa_context ctx_sign;
    mbedtls_entropy_context entropy;
    mbedtls_ctr_drbg_context ctr_drbg;
    const char *pers = "ecdsa";

    mbedtls_ecdsa_init(&ctx_sign);
    mbedtls_ctr_drbg_init( &ctr_drbg );

    int ret = 0;

    //Generate a key pair for signing
    //__printf( "\n  . Seeding the random number generator..." );

    mbedtls_entropy_init( &entropy );

    if( ( ret = mbedtls_entropy_add_source( &entropy, mbedtls_hardware_poll,
									NULL, 4,
									MBEDTLS_ENTROPY_SOURCE_STRONG ) ) != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

    if( ( ret = mbedtls_ctr_drbg_seed( &ctr_drbg, mbedtls_entropy_func, &entropy,
                               (const unsigned char *) pers,
                               strlen( pers ) ) ) != 0 )
    {
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
    }

    //__printf( " ok\n  . Generating key pair..." );
    if( ( ret = mbedtls_ecdsa_genkey( &ctx_sign, MBEDTLS_ECP_DP_SECP192R1,
                              mbedtls_ctr_drbg_random, &ctr_drbg ) ) != 0 )
    {
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
    }

    /*char data[256] = {0};
	sprintf(data, "key size: %d bits", (int) ctx_sign.grp.pbits );
	__printf(data);*/

    // Write point Q (X,Y,Z) into buffer
    size_t olen = 0;
    ret = mbedtls_ecp_point_write_binary(&ctx_sign.grp, &ctx_sign.Q, MBEDTLS_ECP_PF_UNCOMPRESSED, &olen, pub, ECC_PUBLIC_KEY_STORE_SIZE);
    if( ret != 0 )
    {
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
    }

    ret = mbedtls_mpi_write_binary(&ctx_sign.d, pri, ECC_PRIVATE_KEY_SIZE);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}


	//// TEST

	/*char data[32] = {
		0x8d, 0x96, 0x9e, 0xef, 0x6e, 0xca, 0xd3, 0xc2,
		0x9a, 0x3a, 0x62, 0x92, 0x80, 0xe6, 0x86, 0xcf,
		0x0c, 0x3f, 0x5d, 0x5a, 0x86, 0xaf, 0xf3, 0xca,
		0x12, 0x02, 0x0c, 0x92, 0x3a, 0xdc, 0x6c, 0x92
	};
	char signature[512];
	size_t signature_len = 0;

	 if( ( ret = mbedtls_ecdsa_write_signature( &ctx_sign, MBEDTLS_MD_SHA256,
									   data, sizeof(data),
									   signature, &signature_len,
									   mbedtls_ctr_drbg_random, &ctr_drbg ) ) != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return 2;
	}

	// Import point Q
	ret = mbedtls_ecp_point_read_binary(&ctx_sign.grp, &ctx_sign.Q, pub, ECC_PUBLIC_KEY_STORE_SIZE);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

	//Verify signature
	if( ( ret = mbedtls_ecdsa_read_signature(&ctx_sign,
									  data, sizeof(data),
									  signature, signature_len) ) != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}*/

    mbedtls_ecdsa_free( &ctx_sign );
    mbedtls_ctr_drbg_free( &ctr_drbg );
    mbedtls_entropy_free( &entropy );

    return TRUE;
}

uint8_t PKC_signData(uint8_t * private, uint8_t * data, size_t data_len, uint8_t * signature, size_t * signature_len)
{
    mbedtls_ecdsa_context ctx_sign;
    mbedtls_entropy_context entropy;
    mbedtls_ctr_drbg_context ctr_drbg;
    const char *pers = "ecdsa";

    mbedtls_ecdsa_init(&ctx_sign);
    mbedtls_ctr_drbg_init( &ctr_drbg );

    int ret = 0;

    mbedtls_entropy_init( &entropy );

    if( ( ret = mbedtls_entropy_add_source( &entropy, mbedtls_hardware_poll,
									NULL, 4,
									MBEDTLS_ENTROPY_SOURCE_STRONG ) ) != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return 0;
	}

    if( ( ret = mbedtls_ctr_drbg_seed( &ctr_drbg, mbedtls_entropy_func, &entropy,
                               (const unsigned char *) pers,
                               strlen( pers ) ) ) != 0 )
    {
    	char error[10];
    	sprintf(error, "E: %d", ret );
        __printf(error);
        return 0;
    }

    ret = mbedtls_ecp_group_load(&ctx_sign.grp, MBEDTLS_ECP_DP_SECP192R1);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return 0;
	}

	ret = mbedtls_mpi_read_binary(&ctx_sign.d, private, ECC_PRIVATE_KEY_SIZE);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return 0;
	}

    if( ( ret = mbedtls_ecdsa_write_signature( &ctx_sign, MBEDTLS_MD_SHA256,
                                       data, data_len,
                                       signature, signature_len,
                                       mbedtls_ctr_drbg_random, &ctr_drbg ) ) != 0 )
    {
    	char error[10];
    	sprintf(error, "E: %d", ret );
        __printf(error);
        return 2;
    }

    mbedtls_ecdsa_free( &ctx_sign );
    mbedtls_ctr_drbg_free( &ctr_drbg );
    mbedtls_entropy_free( &entropy );

    return 1;
}

BOOL PKC_verifySignature(uint8_t * public, uint8_t * data, size_t data_len, uint8_t * signature, size_t signature_len)
{
    mbedtls_ecdsa_context ctx_sign;
    mbedtls_entropy_context entropy;
    mbedtls_ctr_drbg_context ctr_drbg;
    const char *pers = "ecdsa";

    mbedtls_ecdsa_init(&ctx_sign);
    mbedtls_ctr_drbg_init( &ctr_drbg );

    int ret = 0;

    mbedtls_entropy_init( &entropy );

    if( ( ret = mbedtls_entropy_add_source( &entropy, mbedtls_hardware_poll,
									NULL, 4,
									MBEDTLS_ENTROPY_SOURCE_STRONG ) ) != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

    if( ( ret = mbedtls_ctr_drbg_seed( &ctr_drbg, mbedtls_entropy_func, &entropy,
                               (const unsigned char *) pers,
                               strlen( pers ) ) ) != 0 )
    {
    	char error[10];
    	sprintf(error, "E: %d", ret );
        __printf(error);
        return FALSE;
    }

    ret = mbedtls_ecp_group_load(&ctx_sign.grp, MBEDTLS_ECP_DP_SECP192R1);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

	// Import point Q
	ret = mbedtls_ecp_point_read_binary(&ctx_sign.grp, &ctx_sign.Q, public, ECC_PUBLIC_KEY_STORE_SIZE);
	if( ret != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

	/*
	 * Verify signature
	 */
	if( ( ret = mbedtls_ecdsa_read_signature(&ctx_sign,
									  data, data_len,
									  signature, signature_len) ) != 0 )
	{
		char error[10];
		sprintf(error, "E: %d", ret );
		__printf(error);
		return FALSE;
	}

    mbedtls_ecdsa_free( &ctx_sign );
    mbedtls_ctr_drbg_free( &ctr_drbg );
    mbedtls_entropy_free( &entropy );

    return TRUE;
}

/*
 * uECC_RNG_Function type
 *
 * The RNG function should fill 'size' random bytes into 'dest'. It should return 1 if
 * 'dest' was filled with random data, or 0 if the random data could not be generated.
 * The filled-in values should be either truly random, or from a cryptographically-secure PRNG.
*/
/*int myRandom(uint8_t *dest, unsigned size)
{
	unsigned t = 0;
	uint32_t r = 0;
	uint8_t l = 0;
	for(t=0;t<size;t++)
	{
		// Rand returns a 4-byte number
		r = rand();

		// Take the least significant byte
		l = r & 0x000000FF;

		dest[t] = l;
	}

	return 1;
}*/

int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len, size_t *olen)
{
	mss_rtc_calendar_t calendar_count;
	MSS_RTC_get_calendar_count(&calendar_count);

	// apparently, using mktime requires an extra 5KB of binary size - out of question.
	/*struct tm ptm;

	ptm.tm_sec = calendar_count.second;
	ptm.tm_min = calendar_count.minute;
	ptm.tm_hour = calendar_count.hour;
	ptm.tm_mday = calendar_count.day;
	ptm.tm_mon = calendar_count.month-1; // time works with months since january (0 being jan) while RTC works with 1 to 12
	ptm.tm_year = calendar_count.year+100; // time works with years since 1900, while RTC works with years since 2009
	ptm.tm_wday = calendar_count.weekday-1; // time works with days since sunday 80 being sunday) while RTC works with 1-7

	uint32_t timer = mktime(&ptm);*/

	// instead, let's do some modifications to the structure we have
	// we're going to use the hardware RNG so this doesn't really matter!
	uint32_t timer = calendar_count.second + calendar_count.minute*60 + calendar_count.hour*60*60 + calendar_count.day*24*60*60 + calendar_count.month*30*24*60*60;

	MSS_RTC_clear_update_flag();

    *olen = 0;

    if( len < sizeof(uint32_t) )
        return(0);

    memcpy(output, &timer, sizeof(uint32_t));
    *olen = sizeof(uint32_t);

    return(0);
}
