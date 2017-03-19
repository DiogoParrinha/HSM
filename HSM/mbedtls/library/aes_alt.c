/*
 *  FIPS-197 compliant AES implementation
 *
 *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
 *  SPDX-License-Identifier: Apache-2.0
 *
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may
 *  not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 *  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 *  This file is part of mbed TLS (https://tls.mbed.org)
 */
/*
 *  The AES block cipher was designed by Vincent Rijmen and Joan Daemen.
 *
 *  http://csrc.nist.gov/encryption/aes/rijndael/Rijndael.pdf
 *  http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf
 */

#if !defined(MBEDTLS_CONFIG_FILE)
#include "mbedtls/config.h"
#else
#include MBEDTLS_CONFIG_FILE
#endif

#if defined(MBEDTLS_AES_C)

#include <string.h>

#include "mbedtls/aes.h"
#if defined(MBEDTLS_PADLOCK_C)
#include "mbedtls/padlock.h"
#endif
#if defined(MBEDTLS_AESNI_C)
#include "mbedtls/aesni.h"
#endif

#include "../../drivers/mss_sys_services/mss_sys_services.h"

#if defined(MBEDTLS_AES_ALT)

void mbedtls_aes_init( mbedtls_aes_context *ctx )
{
    memset( ctx, 0, sizeof( mbedtls_aes_context ) );
}

void mbedtls_aes_free( mbedtls_aes_context *ctx )
{
    if( ctx == NULL )
        return;

    memset(ctx->enc_key, 0, 32);
    memset(ctx->dec_key, 0, 32);
}

/*
 * AES key schedule (encryption)
 */
int mbedtls_aes_setkey_enc( mbedtls_aes_context *ctx, const unsigned char *key,
                    unsigned int keybits )
{
	if(keybits != 256)
		return 1;
	
	memcpy(ctx->enc_key, key, 32);
	
	return(0);
}

/*
 * AES key schedule (decryption)
 */
int mbedtls_aes_setkey_dec( mbedtls_aes_context *ctx, const unsigned char *key,
                    unsigned int keybits )
{
	if(keybits != 256)
		return 1;
	
	memcpy(ctx->dec_key, key, 32);
	
    return(0);
}

/*
 * AES-ECB block encryption/decryption
 */
int mbedtls_aes_crypt_ecb( mbedtls_aes_context *ctx,
                    int mode,
                    const unsigned char input[16],
                    unsigned char output[16] )
{
	uint8_t imode;
	uint8_t *key;
	if(mode == MBEDTLS_AES_DECRYPT)
	{
		imode = MSS_SYS_ECB_DECRYPT;
		key = ctx->dec_key;
	}
	else
	{
		imode = MSS_SYS_ECB_ENCRYPT;
		key = ctx->enc_key;
	}
	
	uint8_t IV[16] = {0};
	uint8_t status = MSS_SYS_256bit_aes(key, &IV[0], 1, imode, &output[0], &input[0]);
	if(status != MSS_SYS_SUCCESS)
		return 1;

    return( 0 );
}

#if defined(MBEDTLS_CIPHER_MODE_CBC)
/*
 * AES-CBC buffer encryption/decryption
 */
int mbedtls_aes_crypt_cbc( mbedtls_aes_context *ctx,
                    int mode,
                    size_t length,
                    unsigned char iv[16],
                    const unsigned char *input,
                    unsigned char *output )
{
	uint8_t imode;
	uint8_t *key;
	uint8_t backupIV[16] = {0};

	if( length % 16 )
		return( MBEDTLS_ERR_AES_INVALID_INPUT_LENGTH );

	size_t last = 0;
	if(mode == MBEDTLS_AES_DECRYPT)
	{
		imode = MSS_SYS_CBC_DECRYPT;
		key = ctx->dec_key;

		// IV of the next is the last input block (ciphertext)
		last = (length / 16)-1;
		memcpy(backupIV, &input[last*16], 16);
	}
	else
	{
		imode = MSS_SYS_CBC_ENCRYPT;
		key = ctx->enc_key;
	}

	size_t nblocks = length/16; // compute total 128-bit blocks
	
	uint8_t status = MSS_SYS_256bit_aes(key, &iv[0], nblocks, imode, &output[0], &input[0]);
	if(status != MSS_SYS_SUCCESS)
		return 1;

	if(mode == MBEDTLS_AES_ENCRYPT)
	{
		// IV of the next is the last output block (ciphertext)
		size_t last = (length / 16)-1;
		memcpy(&iv[0], &output[last*16], 16);
	}
	else
	{
		memcpy(&iv[0], backupIV, 16);
	}

    return( 0 );
}
#endif /* MBEDTLS_CIPHER_MODE_CBC */

