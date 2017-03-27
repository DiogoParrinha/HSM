/*
 *  FIPS-180-2 compliant SHA-256 implementation
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
 *  The SHA-256 Secure Hash Standard was published by NIST in 2002.
 *
 *  http://csrc.nist.gov/publications/fips/fips180-2/fips180-2.pdf
 */

#if !defined(MBEDTLS_CONFIG_FILE)
#include "mbedtls/config.h"
#else
#include MBEDTLS_CONFIG_FILE
#endif

#if defined(MBEDTLS_SHA256_C)

#include "mbedtls/sha256.h"

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#if defined(MBEDTLS_SHA256_ALT)

void mbedtls_sha256_init( mbedtls_sha256_context *ctx )
{
    memset( ctx, 0, sizeof( mbedtls_sha256_context ) );
}

void mbedtls_sha256_free( mbedtls_sha256_context *ctx )
{
    if( ctx == NULL )
        return;

    if(ctx->buffer != NULL)
    	free(ctx->buffer);
}

void mbedtls_sha256_clone( mbedtls_sha256_context *dst,
                           const mbedtls_sha256_context *src )
{
    *dst = *src;
}

/*
 * SHA-256 context setup
 */
void mbedtls_sha256_starts( mbedtls_sha256_context *ctx, int is224 )
{
    ctx->current_size = 0;
    ctx->buffer = NULL;
}

void mbedtls_sha256_process( mbedtls_sha256_context *ctx, const unsigned char data[64])
{
	// Not required
}

/*
 * SHA-256 process buffer
 */
void mbedtls_sha256_update( mbedtls_sha256_context *ctx, const unsigned char *input,
                    size_t ilen )
{
    if(ilen == 0)
        return;

    // Because the internal core takes care of padding and processes the whole message
	// We must simply realloc the buffer and add the new data to it
	// Unfortunately we cannot simply update the IV to the previously calculated hash
    ctx->buffer = realloc(ctx->buffer, ctx->current_size+ilen);
	if(ctx->buffer == NULL)
	{
		// Eventually we'll run out of memory...and the hash will fail
		// (even though these are void functions, in the end the hash will be wrong)
		volatile t = 0;
		t++;
		return;
	}

	memcpy(ctx->buffer+ctx->current_size, input, ilen*sizeof(unsigned char));
	ctx->current_size += ilen;
}

/*
 * SHA-256 final digest
 */
void mbedtls_sha256_finish( mbedtls_sha256_context *ctx, unsigned char output[32] )
{
	// Calculate hash
	uint8_t digest[32] = {0};
	uint8_t status = MSS_SYS_sha256(ctx->buffer, ctx->current_size*8, &output[0]);
	if(status != MSS_SYS_SUCCESS)
	{
		// we have no error handling in these function so we just set the output to 1
		memset(output, 1, 32*sizeof(unsigned char));

		free(ctx->buffer); // mandatory!

		return; // error
	}

    free(ctx->buffer);
}

#endif /* !MBEDTLS_SHA256_ALT */

#endif /* MBEDTLS_SHA256_C */
