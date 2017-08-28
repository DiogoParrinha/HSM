#include "SPIFLASH.h"
#include "drivers/mss_pdma/mss_pdma.h"
#include "drivers/mss_spi/mss_spi.h"
#include "drivers/w25q64fvssig/w25q64fvssig.h"

void SPIFLASH_init()
{
	//Flash Driver Initialization
	FLASH_init();
	FLASH_global_unprotect();

	//SPIFLASH_eraseAll();
}

void SPIFLASH_terminate()
{
}

// Read a block from the SPI Flash
void SPIFLASH_readBytes(uint8_t ID, uint8_t * buffer, uint32_t len, uint32_t base_addr)
{
	uint32_t addr = base_addr+(ID-1)*FLASH_BLOCK_SIZE;

	memset(buffer, 0, len);

	// Read len bytes
	FLASH_read(addr, buffer, len);
}

// Read a block from the SPI Flash
void SPIFLASH_readBlock(uint8_t ID, uint8_t * buffer, uint32_t base_addr)
{
	uint32_t addr = base_addr+(ID-1)*FLASH_BLOCK_SIZE;

	memset(buffer, 0, FLASH_BLOCK_SIZE);
	memset(&global_buffer[FLASH_BLOCK_SIZE], 0, FLASH_BLOCK_SIZE);

	// Decrypt data into buffer
	if(ENCRYPT_SPI_FLASH == 1)
	{
		// Read FLASH_BLOCK_SIZE bytes into second part of the global buffer (the first is being used by an outer function for sure)
		FLASH_read(addr, &global_buffer[FLASH_BLOCK_SIZE], FLASH_BLOCK_SIZE);

		mbedtls_aes_context aes_ctx;
		mbedtls_aes_init(&aes_ctx);
		mbedtls_aes_setkey_dec(&aes_ctx, FLASH_ENCRYPT_KEY, 256);
		char IV[16] = {0};
		switch(ID-1)
		{
			case 0:
				memcpy(IV, FLASH_ENCRYPT_IV0, 16);
				break;
			case 1:
				memcpy(IV, FLASH_ENCRYPT_IV1, 16);
				break;
			case 2:
				memcpy(IV, FLASH_ENCRYPT_IV2, 16);
				break;
			case 3:
				memcpy(IV, FLASH_ENCRYPT_IV3, 16);
				break;
			case 4:
				memcpy(IV, FLASH_ENCRYPT_IV4, 16);
				break;
			case 5:
				memcpy(IV, FLASH_ENCRYPT_IV5, 16);
				break;
			case 6:
				memcpy(IV, FLASH_ENCRYPT_IV6, 16);
				break;
			default:
				memcpy(IV, FLASH_ENCRYPT_IV, 16);
		}

		mbedtls_aes_crypt_cbc(&aes_ctx, MBEDTLS_AES_DECRYPT, FLASH_BLOCK_SIZE, IV, &global_buffer[FLASH_BLOCK_SIZE], &buffer[0]);
		mbedtls_aes_free(&aes_ctx);
	}
	else
		FLASH_read(addr, &global_buffer[0], FLASH_BLOCK_SIZE);
}

// Store all registered users in SPI Flash
void SPIFLASH_writeBlock(uint8_t ID, uint8_t * buffer, uint32_t base_addr)
{
	uint32_t addr = base_addr+(ID-1)*FLASH_BLOCK_SIZE;

	// Erase 4KB block
	FLASH_erase_4k_block(addr);

	// Flash the buffer (chunks of 256B)
	uint32_t chunks = FLASH_BLOCK_SIZE/256;

	if(ENCRYPT_SPI_FLASH == 1)
	{
		// Encrypt data into the second part of the global buffer (the first is being used by an outter function for sure)
		mbedtls_aes_context aes_ctx;
		mbedtls_aes_init(&aes_ctx);
		mbedtls_aes_setkey_enc(&aes_ctx, FLASH_ENCRYPT_KEY, 256);
		char IV[16] = {0};
		switch(ID-1)
		{
			case 0:
				memcpy(IV, FLASH_ENCRYPT_IV0, 16);
				break;
			case 1:
				memcpy(IV, FLASH_ENCRYPT_IV1, 16);
				break;
			case 2:
				memcpy(IV, FLASH_ENCRYPT_IV2, 16);
				break;
			case 3:
				memcpy(IV, FLASH_ENCRYPT_IV3, 16);
				break;
			case 4:
				memcpy(IV, FLASH_ENCRYPT_IV4, 16);
				break;
			case 5:
				memcpy(IV, FLASH_ENCRYPT_IV5, 16);
				break;
			case 6:
				memcpy(IV, FLASH_ENCRYPT_IV6, 16);
				break;
			default:
				memcpy(IV, FLASH_ENCRYPT_IV, 16);
		}
		mbedtls_aes_crypt_cbc(&aes_ctx, MBEDTLS_AES_ENCRYPT, FLASH_BLOCK_SIZE, IV, buffer, &global_buffer[FLASH_BLOCK_SIZE]);
		mbedtls_aes_free(&aes_ctx);

		FLASH_program(addr, &global_buffer[FLASH_BLOCK_SIZE], FLASH_BLOCK_SIZE);
	}
	else
		FLASH_program(addr, global_buffer, FLASH_BLOCK_SIZE);

	/*uint32_t c=0;
	uint32_t bytes = 0;
	for(c=0;c<chunks;c++)
	{
		FLASH_program(addr+256*c, global_buffer+FLASH_BLOCK_SIZE+256*c, 256);
	}*/

}

BOOL SPIFLASH_eraseBlock(uint8_t ID, uint32_t base_addr)
{
	uint32_t addr = base_addr+(ID-1)*FLASH_BLOCK_SIZE;

	// Allocate enough space for block size
	uint32_t size = sizeof(uint8_t)*FLASH_BLOCK_SIZE;
	/*uint8_t * data = malloc(size);
	if(data == NULL)
	{
		// Not enough space
		return FALSE;
	}*/

	memset(global_buffer, 0, FLASH_BLOCK_SIZE);

	// Erase 4KB block at ID-1
	FLASH_erase_4k_block(addr);

	// Flash the buffer (chunks of 256B)
	uint32_t chunks = size/256;

	uint32_t c=0;
	uint32_t bytes = 0;
	for(c=0;c<chunks;c++)
	{
		FLASH_program(addr+256*c, global_buffer+256*c, 256);
		bytes += 256;
	}

	if(bytes < size)
	{
		uint32_t remaining = size-bytes;
		FLASH_program(addr+256*c, global_buffer+256*c, remaining);
	}

	//free(data);

	return TRUE;
}

void SPIFLASH_eraseAll()
{
	FLASH_chip_erase();
}

