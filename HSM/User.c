#include "User.h"
#include "drivers/mss_nvm/mss_nvm.h"

void USER_init()
{
	SPIFLASH_init();

	// TODO: we should get this list from the eNVM
	memset(SPIFLASH_UserList, 0, FLASH_MAX_USER_BLOCKS);
	SPIFLASH_totalUsers = 0;
	uint32_t i;

	uint8_t temp[2] = {0};
	for(i=0;i<FLASH_MAX_USER_BLOCKS;i++)
	{
		SPIFLASH_UserList[i] = 0;

		// Read first 2 bytes of each SPI Flash block
		SPIFLASH_readBytes(i+1, temp, 2, FLASH_USERS_BASE_ADDRESS);

		if(temp[0] != 0x64) // 0x64 means the user exists
			temp[1] = 0;

		SPIFLASH_UserList[i] = temp[1]; // uid is in position 1
	}

	//NVM_write(0x60000000, SPIFLASH_UserList, sizeof(SPIFLASH_UserList), NVM_DO_NOT_LOCK_PAGE);
}

void USER_terminate()
{
	SPIFLASH_totalUsers = 0;
	memset(SPIFLASH_UserList, 0, FLASH_MAX_USER_BLOCKS);
}

uint8_t USER_getNextAvailableID()
{
	// No users?
	if(SPIFLASH_totalUsers == 0)
		return 1;

	if(SPIFLASH_totalUsers == MAX_USERS)
	{
		// NOT AVAILABLE!!
		// This should be checked before running this function
	}

	uint8_t ID;

	for(ID=1;ID<FLASH_MAX_USER_BLOCKS;ID++)
	{
		if(!USER_exists(ID))
			break;
	}

	return ID;
}

BOOL USER_isFull()
{
	if(SPIFLASH_totalUsers == FLASH_MAX_USER_BLOCKS)
		return TRUE;

	return FALSE;
}

BOOL USER_add(uint8_t ID, uint8_t * plainPIN)
{
	// Check if the user exists
	if(USER_exists(ID))
		return FALSE;

	USER * newUser = malloc(sizeof(USER));
	if(!newUser)
		return FALSE;

	// Store the hash
	uint8_t PIN[32] = {0};
	mbedtls_sha256(plainPIN, 32, PIN, 0);

	newUser->ID = ID;
	memcpy(newUser->PIN, PIN, HASHED_PIN_SIZE);

	// Generate key pair and store it
	newUser->privateKey = malloc(sizeof(uint8_t)*ECC_PRIVATE_KEY_SIZE);
	if(!newUser->privateKey)
	{
		free(newUser);
		return FALSE;
	}

	newUser->publicKey = malloc(sizeof(uint8_t)*ECC_PUBLIC_KEY_SIZE);
	if(!newUser->publicKey)
	{
		free(newUser);
		return FALSE;
	}

	newUser->publicKeyCertificate = NULL;

	if(!PKC_genKeyPair(newUser->publicKey, newUser->privateKey))
	{
		free(newUser);
		return FALSE;
	}

	SPIFLASH_UserList[ID-1] = ID;
	SPIFLASH_totalUsers++;

	// Enough space for block size
	memset(global_buffer, 0, GLOBAL_BUFFER_SIZE);

	/*
	 *
	 * Write into buffer in the following format:
	 * 1B: 0x64
	 * 1B: ID
	 * 32B: PIN
	 * XB: Private Key
	 * YB: Public Key
	 * ZB Public Key Certificate
	 *
	 */
	memset(global_buffer, 0x64, 1); // user exists (0x64)
	memset(&global_buffer[1], ID, 1);
	memcpy(global_buffer+2, newUser->PIN, HASHED_PIN_SIZE);
	uint32_t l0 = 2+HASHED_PIN_SIZE;

	memcpy(global_buffer+l0, newUser->privateKey, strlen(newUser->privateKey)+1);
	uint32_t l1 = strlen(newUser->privateKey)+1;

	memcpy(global_buffer+l0+l1, newUser->publicKey, strlen(newUser->publicKey)+1);
	uint32_t l2 = strlen(newUser->publicKey)+1;

	uint32_t pos = l0+l1+l2;
	uint8_t SUBJECT_NAME[50] = {0};
	sprintf(SUBJECT_NAME, "CN=User %d, O=HSM, C=PT", newUser->ID);
	if(!PKC_createCertificate(newUser->publicKey, SUBJECT_NAME, MBEDTLS_X509_KU_DIGITAL_SIGNATURE, &global_buffer[pos], FLASH_BLOCK_SIZE-pos))
	{
		free(newUser->publicKey);
		free(newUser->privateKey);
		free(newUser);
		return FALSE;
	}

	SPIFLASH_writeBlock(ID, global_buffer, FLASH_USERS_BASE_ADDRESS);

	// TODO: Update hash in eNVM

	free(newUser->publicKey);
	free(newUser->privateKey);
	USER_free(newUser);

	SPIFLASH_UserList[ID-1] = ID;

	return TRUE;
}

