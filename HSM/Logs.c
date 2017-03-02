#include "Logs.h"
#include "drivers/mss_nvm/mss_nvm.h"

//uint32_t LOGS_todaysCount = 0; // 0 - 4294967295

// Up to 18446744073709551616 entries
uint32_t LOGS_globalCounter1 = 0;
uint32_t LOGS_globalCounter2 = 0;

BOOL LOGS_sign(uint8_t * message, uint32_t data_len, uint8_t UID, uint8_t * finalMessage, uint8_t * signature, size_t * signature_len)
{
	if(data_len > 512)
		return FALSE;

	// Increase counter
	if((LOGS_globalCounter1 == UINT_MAX)) // a + x overflows?
	{
		LOGS_globalCounter2++;
	}
	else
		LOGS_globalCounter1++;

	// Append time (1B) and user ID (1B)
	memset(global_buffer, 0, GLOBAL_BUFFER_SIZE);
	global_buffer[0] = '"'; // separator
	memcpy(global_buffer+1, message, data_len);
	global_buffer[data_len+1] = '"'; // separator
	global_buffer[data_len+2] = '|'; // separator

	// time
	mss_rtc_calendar_t calendar_count;
	MSS_RTC_get_calendar_count(&calendar_count);
	uint8_t w = snprintf(global_buffer+data_len+3, GLOBAL_BUFFER_SIZE-3, "%02d:%02d:%02d,%d-%d-2%03d",
				 (int)calendar_count.day,
				 (int)calendar_count.month,
				 (int)calendar_count.year,
				 (int)calendar_count.second,
				 (int)calendar_count.minute,
				 (int)calendar_count.hour);
	MSS_RTC_clear_update_flag();

	global_buffer[data_len+3+w] = '|'; // separator
	global_buffer[data_len+4+w] = UID; // UID
	global_buffer[data_len+5+w] = '|'; // separator

	// counter
	uint8_t n = snprintf(global_buffer+data_len+6+w, GLOBAL_BUFFER_SIZE-data_len+6+w, "%10d,%10d",
			LOGS_globalCounter1, LOGS_globalCounter2);

	global_buffer[data_len+6+w+n] = '\0'; // end

	if(!PKC_signData(LOGS_PRIVATE_KEY, message, data_len, signature, signature_len))
	{
		return FALSE;
	}

	finalMessage = &global_buffer[0];

	return TRUE;
}

/*void LOGS_init()
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
}*/
