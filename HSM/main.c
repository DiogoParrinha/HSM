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

	/*** USE RTC FOR TIME CONTROL ***/
	MSS_RTC_init(MSS_RTC_CALENDAR_MODE, RTC_PRESCALER);

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

	USER_remove(1);
	USER_remove(2);
	USER_remove(3);
	USER_remove(4);
	USER_remove(5);
	USER_remove(6);
	USER_remove(7);

	return 0;*/

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
	
	#ifdef SECURITY_DEVICE
		MSS_SYS_init(MSS_SYS_NO_EVENT_HANDLER);
		
		MSS_SYS_nrbg_reset();

		// Instantiate RNG
		uint8_t status;
		status = MSS_SYS_nrbg_instantiate(0, 0, &drbg_handle);
		if(status != MSS_SYS_SUCCESS)
		{
			return 1;
		}

		/*uint8_t challenge[16] = {0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28};
		status = MSS_SYS_nrbg_generate(&challenge[0],    // p_requested_data
			0,              // p_additional_input
			16,				// requested_length
			0,              // additional_input_length
			0,              // pr_req
			drbg_handle);   // drbg_handle
		if(status != MSS_SYS_SUCCESS)
		{
			return 2; // error
		}

		uint8_t puf_seed[32];
		MSS_SYS_puf_get_random_seed(&puf_seed[0]);
		if(status != MSS_SYS_SUCCESS)
		{
			return 3; // error
		}*/

		// calculate SHA-256
		/*uint8_t challenge[129] = "k4SWZF2WfoemUAMYj24wUpCUs8s77GfFUFoSShbeR8CuFTh94SG2EOaNakcsESV3a1EsvN5oV8sUW6VV3UOiuHOIzBerQTtmVP4r08cUqZgP9tfWt8uhI1e6gkh7A27B";
		uint8_t digest1[32] = {0};
		mbedtls_sha256(challenge, 120, &digest1[0], 0);

		uint8_t digest2[32] = {0};
		status = MSS_SYS_sha256(challenge, 120*8, &digest2[0]);
		if(status != MSS_SYS_SUCCESS)
		{
			return 4; // error
		}

		return 0;*/
	#endif

	/*uint8_t issuer_pub[512] = {0};
	uint8_t issuer_pri[512] = {0};
	PKC_genKeyPair(&issuer_pub[0], &issuer_pri[0]);

	return 0;*/

	UART_init();

	/*** Receive commands ***/
	uint8_t command[64];
	while(1)
	{
		// Wait for COMMAND
		UART_waitCOMMAND();

		// Alright, client is going to issue a command
		memset(command, 0, 64);
		UART_receive(&command[0], 64);

		// Process the command
		COMMAND_process(command);
	}

	return 0;
}


// From Joseph Yiu, minor edits by FVH
// hard fault handler in C,
// with stack frame location as input parameter
// called from HardFault_Handler in file xxx.s
/*void hard_fault_handler_c (unsigned int * hardfault_args)
{
  unsigned int stacked_r0;
  unsigned int stacked_r1;
  unsigned int stacked_r2;
  unsigned int stacked_r3;
  unsigned int stacked_r12;
  unsigned int stacked_lr;
  unsigned int stacked_pc;
  unsigned int stacked_psr;

  stacked_r0 = ((unsigned long) hardfault_args[0]);
  stacked_r1 = ((unsigned long) hardfault_args[1]);
  stacked_r2 = ((unsigned long) hardfault_args[2]);
  stacked_r3 = ((unsigned long) hardfault_args[3]);

  stacked_r12 = ((unsigned long) hardfault_args[4]);
  stacked_lr = ((unsigned long) hardfault_args[5]);
  stacked_pc = ((unsigned long) hardfault_args[6]);
  stacked_psr = ((unsigned long) hardfault_args[7]);

  char data[512] = {0};
  sprintf (data, "%s", "\n\n[Hard fault handler - all numbers in hex]\n");
  sprintf (data, "%sR0 = %x\n", data, stacked_r0);
  sprintf (data, "%sR1 = %x\n", data, stacked_r1);
  sprintf (data, "%sR2 = %x\n", data, stacked_r2);
  sprintf (data, "%sR3 = %x\n", data, stacked_r3);
  sprintf (data, "%sR12 = %x\n", data, stacked_r12);
  sprintf (data, "%sLR [R14] = %x  subroutine call return address\n", data, stacked_lr);
  sprintf (data, "%sPC [R15] = %x  program counter\n", data, stacked_pc);
  sprintf (data, "%sPSR = %x\n", data, stacked_psr);
  sprintf (data, "%sBFAR = %x\n", data, (*((volatile unsigned long *)(0xE000ED38))));
  sprintf (data, "%sCFSR = %x\n", data, (*((volatile unsigned long *)(0xE000ED28))));
  sprintf (data, "%sHFSR = %x\n", data, (*((volatile unsigned long *)(0xE000ED2C))));
  //sprintf (data, "%sDFSR = %x\n", data, (*((volatile unsigned long *)(0xE000ED30))));
  sprintf (data, "%sAFSR = %x\n", data, (*((volatile unsigned long *)(0xE000ED3C))));
  //sprintf (data, "%sSCB_SHCSR = %x\n", data, SCB->SHCSR);

  while (1);
}*/