// Modify a user's PIN
BOOL USER_modify(USER *user)
{
	// Check if the user exists
	if(!USER_exists(user->ID))
		return FALSE;

	// Enough space for block size
	memset(global_buffer, 0, GLOBAL_BUFFER_SIZE);

	/*
	 * Write into buffer in the following format:
	 * 1B: 0x64
	 * 1B: ID
	 * 32B: PIN
	 * XB: Private Key
	 * YB: Public Key
	 * ZB Public Key Certificate
	 *
	 */
	memset(global_buffer, 0x64, 1); // user exists (0x64)
	memset(&global_buffer[1], user->ID, 1);
	memcpy(global_buffer+2, user->PIN, HASHED_PIN_SIZE);
	uint32_t l0 = 2+HASHED_PIN_SIZE;

	memcpy(global_buffer+l0, user->privateKey, strlen(user->privateKey)+1);
	uint32_t l1 = strlen(user->privateKey)+1;

	memcpy(global_buffer+l0+l1, user->publicKey, strlen(user->publicKey)+1);
	uint32_t l2 = strlen(user->publicKey)+1;

	memcpy(global_buffer+l0+l1+l2, user->publicKeyCertificate, strlen(user->publicKeyCertificate)+1);

	SPIFLASH_writeBlock(user->ID, global_buffer, FLASH_USERS_BASE_ADDRESS);

	// TODO: Update hash in eNVM

	return TRUE;
}

