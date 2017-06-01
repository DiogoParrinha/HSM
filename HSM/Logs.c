#include "Logs.h"
#include "drivers/mss_nvm/mss_nvm.h"
#include "mbedtls/base64.h"

//uint32_t LOGS_todaysCount = 0; // 0 - 4294967295

BOOL LOGS_sign(uint8_t * message, uint32_t data_len, uint8_t UID, uint8_t * signature, size_t * signature_len, uint8_t * prev_hash, uint8_t * hash)
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

	// Format: {base64(message)|date,time|ID|c1,c2|prev_hash}

	size_t olen = 0;
	if (mbedtls_base64_encode(&global_buffer[GLOBAL_BUFFER_SIZE], 4096, &olen, message, data_len) != 0)
	{
		return FALSE;
	}

	// time
	mss_rtc_calendar_t calendar_count;
	MSS_RTC_get_calendar_count(&calendar_count);
	uint8_t w = 0;

	// Append time (1B) and user ID (1B)
	global_buffer[w++] = '{'; // separator
	memcpy(global_buffer+(w++), &global_buffer[GLOBAL_BUFFER_SIZE], olen);
	olen--; // we use it as a pointer from now on so we must subtract 1
	global_buffer[olen+(w++)] = '|'; // separator

	w += snprintf(global_buffer+w+olen, GLOBAL_BUFFER_SIZE/2-(olen+w), "%d-%d-2%03d,%02d:%02d:%02d",
					 (int)calendar_count.day,
					 (int)calendar_count.month,
					 (int)calendar_count.year,
					 (int)calendar_count.hour,
					 (int)calendar_count.minute,
					 (int)calendar_count.second);

	global_buffer[olen+(w++)] = '|'; // separator

	w += snprintf(global_buffer+olen+w, GLOBAL_BUFFER_SIZE/2-(olen+w), "%d", UID);

	global_buffer[olen+(w++)] = '|'; // separator

	// counter
	w += snprintf(global_buffer+olen+w, GLOBAL_BUFFER_SIZE/2-(olen+w), "%10d,%10d", LOGS_globalCounter1, LOGS_globalCounter2);

	global_buffer[olen+(w++)] = '|'; // separator

	// prev hash goes here (base64)
	int i = 0;
	for(i=0;i<32;i++)
		w += snprintf(global_buffer+olen+w, GLOBAL_BUFFER_SIZE/2-(olen+w), "%02X", prev_hash[i]);

	global_buffer[olen+(w++)] = '}'; // end
	global_buffer[olen+(w++)] = '\0'; // end

	MSS_RTC_clear_update_flag();

	// Compute SHA-256
	mbedtls_sha256(global_buffer, olen+w-1, &hash[0], 0);

	if(!PKC_signData(LOGS_PRIVATE_KEY, hash, 32, signature, signature_len))
	{
		return FALSE;
	}

	return TRUE;
}


BOOL LOGS_init(uint8_t * message, uint32_t data_len, uint8_t UID, uint8_t * signature, size_t * signature_len, uint8_t * init_hash, uint8_t * hash)
{
	if(data_len > 512)
		return FALSE;

	memset(global_buffer, 0, GLOBAL_BUFFER_SIZE);

	// Format: {ROOT|message|date,time|hash_init}

	size_t olen = 0;
	if (mbedtls_base64_encode(&global_buffer[GLOBAL_BUFFER_SIZE], 4096, &olen, message, data_len) != 0)
	{
		return FALSE;
	}

	// time
	mss_rtc_calendar_t calendar_count;
	MSS_RTC_get_calendar_count(&calendar_count);
	uint8_t w = 0;

	// Append time (1B) and user ID (1B)
	global_buffer[w++] = '{'; // separator
	memcpy(global_buffer+w, "ROOT", 4);
	w += 4;
	global_buffer[(w++)] = '|'; // separator
	memcpy(global_buffer+(w++), &global_buffer[GLOBAL_BUFFER_SIZE], olen);
	olen--; // we use it as a pointer from now on so we must subtract 1
	global_buffer[olen+(w++)] = '|'; // separator

	w += snprintf(global_buffer+w+olen, GLOBAL_BUFFER_SIZE/2-(olen+w), "%d-%d-2%03d,%02d:%02d:%02d",
					 (int)calendar_count.day,
					 (int)calendar_count.month,
					 (int)calendar_count.year,
					 (int)calendar_count.hour,
					 (int)calendar_count.minute,
					 (int)calendar_count.second);

	global_buffer[olen+(w++)] = '|'; // separator

	// init hash goes here (base64)
	int i = 0;
	for(i=0;i<32;i++)
		w += snprintf(global_buffer+olen+w, GLOBAL_BUFFER_SIZE/2-(olen+w), "%02X", init_hash[i]);

	global_buffer[olen+(w++)] = '}'; // end
	global_buffer[olen+(w++)] = '\0'; // end

	MSS_RTC_clear_update_flag();

	// Compute SHA-256
	mbedtls_sha256(global_buffer, olen+w-1, &hash[0], 0);

	if(!PKC_signData(LOGS_PRIVATE_KEY, hash, 32, signature, signature_len))
	{
		return FALSE;
	}

	return TRUE;
}
