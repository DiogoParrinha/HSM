#include "User.h"
#include "PKC.h"
#include "drivers/mss_pdma/mss_pdma.h"
#include "drivers/mss_spi/mss_spi.h"
#include "drivers/w25q64fvssig/w25q64fvssig.h"
#include "drivers/mss_nvm/mss_nvm.h"

void USER_init()
{
	SPIFLASH_init();

	// TODO: we should get this list from the eNVM
	SPIFLASH_total = 0;
	uint32_t i;

	uint8_t temp[1] = {0};
	for(i=0;i<FLASH_MAX_BLOCKS;i++)
	{
		SPIFLASH_list[i] = 0;

		// Read first byte of each SPI Flash block
		SPIFLASH_readBytes(i+1, temp, 1);

		if(temp[0] == 255) // "reset value"
			temp[0] = 0;

		SPIFLASH_list[i] = temp[0];
	}

	//NVM_write(0x60000000, SPIFLASH_list, sizeof(SPIFLASH_list), NVM_DO_NOT_LOCK_PAGE);
}

void USER_terminate()
{
}

uint8_t USER_getNextAvailableID()
{
	// No users?
	if(SPIFLASH_total == 0)
		return 1;

	if(SPIFLASH_total == MAX_USERS)
	{
		// NOT AVAILABLE!!
		// This should be checked before running this function
	}

	uint8_t ID;

	for(ID=1;ID<FLASH_MAX_BLOCKS;ID++)
	{
		if(!USER_exists(ID))
			break;
	}

	return ID;
}

BOOL USER_isFull()
{
	if(SPIFLASH_total == FLASH_MAX_BLOCKS)
		return TRUE;

	return FALSE;
}

USER * USER_add(uint8_t ID, uint8_t * PIN)
{
	// Check if the user exists
	if(USER_exists(ID))
		return NULL;

	USER * newUser = malloc(sizeof(USER));
	newUser->ID = ID;
	memcpy(newUser->PIN, PIN, HASHED_PIN_SIZE);

	// Generate key pair and store it
	uint8_t private[ECC_PRIVATE_KEY_SIZE] = {0};
	uint8_t public[ECC_PUBLIC_KEY_STORE_SIZE] = {0};
	if(!PKC_genKeyPair(&private[0], &public[0]))
	{
		free(newUser);
		return NULL;
	}

	memcpy(newUser->privateKey, private, ECC_PRIVATE_KEY_SIZE);
	memcpy(newUser->publicKey, public, ECC_PUBLIC_KEY_STORE_SIZE);

	SPIFLASH_list[ID-1] = ID;
	SPIFLASH_total++;

	// Allocate enough space for block size
	uint32_t size = sizeof(uint8_t)*FLASH_BLOCK_SIZE;
	uint8_t * data = malloc(size);
	if(data == NULL)
	{
		free(newUser);

		// Not enough space
		return NULL;
	}
	memset(data, 0, FLASH_BLOCK_SIZE);

	/*
	 * TODO: we should store the hash of the PIN, not the actual PIN
	 *
	 * Write into buffer in the following format:
	 * 1B: ID
	 * 32B: PIN
	 * XB: Private Key
	 * YB Public Key Certificate
	 *
	 */
	memset(data, ID, 1);
	memcpy(data+1, newUser->PIN, HASHED_PIN_SIZE);
	memcpy(data+1+HASHED_PIN_SIZE, newUser->privateKey, ECC_PRIVATE_KEY_SIZE);
	memcpy(data+1+HASHED_PIN_SIZE+ECC_PRIVATE_KEY_SIZE, newUser->publicKey, ECC_PUBLIC_KEY_STORE_SIZE);

	SPIFLASH_writeBlock(ID, data);

	free(data);

	return newUser;
}

BOOL USER_modify(USER *user)
{
	// Check if the user exists
	if(!USER_exists(user->ID))
		return FALSE;

	// Allocate enough space for block size
	uint32_t size = sizeof(uint8_t)*FLASH_BLOCK_SIZE;
	uint8_t * data = malloc(size);
	if(data == NULL)
	{
		// Not enough space
		return FALSE;
	}
	memset(data, 0, FLASH_BLOCK_SIZE);

	/*
	 * TODO: we should store the hash of the PIN, not the actual PIN
	 *
	 * Write into buffer in the following format:
	 * 1B: ID
	 * 32B: PIN
	 * XB: Private Key
	 * YB Public Key Certificate
	 *
	 */
	memset(data, user->ID, 1);
	memcpy(data+1, user->PIN, HASHED_PIN_SIZE);
	memcpy(data+1+HASHED_PIN_SIZE, user->privateKey, ECC_PRIVATE_KEY_SIZE);
	memcpy(data+1+HASHED_PIN_SIZE+ECC_PRIVATE_KEY_SIZE, user->publicKey, ECC_PUBLIC_KEY_STORE_SIZE);

	SPIFLASH_writeBlock(user->ID, data);

	free(data);

	return TRUE;
}

USER * USER_get(uint8_t ID)
{
	if(!USER_exists(ID))
	{
		return NULL;
	}
	// Allocate enough space for block size
	uint32_t size = sizeof(uint8_t)*FLASH_BLOCK_SIZE;
	uint8_t * data = malloc(size);
	if(data == NULL)
	{
		// Not enough space
		return NULL;
	}
	memset(data, 0, FLASH_BLOCK_SIZE);

	SPIFLASH_readBlock(ID, data);

	/*
	 *
	 * Read from buffer in of the following format:
	 * 1B: ID
	 * 32B: PIN
	 * XB: Private Key
	 * YB Public Key Certificate
	 *
	 */

	USER * newUser = malloc(sizeof(USER));
	newUser->ID = data[0];
	memmove(newUser->PIN, data+1, HASHED_PIN_SIZE);
	memmove(newUser->privateKey, data+1+HASHED_PIN_SIZE, ECC_PRIVATE_KEY_SIZE);
	memmove(newUser->publicKey, data+1+HASHED_PIN_SIZE+ECC_PRIVATE_KEY_SIZE, ECC_PUBLIC_KEY_STORE_SIZE);

	free(data);

	return newUser;
}

// Zeroizes block ID-1
void USER_remove(uint8_t ID)
{
	SPIFLASH_eraseBlock(ID);
}

BOOL USER_isAdmin(uint8_t * PIN)
{
	// Attempt to perform admin login
	if(!USER_comparePIN(PIN, ADMIN_PIN))
	{
		return FALSE;
	}

	return TRUE;
}

BOOL USER_comparePIN(uint8_t * P1, uint8_t * P2)
{
	// TODO: we should compare the hashes of both

	unsigned int i;
	for (i=0;i<HASHED_PIN_SIZE;i++)
	{
		if (P1[i] != P2[i])
			return FALSE;
	}

	return TRUE;
}

BOOL USER_exists(uint8_t ID)
{
	if(SPIFLASH_list[ID-1] == 0)
		return FALSE;

	return TRUE;
}

// Verify if ID matches P1
BOOL USER_verify(uint8_t ID, uint8_t * P1)
{
	if(!USER_exists(ID))
	{
		return FALSE;
	}

	USER * u = USER_get(ID);
	uint8_t P2[HASHED_PIN_SIZE] = {0};
	memcpy(P2, u->PIN, HASHED_PIN_SIZE);

	// P1 != P2 ?
	if(!USER_comparePIN(P1, P2))
	{
		return FALSE;
	}

	return TRUE;
}

