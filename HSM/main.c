#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "common.h"

// The need to reserve a defined block of SRAM when using PUF system services,
// to prevent the compiler from using the SRAM memory range from address
// 0x2000800 to 0x2000802F inclusive.
#if defined(__GNUC__)
static uint8_t __attribute__((section(".keycode2Section"))) g_key_code[48];
#endif

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

	/*** USE RTC FOR TIME CONTROL ***/
	MSS_RTC_init(MSS_RTC_CALENDAR_MODE, RTC_PRESCALER);

	system_status = STATUS_DEFAULT;
	tamper_status = STATUS_DEFAULT;

	#ifdef SECURITY_DEVICE
		MSS_SYS_init(sys_services_event_handler);

		MSS_SYS_nrbg_reset();

		// Instantiate RNG
		volatile uint8_t status;
		status = MSS_SYS_nrbg_instantiate(0, 0, &drbg_handle);
		if(status != MSS_SYS_SUCCESS)
		{
			return 1;
		}

		uint8_t key_numbers = 0u;

		status = MSS_SYS_puf_get_number_of_keys(&key_numbers);

		// Only mark as initialized if we have at least 5 keys enrolled (2 factory; 3 custom)
		if(key_numbers == 5)
		{
			/*
			uint8_t g_my_user_key[512] = {0};
			MSS_SYS_puf_delete_activation_code();
			MSS_SYS_puf_create_activation_code();

			status = MSS_SYS_puf_enroll_key(2, 384 / 64, 0u, &g_my_user_key[0]);
			if(status != MSS_SYS_SUCCESS)
			{
			}

			status = MSS_SYS_puf_enroll_key(3, 384 / 64, 0u, &g_my_user_key[0]);
			if(status != MSS_SYS_SUCCESS)
			{
			}

			status = MSS_SYS_puf_enroll_key(4, 256 / 64, 0u, &g_my_user_key[0]);
			if(status != MSS_SYS_SUCCESS)
			{
			}*/

			uint8_t* p_my_user_key = (uint8_t*)&global_buffer;

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

			status = MSS_SYS_puf_fetch_key(4, &p_my_user_key);
			if(status != MSS_SYS_SUCCESS)
			{
				return 2;
			}

			memset(FLASH_ENCRYPT_KEY, 0, 32);
			memcpy(&FLASH_ENCRYPT_KEY[0], &p_my_user_key[0], 32u);

			COMMAND_inited();
		}

		// Anti-tamper monitors
		status = MSS_SYS_start_clock_monitor();
		if(status != MSS_SYS_SUCCESS)
		{
			return 3;
		}
	#endif

	UART_init();

	/*** Receive commands ***/
	uint8_t command[64];
	while(1)
	{
		// Wait for COMMAND
		UART_waitCOMMAND();

		// If we are in a state of error, we don't even read the command and process it
		if((system_status & STATUS_TAMPER_DETECTED) || (system_status & STATUS_POR_FAILED))
		{
			char message[128] = {0};
			sprintf(message, "ERROR: failure state 0x%02X", tamper_status);
			COMMAND_ERROR(message);
		}
		else
		{
			// Alright, client is going to issue a command
			memset(command, 0, 64);
			UART_receive(&command[0], 64);

			// Process the command
			COMMAND_process(command);
		}
	}

	return 0;
}
