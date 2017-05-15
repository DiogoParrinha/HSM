#include "Logs.h"
#include "drivers/mss_nvm/mss_nvm.h"

//uint32_t LOGS_todaysCount = 0; // 0 - 4294967295

// Up to 18446744073709551616 entries
uint32_t LOGS_globalCounter1 = 0;
uint32_t LOGS_globalCounter2 = 0;

BOOL LOGS_sign(uint8_t * message, uint32_t data_len, uint8_t UID, uint8_t * finalMessage, uint8_t * signature, size_t * signature_len, uint8_t * prev_hash, uint8_t * hash)
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

	memset(global_buffer, 0, GLOBAL_BUFFER_SIZE);

	// time
	mss_rtc_calendar_t calendar_count;
	MSS_RTC_get_calendar_count(&calendar_count);
	uint8_t w = snprintf(global_buffer, GLOBAL_BUFFER_SIZE, "%d-%d-2%03d,%02d:%02d:%02d",
				 (int)calendar_count.day,
				 (int)calendar_count.month,
				 (int)calendar_count.year,
				 (int)calendar_count.hour,
				 (int)calendar_count.minute,
				 (int)calendar_count.second);

	// Append time (1B) and user ID (1B)
	global_buffer[w++] = ':'; // separator
	global_buffer[w++] = '{'; // separator
	global_buffer[w++] = '"'; // separator
	memcpy(global_buffer+(w++), message, data_len);
	data_len--; // we use it as a pointer from now on so we must subtract 1
	global_buffer[data_len+(w++)] = '"'; // separator
	global_buffer[data_len+(w++)] = '|'; // separator

	w += snprintf(global_buffer+w+data_len, GLOBAL_BUFFER_SIZE-(data_len+w), "%d-%d-2%03d,%02d:%02d:%02d",
					 (int)calendar_count.day,
					 (int)calendar_count.month,
					 (int)calendar_count.year,
					 (int)calendar_count.hour,
					 (int)calendar_count.minute,
					 (int)calendar_count.second);

	global_buffer[data_len+(w++)] = '|'; // separator

	w += snprintf(global_buffer+data_len+w, GLOBAL_BUFFER_SIZE-(data_len+w), "%d", UID);

	global_buffer[data_len+(w++)] = '|'; // separator

	// counter
	w += snprintf(global_buffer+data_len+w, GLOBAL_BUFFER_SIZE-(data_len+w), "%10d,%10d", LOGS_globalCounter1, LOGS_globalCounter2);

	global_buffer[data_len+(w++)] = '|'; // separator

	// prev hash goes here (base64)
	int i = 0;
	for(i=0;i<32;i++)
		w += snprintf(global_buffer+data_len+w, GLOBAL_BUFFER_SIZE-(data_len+w), "%02X", prev_hash[i]);

	global_buffer[data_len+(w++)] = '}'; // end
	global_buffer[data_len+(w++)] = '\0'; // end

	MSS_RTC_clear_update_flag();

	// Compute SHA-256
	mbedtls_sha256(global_buffer, data_len+w-1, &hash[0], 0);

	if(!PKC_signData(LOGS_PRIVATE_KEY, hash, 32, signature, signature_len))
	{
		return FALSE;
	}

	finalMessage = &global_buffer[0];

	return TRUE;
}
