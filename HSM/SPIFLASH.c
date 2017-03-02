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

	// Read FLASH_BLOCK_SIZE bytes
	FLASH_read(addr, buffer, FLASH_BLOCK_SIZE);
}

// Store all registered users in SPI Flash
void SPIFLASH_writeBlock(uint8_t ID, uint8_t * buffer, uint32_t base_addr)
{
	uint32_t addr = base_addr+(ID-1)*FLASH_BLOCK_SIZE;

	// Erase 4KB block
	FLASH_erase_4k_block(addr);

	// Flash the buffer (chunks of 256B)
	uint32_t chunks = FLASH_BLOCK_SIZE/256;

	uint32_t c=0;
	uint32_t bytes = 0;
	for(c=0;c<chunks;c++)
	{
		FLASH_program(addr+256*c, buffer+256*c, 256);
		bytes += 256;
	}

	if(bytes < FLASH_BLOCK_SIZE)
	{
		uint32_t remaining = FLASH_BLOCK_SIZE-bytes;
		FLASH_program(addr+256*c, buffer+256*c, remaining);
	}
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

