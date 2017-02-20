/*
 * SecComm.h
 *
 *  Created on: 20/02/2017
 *      Author: diogo
 */

#ifndef SECCOMM_H_
#define SECCOMM_H_

#include "common.h"
#include "Command.h"
#include "mbedtls/ecdh.h"

mbedtls_ecdh_context ctx_cli, ctx_srv;
unsigned char srv_to_cli[32], cli_to_srv[32];
mbedtls_entropy_context SecComm_entropy;
mbedtls_ctr_drbg_context SecComm_ctr_drbg;

BOOL SecComm_establishSessionKey(uint8_t * sessionKey);
BOOL SecComm_validateSessionKey(uint8_t * key);
BOOL SecComm_start(uint8_t * key);

#endif /* SECCOMM_H_ */
