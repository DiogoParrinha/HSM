/*
 * PKC.h
 *
 *  Created on: 10/02/2017
 *      Author: diogo
 */

#ifndef PKC_H_
#define PKC_H_

#include "common.h"
#include "mbedtls/pk.h"
#include "mbedtls/x509_crt.h"

#ifdef SECURITY_DEVICE
	// Use SRAM-PUF 32-Byte generator
	#define ENTROPY_MIN_BYTES_RELEASE 32
#else
	// Use a time-based modification algorithm to get 4 "random bytes"
	#define ENTROPY_MIN_BYTES_RELEASE 4
#endif

int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len, size_t *olen);
int PKC_init(mbedtls_pk_context *ctx, mbedtls_entropy_context * entropy, mbedtls_ctr_drbg_context * ctr_drbg, const char * pers, BOOL loadGroup);
BOOL PKC_genKeyPair(uint8_t * public, uint8_t * private);
BOOL PKC_signData(uint8_t * private, uint8_t * data, size_t data_len, uint8_t * signature, size_t * signature_len);
int PKC_verifySignature(uint8_t * public, uint8_t * data, size_t data_len, uint8_t * signature, size_t signature_len);
BOOL PKC_createCertificate(uint8_t* public, uint8_t * subject_name, uint16_t key_usage, uint8_t* certificate, uint32_t bufsize);
void PKC_free(mbedtls_pk_context *ctx, mbedtls_entropy_context * entropy, mbedtls_ctr_drbg_context * ctr_drbg);

#endif /* PKC_H_ */
