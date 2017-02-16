#ifndef USER_H
#define USER_H

#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include "UART.h"
#include "Common.h"
#include "SPIFLASH.h"

typedef struct USER {
	uint8_t PIN[PIN_SIZE];
	uint8_t ID;
	uint8_t privateKey[ECC_PRIVATE_KEY_SIZE];
	uint8_t publicKey[ECC_PUBLIC_KEY_STORE_SIZE];
} USER;

#define HASHED_PIN_SIZE (uint8_t)32
#define PIN_SIZE (uint8_t)32
#define ADMIN_ID (uint8_t)0
#define ADMIN_PIN (uint8_t*)"12345678912345678912345678912345"

BOOL USER_comparePIN(uint8_t * P1, uint8_t * P2);
USER * USER_getUser(uint8_t ID);

void USER_init();
void USER_terminate();
USER * USER_get(uint8_t ID);
USER * USER_add(uint8_t ID, uint8_t * PIN);
void USER_remove(uint8_t ID);
BOOL USER_modify(USER *user);
BOOL USER_exists(uint8_t ID);
BOOL USER_isAdmin(uint8_t * PIN);
BOOL USER_verify(uint8_t ID, uint8_t * PIN);
uint8_t USER_getNextAvailableID();
BOOL USER_isFull();

#endif // USER_H