#if defined(MBEDTLS_CIPHER_MODE_CFB)
/*
 * AES-CFB128 buffer encryption/decryption
 */
int mbedtls_aes_crypt_cfb128( mbedtls_aes_context *ctx,
                       int mode,
                       size_t length,
                       size_t *iv_off,
                       unsigned char iv[16],
                       const unsigned char *input,
                       unsigned char *output )
{
	uint8_t imode;
	uint8_t *key;
	if(mode == MBEDTLS_AES_DECRYPT)
	{
		imode = MSS_SYS_CFB_DECRYPT;
		key = ctx->dec_key;
	}
	else
	{
		imode = MSS_SYS_CFB_ENCRYPT;
		key = ctx->enc_key;
	}
	
	if(iv_off != 0)
		return 1;

	size_t nblocks = length/16; // compute total 128-bit blocks
	
	uint8_t status = MSS_SYS_256bit_aes(key, &iv[0], nblocks, imode, &output[0], &input[0]);
	if(status != MSS_SYS_SUCCESS)
		return 1;

    return( 0 );
}

/*
 * AES-CFB8 buffer encryption/decryption
 */
int mbedtls_aes_crypt_cfb8( mbedtls_aes_context *ctx,
                       int mode,
                       size_t length,
                       unsigned char iv[16],
                       const unsigned char *input,
                       unsigned char *output )
{
	uint8_t imode;
	uint8_t *key;
	if(mode == MBEDTLS_AES_DECRYPT)
	{
		imode = MSS_SYS_CFB_DECRYPT;
		key = ctx->dec_key;
	}
	else
	{
		imode = MSS_SYS_CFB_ENCRYPT;
		key = ctx->enc_key;
	}

	size_t nblocks = length/16; // compute total 128-bit blocks
	
	uint8_t status = MSS_SYS_256bit_aes(key, &iv[0], nblocks, imode, &output[0], &input[0]);
	if(status != MSS_SYS_SUCCESS)
		return 1;

    return( 0 );
}
#endif /*MBEDTLS_CIPHER_MODE_CFB */

#if defined(MBEDTLS_CIPHER_MODE_CTR)
/*
 * AES-CTR buffer encryption/decryption
 */
int mbedtls_aes_crypt_ctr( mbedtls_aes_context *ctx,
                       size_t length,
                       size_t *nc_off,
                       unsigned char nonce_counter[16],
                       unsigned char stream_block[16],
                       const unsigned char *input,
                       unsigned char *output )
{
	uint8_t imode;
	uint8_t *key;
	if(mode == MBEDTLS_AES_DECRYPT)
	{
		imode = MSS_SYS_CTR_DECRYPT;
		key = ctx->dec_key;
	}
	else
	{
		imode = MSS_SYS_CTR_ENCRYPT;
		key = ctx->enc_key;
	}
	
	if(nc_off != 0)
		return 1;

	size_t nblocks = length/16; // compute total 128-bit blocks
	
	uint8_t status = MSS_SYS_256bit_aes(key, &nonce_counter[0], nblocks, imode, &output[0], &input[0]);
	if(status != MSS_SYS_SUCCESS)
		return 1;

    return( 0 );
}
#endif /* MBEDTLS_CIPHER_MODE_CTR */

#endif /* !MBEDTLS_AES_ALT */

#endif /* MBEDTLS_AES_C */
