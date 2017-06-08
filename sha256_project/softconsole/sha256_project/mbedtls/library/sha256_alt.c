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

#if defined(MBEDTLS_SELF_TEST)
#if defined(MBEDTLS_PLATFORM_C)
#include "mbedtls/platform.h"
#else
#include <stdio.h>
#include <stdlib.h>
#define mbedtls_printf printf
#define mbedtls_calloc    calloc
#define mbedtls_free       free
#endif /* MBEDTLS_PLATFORM_C */
#endif /* MBEDTLS_SELF_TEST */

#include "../../sha256_fpga.h"

#ifndef PUT_UINT32_BE
#define PUT_UINT32_BE(n,b,i)                            \
do {                                                    \
    (b)[(i)    ] = (unsigned char) ( (n) >> 24 );       \
    (b)[(i) + 1] = (unsigned char) ( (n) >> 16 );       \
    (b)[(i) + 2] = (unsigned char) ( (n) >>  8 );       \
    (b)[(i) + 3] = (unsigned char) ( (n)       );       \
} while( 0 )
#endif

#if defined(MBEDTLS_SHA256_ALT)

/* Implementation that should never be optimized out by the compiler */
static void mbedtls_zeroize( void *v, size_t n ) {
    volatile unsigned char *p = v; while( n-- ) *p++ = 0;
}

void mbedtls_sha256_init( mbedtls_sha256_context *ctx )
{
    memset( ctx, 0, sizeof( mbedtls_sha256_context ) );
}

void mbedtls_sha256_free( mbedtls_sha256_context *ctx )
{
    if( ctx == NULL )
        return;

    mbedtls_zeroize( ctx, sizeof( mbedtls_sha256_context ) );
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
    ctx->total[0] = 0;
    ctx->total[1] = 0;
    ctx->buffer_bytes = 0;
    ctx->first = 1;
    ctx->last = 0;
}

void mbedtls_sha256_process( mbedtls_sha256_context *ctx, const unsigned char data[64] )
{
	uint8_t hash[32] = {0};
	SHA256_FPGA(data, hash, ctx->buffer_bytes, ctx->first, ctx->last);

	// Copy hash to state
	memcpy(ctx->state, hash, 32);
}

/*
 * SHA-256 process buffer
 * Only sends to process multiple of 64B, otherwise keep filling the buffer
 */
void mbedtls_sha256_update( mbedtls_sha256_context *ctx, const unsigned char *input,
                    size_t ilen )
{
	if( ilen == 0 )
	{
		// are we finishing?
		if(ctx->buffer_bytes > 0 && ctx->last == 1)
		{
			// Send for processing
			mbedtls_sha256_process(ctx, ctx->buffer);
			ctx->buffer_bytes = 0;
			ctx->first = 0;
			ctx->last = 0;
		}
		else
			return;
	}

	// Determine whether or not if we have enough space in our buffer to hold the input data
    size_t fill;
    uint32_t left;

    left = ctx->total[0] & 0x3F;
    fill = 64 - left;

    ctx->total[0] += (uint32_t) ilen;
    ctx->total[0] &= 0xFFFFFFFF;

    if( ctx->total[0] < (uint32_t) ilen )
        ctx->total[1]++;

    if( left && ilen >= fill )
    {
    	// We don't have enough space
    	// But we still have some space left, copy whatever we can from the input to the buffer
    	// We'll still have some input left to process after this
        memcpy( (void *) (ctx->buffer + left), input, fill );

        // Send for processing
        mbedtls_sha256_process( ctx, ctx->buffer );
        input += fill;
        ilen  -= fill;
        left = 0;

        ctx->buffer_bytes = 0; // no bytes in buffer
        ctx->first = 0;
    }

    // For each remaining block of 64B of input, send for processing except the last one
    // If we have 64B in ilen, then this would be the last block, hence why we check > 64
    // meaning we'll always have more than 0 bytes if we process anything within the loop
    while( ilen > 64)
    {
    	memcpy((void *)ctx->buffer, input, 64);
    	ctx->buffer_bytes = 64;

        mbedtls_sha256_process( ctx, ctx->buffer);
        input += 64;
        ilen  -= 64;

        ctx->buffer_bytes = 0;
        ctx->first = 0;
    }

    // Copy the remaining input into the buffer
    if( ilen > 0)
    {
        memcpy( (void *) (ctx->buffer + left), input, ilen );
        ctx->buffer_bytes += ilen;
    }
}

/*
 * SHA-256 final digest
 */
void mbedtls_sha256_finish( mbedtls_sha256_context *ctx, unsigned char output[32] )
{
    // Attempt to finish the hashing process
    ctx->last = 1;
    uint8_t dummy[32];
    mbedtls_sha256_update( ctx, dummy, 0 );

    memcpy(output, ctx->state, 32);
}

#endif /* !MBEDTLS_SHA256_ALT */

#endif

