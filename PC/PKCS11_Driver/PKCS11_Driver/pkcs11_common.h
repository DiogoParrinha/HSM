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

#endif