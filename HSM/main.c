#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "common.h"
#include "UART.h"
#include "Command.h"
#include "PKC.h"

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
	MSS_GPIO_set_output( MSS_GPIO_0 , 1 );

	//MSS_UART_init(&g_mss_uart0, MSS_UART_57600_BAUD, MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);

	/* Disable Watchdog */
	SYSREG->WDOG_CR = 0x00000000;

	/*volatile int i = 0;
	i++;
	i += 3;

	data = malloc(sizeof(char)*3);
	data[0] = '1';
	data[1] = '2';
	data[2] = '3';

	volatile char data2[5];

	if(i == 4)
	{
		data2[0] = 'A';
		data2[1] = 'B';
		data2[2] = 'C';
		data2[3] = 'D';
		data2[4] = 'E';
	}

	return 0;*/

	USER_init();

	USER * n1 = USER_get(1);

	PKC_createCertificate(n1->publicKey, "Diogo Parrinha", "digital_signature", &global_buffer[0]);

	//USER_remove(1);

	return 0;

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

	/*** TODO: INITIATE SECURE COMMUNICATION ***/
	// Establish session key

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

