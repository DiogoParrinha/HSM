#pragma once
#ifndef PKCS11_COMMON_H
#define PKCS11_COMMON_H

#define CRYPTOKI_EXPORTS
#include "cryptoki.h"

typedef struct p11_token_s {
	CK_TOKEN_INFO tokenInfo;
} p11_token;

typedef struct p11_slot_s {
	CK_SLOT_INFO slotInfo;
	p11_token* token;
} p11_slot;

#define P11_NUM_OPS 3
#define P11_OP_FIND 0
#define P11_OP_SIGN 1 
#define P11_OP_VERIFY 2

typedef struct p11_session_s {
	CK_SESSION_INFO_PTR session;
	int operation[P11_NUM_OPS];
	bool update;
	uint8_t *signData; // holds plain-text data for multi-part operations
	uint32_t signData_s; // holds the data size

	uint8_t *verifyData; // holds plain-text data for multi-part operations
	uint32_t verifyData_s; // holds the data size

	/*
	bool certAlready; // already got it?
	uint8_t certUID; // uid of the public key owner
	*/
} p11_session;

#endif