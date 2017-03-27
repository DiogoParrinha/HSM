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

typedef struct p11_object_s {
	CK_OBJECT_CLASS oClass;
	CK_KEY_TYPE oType;
	CK_BBOOL oToken;
	CK_BYTE_PTR oValue;
	CK_ULONG oValueLen;
} p11_object;

#define P11_NUM_OPS 2
#define P11_OP_SIGN 0
#define P11_OP_VERIFY 1

typedef struct p11_session_s {
	CK_SESSION_INFO_PTR session;
	int operation[P11_NUM_OPS];
	bool update;
	uint8_t *signData; // holds plain-text data for multi-part operations
	uint32_t signData_s; // holds the data size

	uint8_t *verifyData; // holds plain-text data for multi-part operations
	uint32_t verifyData_s; // holds the data size

	p11_object ** objects; // our array of pointers to session objects
	uint32_t totalObjects;
	
	/*
	bool certAlready; // already got it?
	uint8_t certUID; // uid of the public key owner
	*/
} p11_session;

#endif