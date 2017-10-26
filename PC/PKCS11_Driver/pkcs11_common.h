/*
MIT License

Copyright (c) 2017 Diogo Parrinha

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
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