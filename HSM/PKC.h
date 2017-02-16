/*
 * PKC.h
 *
 *  Created on: 10/02/2017
 *      Author: diogo
 */

#ifndef PKC_H_
#define PKC_H_

#include "common.h"

int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len, size_t *olen);
BOOL PKC_genKeyPair(uint8_t * private, uint8_t * public);
BOOL PKC_signData(uint8_t * private, uint8_t * data, size_t data_len, uint8_t * signature, size_t * signature_len);
BOOL PKC_verifySignature(uint8_t * public, uint8_t * data, size_t data_len, uint8_t * signature, size_t signature_len);
//int myRandom(uint8_t *dest, unsigned size);

#endif /* PKC_H_ */