USER * USER_get(uint8_t ID)
{
	if(!USER_exists(ID))
	{
		return NULL;
	}

	// Calculate block size
	memset(global_buffer, 0, GLOBAL_BUFFER_SIZE);

	SPIFLASH_readBlock(ID, global_buffer, FLASH_USERS_BASE_ADDRESS);

	// TODO: Compute hash and check against eNVM's

	// Has the user been set?
	if(global_buffer[0] != 0x64)
		return NULL;

	/*
	 * Read from buffer in of the following format:
	 * 1B: 0x64
	 * 1B: ID
	 * 32B: PIN
	 * XB: Private Key
	 * YB: Public Key
	 * ZB Public Key Certificate
	 *
	 */

	USER * newUser = malloc(sizeof(USER));
	if(!newUser)
		return NULL;

	newUser->ID = global_buffer[1];
	memcpy(newUser->PIN, global_buffer+2, HASHED_PIN_SIZE);

	// allocate private, public and certificate
	newUser->privateKey = malloc(sizeof(uint8_t)*ECC_PRIVATE_KEY_SIZE);
	if(!newUser->privateKey)
		return NULL;

	newUser->publicKey = malloc(sizeof(uint8_t)*ECC_PUBLIC_KEY_SIZE);
	if(!newUser->publicKey)
		return NULL;

	newUser->publicKeyCertificate = malloc(sizeof(uint8_t)*ECC_PUBLIC_KEY_CERT_SIZE);
	if(!newUser->publicKeyCertificate)
		return NULL;

	// Start at x=2+HASHED_PIN_SIZE and stop when we find 0 or '\0' (should be the same but mbedTLS checks both...)
	int x;
	int cert_end = 0;
	for(x=2+HASHED_PIN_SIZE;x<FLASH_BLOCK_SIZE;x++)
	{
		if(global_buffer[x] == 0 || global_buffer[x] == '\0')
		{
			// Finished it
			cert_end = x+1; // this character counts
			break;
		}
	}
	size_t prikeysize = cert_end-(2+HASHED_PIN_SIZE);
	memcpy(newUser->privateKey, global_buffer+2+HASHED_PIN_SIZE, prikeysize);

	// Public Key
	x = 0;
	cert_end = 0;
	for(x=2+HASHED_PIN_SIZE+prikeysize;x<FLASH_BLOCK_SIZE;x++)
	{
		if(global_buffer[x] == 0 || global_buffer[x] == '\0')
		{
			// Finished it
			cert_end = x+1; // this character counts
			break;
		}
	}
	size_t pubkeysize = cert_end-(2+HASHED_PIN_SIZE+prikeysize);
	memcpy(newUser->publicKey, global_buffer+2+HASHED_PIN_SIZE+prikeysize, pubkeysize);

	// Public Key Certificate
	x = 0;
	cert_end = 0;
	for(x=2+HASHED_PIN_SIZE+prikeysize+pubkeysize;x<FLASH_BLOCK_SIZE;x++)
	{
		if(global_buffer[x] == 0 || global_buffer[x] == '\0')
		{
			// Finished it
			cert_end = x+1; // this character counts
			break;
		}
	}
	size_t certsize = cert_end-(2+HASHED_PIN_SIZE+prikeysize+pubkeysize);
	memcpy(newUser->publicKeyCertificate, global_buffer+2+HASHED_PIN_SIZE+prikeysize+pubkeysize, certsize);

	return newUser;
}

// Zeroizes block ID-1
void USER_remove(uint8_t ID)
{
	SPIFLASH_eraseBlock(ID, FLASH_USERS_BASE_ADDRESS);
	SPIFLASH_UserList[ID-1] = 0;
}

// check if a plain-text PIN matches the admin pin
BOOL USER_isAdmin(uint8_t * PIN)
{
	// Calculate hash of ADMIN_PIN and compare with PIN (second param of comparePIN must be a hash)
	uint8_t HASH_ADMIN_PIN[32] = {0};
	mbedtls_sha256(ADMIN_PIN, 32, HASH_ADMIN_PIN, 0);

	// Attempt to perform admin login
	if(!USER_comparePIN(PIN, HASH_ADMIN_PIN))
	{
		return FALSE;
	}

	return TRUE;
}

BOOL USER_comparePIN(uint8_t * plainP1, uint8_t * P2)
{
	// Calculate hash of plainP1 and compare with P2 (P2 must always be a hash)
	uint8_t P1[32] = {0};
	mbedtls_sha256(plainP1, 32, P1, 0);

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
	if(SPIFLASH_UserList[ID-1] == 0)
		return FALSE;

	return TRUE;
}

// Verify if ID matches P1
BOOL USER_verify(uint8_t ID, uint8_t * P1)
{
	if(ID == 0)
	{
		// Admin
		if(!USER_isAdmin(P1))
		{
			return FALSE;
		}

		return TRUE;
	}

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
		USER_free(u);
		return FALSE;
	}

	USER_free(u);
	return TRUE;
}

void USER_free(USER * u)
{
	if(u == NULL)
		return;

	if(u->publicKey != NULL)
		free(u->publicKey);
	if(u->privateKey != NULL)
		free(u->privateKey);
	if(u->publicKeyCertificate != NULL)
		free(u->publicKeyCertificate);

	free(u);
}

