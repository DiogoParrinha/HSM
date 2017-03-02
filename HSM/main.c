#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "common.h"

/*------------------------------------------------------------------------------
  RTC prescaler value.
  Uncomment the value corresponding to your hardware configuration.
 */
/* #define RTC_PRESCALER    (32768u - 1u)    */ /* 32KHz crystal is RTC clock source. */
/* #define RTC_PRESCALER    (1000000u - 1u) */       /* 1MHz clock is RTC clock source. */
/*#define RTC_PRESCALER    (25000000u - 1u) */ /* 25MHz clock is RTC clock source. */
#define RTC_PRESCALER    (50000000u - 1u) /* 50MHz clock is RTC clock source. */

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

	LOGS_init();
	uint8_t data1[32];
	memset(data1, 1, 32);
	LOGS_add(data1);
	uint8_t data2[32];
	memset(data2, 2, 32);
	LOGS_add(data2);
	uint8_t data3[32];
	memset(data3, 3, 32);
	LOGS_add(data3);
	uint8_t data4[32];
	memset(data4, 4, 32);
	LOGS_add(data4);
	uint8_t data5[32];
	memset(data5, 5, 32);
	LOGS_add(data5);

	return 0;

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

	/*** USE RTC FOR TIME CONTROL ***/
	mss_rtc_calendar_t calendar_count;
	MSS_RTC_init(MSS_RTC_CALENDAR_MODE, RTC_PRESCALER);

	/*** SETUP CONNECTION ***/
	uint8_t command[64];

	UART_connect(); // Connect

	MSS_RTC_start();

	UART_waitCOMMAND(); // Wait for TIME_SEND (should be...)
	UART_receive(&command[0], 64);
	COMMAND_process(command); // Process TIME_SEND

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

	/*** Receive commands ***/
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

