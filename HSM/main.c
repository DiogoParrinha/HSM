#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "common.h"

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

	/*BOOL r;

	uint8_t * finalMessage;
	uint8_t signature[128];
	size_t sig_len = 0;

	volatile int t = 0;
	for(t=0;t<1000;t++)
		r = LOGS_sign("rm myname_is_diogo.txt", strlen("rm myname_is_diogo.txt"), 1, finalMessage, &signature[0], &sig_len);


	t++;

	return 0;*/

	/*USER_init();

	//USER_remove(1);
	USER_add(1, "12345678912345678912345678912341");
	USER * n1 = USER_get(1);

	volatile int t = 0;
	t++;

	return 0;*/

	/*USER_remove(4);
	USER_remove(2);
	USER_remove(3);

	/*USER_add(1, "12345678912345678912345678912341");
	USER * n1 = USER_get(1);
	USER * n2 = USER_get(2);

	USER_add(3, "12345678912345678912345678912343");
	USER * n3 = USER_get(3);

	USER_terminate();

	return 0;*/

	/*USER_add(1, "12345678912345678912345678912341");
	USER * n1 = USER_get(1);
	USER * n2 = USER_get(2);
	USER_add(3, "32345678912345678912345678912343");
	USER * n3 = USER_get(3);*/

	/*USER_add(2, "12345678912345678912345678912341");
	USER_add(4, "12345678912345678912345678912344");

	ret = USER_modify(1, "62345678912345678912345678912340");
	ret = USER_modify(2, "72345678912345678912345678912341");
	//ret = USER_modify(4, "82345678912345678912345678912343");
	ret = USER_modify(3, "92345678912345678912345678912344"); // shouldn't work because user doesn't exist

	USER_terminate();*/

	/*USER_remove(4);
	USER_remove(2);
	USER_remove(3);*/

	/* Display time over UART. */
	/*char display_buffer[1024] = {0};
	for(;;)
	{
		uint32_t rtc_count_updated;
		// Update displayed time if value read from RTC changed since last read.
		rtc_count_updated = MSS_RTC_get_update_flag();
		if(rtc_count_updated)
		{
			MSS_RTC_get_calendar_count(&calendar_count);

			snprintf((char *)display_buffer, sizeof(display_buffer), "%d  2%03d  (week %d) %02d:%02d:%02d",
			 (int)calendar_count.day,
			 (int)calendar_count.year,
			 (int)calendar_count.week,
			 (int)calendar_count.hour,
			 (int)calendar_count.minute,
			 (int)calendar_count.second);

			MSS_RTC_clear_update_flag();
		}
	}*/

	UART_init();

	/*** Receive commands ***/
	uint8_t command[64];
	while(1)
	{
		// Wait for COMMAND
		UART_waitCOMMAND();

		// Alright, client is going to issue a command
		UART_receive(&command[0], 64);

		// Process the command
		COMMAND_process(command);
	}

	return 0;
}

