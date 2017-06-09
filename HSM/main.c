#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include "common.h"
#include "sha256_fpga.h"

// The need to reserve a defined block of SRAM when using PUF system services,
// to prevent the compiler from using the SRAM memory range from address
// 0x2000800 to 0x2000802F inclusive.
#if defined(__GNUC__)
static uint8_t __attribute__((section(".keycode2Section"))) g_key_code[48];
#endif

/*------------------------------------------------------------------------------
  Wakeup/alarm interrupt service routine.
 */
#if defined(__GNUC__)
__attribute__((__interrupt__)) void RTC_Wakeup_IRQHandler(void)
#else
void RTC_Wakeup_IRQHandler(void)
#endif
{
	UART_disconnect();
    MSS_RTC_clear_irq();
}


int main()
{
    /* Release USB Controller from Reset */
    //*(volatile uint32_t *)0x40038048 = 0x0;

	MSS_GPIO_init();
	MSS_GPIO_config( MSS_GPIO_0 , MSS_GPIO_OUTPUT_MODE );

#ifdef SECURITY_DEVICE
	MSS_GPIO_set_output( MSS_GPIO_0 , 0 );
#else
	MSS_GPIO_set_output( MSS_GPIO_0 , 1 );
#endif

	//MSS_UART_init(&g_mss_uart0, MSS_UART_57600_BAUD, MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);

	/* Disable Watchdog */
	SYSREG->WDOG_CR = 0x00000000;

	SHA256_FPGA_init();

	/*uint8_t text0[] = {
				0xFC, 0xFD, 0x4E, 0x71,
				0x41, 0xD5, 0xB5, 0x10,
				0x9C, 0xAF, 0x49, 0xCB,
				0xC7, 0x17, 0x70, 0xDA,
				0xC8, 0x4F, 0x8B, 0xEA,
				0xFE, 0x2D, 0x49, 0xAE,
				0xCF, 0x53, 0xDF, 0x1E,
				0xA0, 0x16, 0xE0, 0xAB,
				0xCC, 0x0A, 0x6C, 0xE7,
				0x49, 0x02, 0x79, 0xD3,
				0x73, 0x89, 0xD8, 0x21,
				0x0A, 0x8B, 0xFE, 0x76,
				0x25, 0x6A, 0xD2, 0xDD,
				0x4A, 0xDA, 0xE0, 0xFA,
				0x03, 0x7A, 0x45, 0x06,
				0x0F, 0x37, 0x1F, 0x49,
				0x31, 0x1E, 0x20, 0x59
	};*/

	/*uint8_t text0[] = {
			0x01, 0x01, 0x02, 0x04,
			0x00, 0x00, 0x00, 0x02,
			0x00, 0x00, 0x00, 0x03,
			0x00, 0x00, 0x00, 0x04,
			0x00, 0x00, 0x00, 0x05,
			0x00, 0x00, 0x00, 0x06,
			0x00, 0x00, 0x00, 0x07,
			0x00, 0x00, 0x00, 0x08,
			0x00, 0x00, 0x00, 0x09,
			0x00, 0x00, 0x00, 0x0A,
			0x00, 0x00, 0x00, 0x0B,
			0x00, 0x00, 0x00, 0x0C,
			0x00, 0x00, 0x00, 0x0D,
			0x00, 0x00, 0x00, 0x0E,
			0x00, 0x00, 0x00, 0x0F,
			0x00, 0x00, 0x00, 0x01,
			0x00, 0x00, 0x00, 0x01,
	};
	uint8_t hash[32] = {0};
    memset(hash, 0, 32);
    mbedtls_sha256(text0, 68, &hash[0], 0);
    int t = 0;
    t++;

    return 0;*/

	/*** USE RTC FOR TIME CONTROL ***/
	MSS_RTC_init(MSS_RTC_CALENDAR_MODE, RTC_PRESCALER);

	system_status = STATUS_DEFAULT;
	tamper_status = STATUS_DEFAULT;
	last_timestamp = 0;

	// Default admin PIN
	memcpy(ADMIN_PIN, "00000000000000000000000000000000", PIN_SIZE);
	if(USE_ENVM)
	{
		// Copy from eNVM (0x0020000)
		uint8_t hexPIN[64] = {0};
		memcpy(hexPIN, (void*)0x0020000, 64);
		hex2bin(hexPIN, (char*)ADMIN_PIN, 64);
	}

	// Write to eNVM (THIS IS A TEST)
	/*if(USE_ENVM)
	{
		// Update eNVM
		memcpy(ADMIN_PIN, "12345678912345678912345678912345", PIN_SIZE);
		uint8_t hexPIN[64] = {0};

		bin2hex(ADMIN_PIN, 32, hexPIN);

		nvm_status_t status = NVM_write(0x0020000, hexPIN, 64, NVM_DO_NOT_LOCK_PAGE);
		if(status != NVM_SUCCESS)
		{
			volatile int t = 0;
			t++;
		}
	}

	if(USE_ENVM)
	{
		// Copy from eNVM (0x0020000)
		uint8_t hexPIN[64] = {0};
		memcpy(hexPIN, (void*)0x0020000, 64);
		hex2bin(hexPIN, (char*)ADMIN_PIN, 64);
	}*/

	#ifdef SECURITY_DEVICE
		MSS_SYS_init(sys_services_event_handler);

		MSS_SYS_nrbg_reset();

		// Instantiate RNG
		uint8_t status;
		status = MSS_SYS_nrbg_instantiate(0, 0, &drbg_handle);
		if(status != MSS_SYS_SUCCESS)
		{
			return 1;
		}

		uint8_t key_numbers = 0u;

		/*MSS_SYS_puf_delete_activation_code();
		MSS_SYS_puf_create_activation_code();*/

		status = MSS_SYS_puf_get_number_of_keys(&key_numbers);

		// Only mark as initialized if we have at least 5 keys enrolled (2 factory; 4 custom)
		if(key_numbers == 7)
		{
			/*uint8_t g_my_user_key[512] = {0};
			MSS_SYS_puf_delete_activation_code();
			MSS_SYS_puf_create_activation_code();

			// Certs Key
			status = MSS_SYS_puf_enroll_key(2, 384 / 64, 0u, &g_my_user_key[0]);
			if(status != MSS_SYS_SUCCESS)
			{
			}

			// Logs Key
			status = MSS_SYS_puf_enroll_key(3, 384 / 64, 0u, &g_my_user_key[0]);
			if(status != MSS_SYS_SUCCESS)
			{
			}

			// Auth Key
			status = MSS_SYS_puf_enroll_key(4, 384 / 64, 0u, &g_my_user_key[0]);
			if(status != MSS_SYS_SUCCESS)
			{
			}

			// Flash Key
			status = MSS_SYS_puf_enroll_key(5, 256 / 64, 0u, &g_my_user_key[0]);
			if(status != MSS_SYS_SUCCESS)
			{
			}

			// Flash IV
			status = MSS_SYS_puf_enroll_key(6, 128 / 64, 0u, &g_my_user_key[0]);
			if(status != MSS_SYS_SUCCESS)
			{
			}*/

			uint8_t* p_my_user_key = (uint8_t*)&global_buffer;

			// certificates key pair
			status = MSS_SYS_puf_fetch_key(2, &p_my_user_key);
			if(status != MSS_SYS_SUCCESS)
			{
				return 2;
			}

			memset(ISSUER_PUBLIC_KEY, 0, ECC_PUBLIC_KEY_SIZE);
			memset(ISSUER_PRIVATE_KEY, 0, ECC_PRIVATE_KEY_SIZE);

			int ret = 0;
			ret = sys_keys_to_pem(p_my_user_key, ISSUER_PUBLIC_KEY, ECC_PUBLIC_KEY_SIZE, ISSUER_PRIVATE_KEY, ECC_PRIVATE_KEY_SIZE);
			if(ret != 0)
			{
				return 3;
			}

			// logs key pair
			status = MSS_SYS_puf_fetch_key(3, &p_my_user_key);
			if(status != MSS_SYS_SUCCESS)
			{
				return 2;
			}

			memset(LOGS_PUBLIC_KEY, 0, ECC_PUBLIC_KEY_SIZE);
			memset(LOGS_PRIVATE_KEY, 0, ECC_PRIVATE_KEY_SIZE);

			ret = sys_keys_to_pem(p_my_user_key, LOGS_PUBLIC_KEY, ECC_PUBLIC_KEY_SIZE, LOGS_PRIVATE_KEY, ECC_PRIVATE_KEY_SIZE);
			if(ret != 0)
			{
				return 3;
			}

			// session establishment key pair
			status = MSS_SYS_puf_fetch_key(4, &p_my_user_key);
			if(status != MSS_SYS_SUCCESS)
			{
				return 2;
			}

			memset(SESS_PUBLIC_KEY, 0, ECC_PUBLIC_KEY_SIZE);
			memset(SESS_PRIVATE_KEY, 0, ECC_PRIVATE_KEY_SIZE);

			ret = sys_keys_to_pem(p_my_user_key, SESS_PUBLIC_KEY, ECC_PUBLIC_KEY_SIZE, SESS_PRIVATE_KEY, ECC_PRIVATE_KEY_SIZE);
			if(ret != 0)
			{
				return 3;
			}

			// SPI flash encrypt key
			status = MSS_SYS_puf_fetch_key(5, &p_my_user_key);
			if(status != MSS_SYS_SUCCESS)
			{
				return 2;
			}

			memset(FLASH_ENCRYPT_KEY, 0, 32);
			memcpy(&FLASH_ENCRYPT_KEY[0], &p_my_user_key[0], 32u);

			// SPI flash IV
			status = MSS_SYS_puf_fetch_key(6, &p_my_user_key);
			if(status != MSS_SYS_SUCCESS)
			{
				return 2;
			}

			memset(FLASH_ENCRYPT_IV, 0, 16);
			memcpy(&FLASH_ENCRYPT_IV[0], &p_my_user_key[0], 16u);

			COMMAND_inited();
		}

		// Anti-tamper monitors
		status = MSS_SYS_start_clock_monitor();
		if(status != MSS_SYS_SUCCESS)
		{
			return 3;
		}
	#endif

	USER_init();
	/*USER_remove(1);
	USER_remove(2);
	USER_remove(3);
	USER_remove(4);
	USER_remove(5);
	USER_remove(6);
	USER_remove(7);*/

	UART_init();

	MSS_RTC_start();

	/*** Receive commands ***/
	uint8_t command[64];
	uint32_t current_timestamp = 0;
	while(1)
	{
		// Wait for COMMAND
		//UART_waitCOMMAND();

		// Set an alarm for the next 10s
		/*mss_rtc_calendar_t new_calendar_time;
		MSS_RTC_get_calendar_count(&new_calendar_time);

		// check if seconds + 1 > 59
		if(new_calendar_time.second + 10 <= 59)
			new_calendar_time.second = new_calendar_time.second+10;
		else
		{
			// check if minutes + 1 > 59
			if(new_calendar_time.minute + 1 <= 59)
			{
				new_calendar_time.minute++;
				new_calendar_time.second = 10; // may be bigger than a 10s delay but won't be longer than 19s
			}
			else
			{
				// check if hours + 1 > 23
				if(new_calendar_time.hour + 1 <= 23)
				{
					// force interrupt on the 10th second of the 1st minute of the next hour
					new_calendar_time.hour++;
					new_calendar_time.minute = 1;
					new_calendar_time.second = 10;
				}
				else
				{
					// unlucky...skip interrupt
				}
			}
		}

		MSS_RTC_set_calendar_count_alarm(&new_calendar_time);*/

		// Alright, client is going to issue a command
		memset(command, 0, 64);
		int r = UART_receive(&command[0], 64);
		if(r < 0) // an error occurred while expecting a command, disconnect with the PC
		{
			char message[128] = {0};
			sprintf(message, "ERROR_UART_0x%02X", r);
			COMMAND_ERROR(message);

			UART_disconnect();
		}
		else
		{
			// If we are in a state of error...
			if((system_status & STATUS_TAMPER_DETECTED) || (system_status & STATUS_POR_FAILED))
			{
				char message[128] = {0};
				sprintf(message, "ERROR_FAILURE_0x%02X", tamper_status);
				COMMAND_ERROR(message);
			}
			else
			{
				// Skip timestamp check for DVC_INIT, DVC_CHECK, TIME_SEND, DVC_TEST
				if(strcmp(command, "DVC_INIT") == 0 || strcmp(command, "DVC_CHECK") == 0 || strcmp(command, "TIME_SEND") == 0 || strcmp(command, "DVC_TEST") == 0)
				{
					UART_send("CONTINUE", 8);

					// Process the command
					COMMAND_process(command);
				}
				else
				{
					// Last timestamp was sent over 24h ago?
					mss_rtc_calendar_t cal_time;
					MSS_RTC_get_calendar_count(&cal_time);
					current_timestamp = convertDateToUnixTime(&cal_time);
					if(last_timestamp == 0 || last_timestamp < current_timestamp-24*60*60)
					{
						// Do not process command, request timestamp
						UART_send("ERROR_NEW_TIME", 14);
					}
					else
					{
						UART_send("CONTINUE", 8);

						// Process the command
						COMMAND_process(command);
					}
				}
			}
		}
	}

	return 0;
}
