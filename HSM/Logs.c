#include "Logs.h"
#include "drivers/mss_pdma/mss_pdma.h"
#include "drivers/mss_spi/mss_spi.h"
#include "drivers/w25q64fvssig/w25q64fvssig.h"
#include "drivers/mss_nvm/mss_nvm.h"

uint32_t LOGS_todaysCount = 0; // 0 - 4294967295

// Up to 18446744073709551616 entries
uint32_t LOGS_globalCounter1 = 0;
uint32_t LOGS_globalCounter2 = 0;

void LOGS_init()
{
	SPIFLASH_init();
}

void LOGS_terminate()
{
}

BOOL LOGS_add(uint8_t * hash)
{
	// Calculate block size
	uint32_t size = sizeof(uint8_t)*FLASH_BLOCK_SIZE;
	memset(global_buffer, 0, FLASH_BLOCK_SIZE);

	SPIFLASH_readBlock(LOGS_CURRENT_DAY_BLOCK, global_buffer, FLASH_LOGS_BASE_ADDRESS);

	// TODO: Compute hash and check against eNVM's

	if(LOGS_todaysCount < LOGS_HASHES_PER_BLOCK)
	{
		// We can simply add it to the the queue
		LOGS_currentQueue[LOGS_todaysCount] = 1;
		LOGS_todaysCount++;

		// Append
		memcpy(&global_buffer[0]+(LOGS_todaysCount-1)*32, hash, 32);
	}
	else
	{
		// Shift by one to the left
		volatile uint32_t i;
		for(i=0;i<FLASH_BLOCK_SIZE-32;i+=32)
		{
			memmove(&global_buffer[0]+i, &global_buffer[0]+i+32, 32);
		}

		// Place the hash at the end
		memcpy(&global_buffer[0]+i, hash, 32);
	}

	SPIFLASH_writeBlock(LOGS_CURRENT_DAY_BLOCK, global_buffer, FLASH_LOGS_BASE_ADDRESS);

	return TRUE;
}
