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
	MSS_GPIO_set_output( MSS_GPIO_0 , 1 );
#else
	MSS_GPIO_set_output( MSS_GPIO_0 , 0 );
#endif

	//MSS_UART_init(&g_mss_uart0, MSS_UART_57600_BAUD, MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);

	/* Disable Watchdog */
	SYSREG->WDOG_CR = 0x00000000;

	SHA256_FPGA_init();

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

			// NOTE: IV below must not be used in production mode because using the same IV for multiple blocks makes it predictable and subject to attacks
			// In fact, the IV of each user block should be stored in the NVM and re-generated for each new encryption of the respective block
			// Anyway, since for demo purposes we store 7 FIXED IVs in RAM just to demonstrate that we have a different IV for each user
			// We need another IV for > 7 users so we simply use this one
			// The eNVM is never used directly because we don't want to burn it during tests and demo (as the test board will likely be used by future students)
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

	/*SPIFLASH_init();
	SPIFLASH_eraseAll();*/

	USER_init();

	UART_init();

	MSS_RTC_start();

#ifdef SECURITY_DEVICE
	MSS_GPIO_set_output( MSS_GPIO_0 , 0 );
#else
	MSS_GPIO_set_output( MSS_GPIO_0 , 1 );
#endif

	/*** Receive commands ***/
	uint8_t command[64];
	uint32_t current_timestamp = 0;
	while(1)
	{
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
