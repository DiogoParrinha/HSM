/*******************************************************************************
 *
 *
 * Simple SmartFusion2 Microcontroller subsystem (MSS) GPIO example program.
 *
 *
 */
#include "drivers/mss_gpio/mss_gpio.h"
#include "CMSIS/system_m2sxxx.h"

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include "sha256_fpga.h"
#include "mbedtls/config.h"
#include "mbedtls/sha256.h"

#define PIN_LED MSS_GPIO_0
/*
#define PIN_DATA_IN_READY MSS_GPIO_1 // jump start the module if we have data available (PIN_DATA_AVAILABLE=1)
#define PIN_WAITING_DATA MSS_GPIO_2 // sha256 core is waiting for data (state machine)
#define PIN_LASTBLOCK_OUT MSS_GPIO_3 // the signal lastblock output by the sha256 module (should match our lastblock input)
#define PIN_REQ_DATA MSS_GPIO_4 // sha256 core req_o
#define PIN_NOT_USED1 MSS_GPIO_5 // N/A
#define PIN_VALID_OUTPUT MSS_GPIO_6 // sha256 core valid_o AND start_high)
#define PIN_DATA_AVAILABLE MSS_GPIO_7 // if first register bank has all data, this input will be 1
#define PIN_ERROR_OUTPUT MSS_GPIO_8 // sha256 core error_o

#define PIN_RESET MSS_GPIO_9 // output pin to reset sha256 module
*/

/*==============================================================================
 * main() function.
 */
int main()
{
    volatile uint32_t readv = 0;
    uint32_t inputs = 0;
    int i = 0;
    int t = 0;

    /*uint8_t text0[64] = {
    		0x31, 0x32, 0x33, 0x34,
			0x35, 0x36, 0x37, 0x38,
			0x39, 0x41, 0x31, 0x32,
			0x33, 0x34, 0x35, 0x36,
			0x37, 0x38, 0x39, 0x42,
			0x31, 0x32, 0x33, 0x34,
			0x35, 0x36, 0x37, 0x38,
			0x39, 0x43, 0x31, 0x32,
			0x33, 0x34, 0x35, 0x36,
			0x37, 0x38, 0x39, 0x44,
			0x31, 0x32, 0x33, 0x34,
			0x35, 0x36, 0x37, 0x38,
			0x39, 0x45, 0x31, 0x32,
			0x33, 0x34, 0x35, 0x36,
			0x37, 0x38, 0x39, 0x46,
			0x31, 0x32, 0x33, 0x34
	};*/

    uint8_t text0[64] = {
			0x00, 0x00, 0x00, 0x01,
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
	};

    uint8_t text1[64] = {
			0x00, 0x00, 0x00, 0x02,
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
			0x00, 0x00, 0x00, 0x02,
	};

    uint8_t text2[64] = {
			0x00, 0x00, 0x00, 0x03,
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
			0x00, 0x00, 0x00, 0x03,
	};

    uint8_t text3[64] = {
			0x00, 0x00, 0x00, 0x04,
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
			0x00, 0x00, 0x00, 0x04,
	};

    uint8_t hash[32] = {0};
    uint8_t hash2[32] = {0};

    /*
     * Initialize MSS GPIOs.
     */
    MSS_GPIO_init();

    SHA256_FPGA_init();

    /*
     * Configure MSS GPIOs.
     */
    MSS_GPIO_config( PIN_LED , MSS_GPIO_OUTPUT_MODE ); // LED

    inputs = MSS_GPIO_get_inputs();

    MSS_GPIO_set_output( PIN_LED, 1);

    /////////////    /////////////    /////////////
    ////////// Now test with one block ////////////
    /////////////    /////////////    /////////////

	memset(hash, 0, 32);
    SHA256_FPGA(text0, hash, 64, 1, 1);

    memset(hash2, 0, 32);
    mbedtls_sha256(text0, 64, &hash2[0], 0);

    t = 0;
    t++;

    /*MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);
	MSS_GPIO_set_output( PIN_RESET, 0);
	MSS_GPIO_set_output( PIN_RESET, 1);

    // Write to AHB Slave Interface (16 words of 32-bit)
    *(volatile uint32_t *)0x31000000 = 0x00000001;
    *(volatile uint32_t *)0x31000004 = 0x00000000;
    *(volatile uint32_t *)0x31000008 = 0x00000000;
    *(volatile uint32_t *)0x3100000C = 0x00000000;
    *(volatile uint32_t *)0x31000010 = 0x00000000;
    *(volatile uint32_t *)0x31000014 = 0x00000000;
    *(volatile uint32_t *)0x31000018 = 0x00000000;
    *(volatile uint32_t *)0x3100001C = 0x00000000;
    *(volatile uint32_t *)0x31000020 = 0x00000000;
    *(volatile uint32_t *)0x31000024 = 0x00000000;
    *(volatile uint32_t *)0x31000028 = 0x00000000;
    *(volatile uint32_t *)0x3100002C = 0x00000000;
    *(volatile uint32_t *)0x31000030 = 0x00000000;
    *(volatile uint32_t *)0x31000034 = 0x00000000;
    *(volatile uint32_t *)0x31000038 = 0x00000000;
    *(volatile uint32_t *)0x3100003C = 0x00000000;
    *(volatile uint32_t *)0x31000040 = 0x00000003;

    inputs = MSS_GPIO_get_inputs();
    while(!(inputs & 0x80)) // 8th bit is 1 (data_available -> we can enable reading and give the data_out_ready signal)
    {
    	inputs = MSS_GPIO_get_inputs();
    }

    MSS_GPIO_set_output( PIN_DATA_IN_READY, 1);

    // We must wait at least 5 cycles
    for(i=0;i<10;i++)
    	asm("NOP");

    inputs = MSS_GPIO_get_inputs();
    while(!(inputs & 0x40)) // 7th bit is 1 (valid_output)
    {
    	inputs = MSS_GPIO_get_inputs();
    }

    // We must wait at least 5 cycles
    for(i=0;i<10;i++)
    	asm("NOP");

    MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);
    MSS_GPIO_set_output( PIN_RESET, 0);*/

    /////////////    /////////////    /////////////
    ////////// Now test with two blocks ///////////
    /////////////    /////////////    /////////////

	memset(hash, 0, 32);
    SHA256_FPGA(text0, hash, 64, 1, 0);
    SHA256_FPGA(text1, hash, 64, 0, 1);

    uint8_t text01[128] = {0};
    memcpy(text01, text0, 64);
    memcpy(&text01[64], text1, 64);
    memset(hash2, 0, 32);
    mbedtls_sha256(text01, 128, &hash2[0], 0);

    t = 0;
    t++;

    /*MSS_GPIO_set_output( PIN_RESET, 1);

    inputs = MSS_GPIO_get_inputs();

    // Write to AHB Slave Interface (16 words of 32-bit)
    *(volatile uint32_t *)0x31000000 = 0x00000001;
    *(volatile uint32_t *)0x31000004 = 0x00000000;
    *(volatile uint32_t *)0x31000008 = 0x00000000;
    *(volatile uint32_t *)0x3100000C = 0x00000000;
    *(volatile uint32_t *)0x31000010 = 0x00000000;
    *(volatile uint32_t *)0x31000014 = 0x00000000;
    *(volatile uint32_t *)0x31000018 = 0x00000000;
    *(volatile uint32_t *)0x3100001C = 0x00000000;
    *(volatile uint32_t *)0x31000020 = 0x00000000;
    *(volatile uint32_t *)0x31000024 = 0x00000000;
    *(volatile uint32_t *)0x31000028 = 0x00000000;
    *(volatile uint32_t *)0x3100002C = 0x00000000;
    *(volatile uint32_t *)0x31000030 = 0x00000000;
    *(volatile uint32_t *)0x31000034 = 0x00000000;
    *(volatile uint32_t *)0x31000038 = 0x00000000;
    *(volatile uint32_t *)0x3100003C = 0x00000000;
    *(volatile uint32_t *)0x31000040 = 0x00000001; // first

    inputs = MSS_GPIO_get_inputs();
	while(!(inputs & 0x80)) // 8th bit is 1 (data_available -> we can enable reading and give the data_out_ready signal)
	{
		inputs = MSS_GPIO_get_inputs();
	}

    MSS_GPIO_set_output( PIN_DATA_IN_READY, 1);

    // We must wait at least 5 cycles
    for(i=0;i<10;i++)
    	asm("NOP");

    // Wait until the controller is waiting for more data
	inputs = MSS_GPIO_get_inputs();
	while(!(inputs & 0x4)) // 3rd bit is 1 (waiting_data)
	{
		inputs = MSS_GPIO_get_inputs();
	}

	MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);

	// Write to AHB Slave Interface (16 words of 32-bit)
	*(volatile uint32_t *)0x31000000 = 0x00000002;
	*(volatile uint32_t *)0x31000004 = 0x00000000;
	*(volatile uint32_t *)0x31000008 = 0x00000000;
	*(volatile uint32_t *)0x3100000C = 0x00000000;
	*(volatile uint32_t *)0x31000010 = 0x00000000;
	*(volatile uint32_t *)0x31000014 = 0x00000000;
	*(volatile uint32_t *)0x31000018 = 0x00000000;
	*(volatile uint32_t *)0x3100001C = 0x00000000;
	*(volatile uint32_t *)0x31000020 = 0x00000000;
	*(volatile uint32_t *)0x31000024 = 0x00000000;
	*(volatile uint32_t *)0x31000028 = 0x00000000;
	*(volatile uint32_t *)0x3100002C = 0x00000000;
	*(volatile uint32_t *)0x31000030 = 0x00000000;
	*(volatile uint32_t *)0x31000034 = 0x00000000;
	*(volatile uint32_t *)0x31000038 = 0x00000000;
	*(volatile uint32_t *)0x3100003C = 0x00000000;
	*(volatile uint32_t *)0x31000040 = 0x00000002;

	inputs = MSS_GPIO_get_inputs();
	while(!(inputs & 0x80)) // 8th bit is 1 (data_available -> we can enable reading and give the data_out_ready signal)
	{
		inputs = MSS_GPIO_get_inputs();
	}

	MSS_GPIO_set_output( PIN_DATA_IN_READY, 1);

    // We must wait at least 5 cycles
    for(i=0;i<10;i++)
    	asm("NOP");

    inputs = MSS_GPIO_get_inputs();
    while(!(inputs & 0x40)) // 7th bit is 1 (valid_output)
    {
    	inputs = MSS_GPIO_get_inputs();
    }

    MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);
    MSS_GPIO_set_output( PIN_RESET, 0);*/
    
    /////////////    /////////////    /////////////
    ///////// Now test with three blocks //////////
    /////////////    /////////////    /////////////

	memset(hash, 0, 32);
    SHA256_FPGA(text0, hash, 64, 1, 0);
    SHA256_FPGA(text1, hash, 64, 0, 0);
    SHA256_FPGA(text2, hash, 64, 0, 1);

    uint8_t text012[192] = {0};
    memcpy(text012, text0, 64);
    memcpy(&text012[64], text1, 64);
    memcpy(&text012[128], text2, 64);
    memset(hash2, 0, 32);
    mbedtls_sha256(text012, 192, &hash2[0], 0);

    t = 0;
    t++;

    /*MSS_GPIO_set_output( PIN_RESET, 1);

    inputs = MSS_GPIO_get_inputs();

    // Write to AHB Slave Interface (16 words of 32-bit)
    *(volatile uint32_t *)0x31000000 = 0x00000001;
    *(volatile uint32_t *)0x31000004 = 0x00000000;
    *(volatile uint32_t *)0x31000008 = 0x00000000;
    *(volatile uint32_t *)0x3100000C = 0x00000000;
    *(volatile uint32_t *)0x31000010 = 0x00000000;
    *(volatile uint32_t *)0x31000014 = 0x00000000;
    *(volatile uint32_t *)0x31000018 = 0x00000000;
    *(volatile uint32_t *)0x3100001C = 0x00000000;
    *(volatile uint32_t *)0x31000020 = 0x00000000;
    *(volatile uint32_t *)0x31000024 = 0x00000000;
    *(volatile uint32_t *)0x31000028 = 0x00000000;
    *(volatile uint32_t *)0x3100002C = 0x00000000;
    *(volatile uint32_t *)0x31000030 = 0x00000000;
    *(volatile uint32_t *)0x31000034 = 0x00000000;
    *(volatile uint32_t *)0x31000038 = 0x00000000;
    *(volatile uint32_t *)0x3100003C = 0x00000000;
    *(volatile uint32_t *)0x31000040 = 0x00000001; // first

    inputs = MSS_GPIO_get_inputs();
	while(!(inputs & 0x80)) // 8th bit is 1 (data_available -> we can enable reading and give the data_out_ready signal)
	{
		inputs = MSS_GPIO_get_inputs();
	}

    MSS_GPIO_set_output( PIN_DATA_IN_READY, 1);

    // We must wait at least 5 cycles
    for(i=0;i<10;i++)
    	asm("NOP");

    // Wait until the controller is waiting for more data
	inputs = MSS_GPIO_get_inputs();
	while(!(inputs & 0x4)) // 3rd bit is 1 (waiting_data)
	{
		inputs = MSS_GPIO_get_inputs();
	}

	/// SECOND BLOCK

	MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);

    // Write to AHB Slave Interface (16 words of 32-bit)
    *(volatile uint32_t *)0x31000000 = 0x00000002;
    *(volatile uint32_t *)0x31000004 = 0x00000000;
    *(volatile uint32_t *)0x31000008 = 0x00000000;
    *(volatile uint32_t *)0x3100000C = 0x00000000;
    *(volatile uint32_t *)0x31000010 = 0x00000000;
    *(volatile uint32_t *)0x31000014 = 0x00000000;
    *(volatile uint32_t *)0x31000018 = 0x00000000;
    *(volatile uint32_t *)0x3100001C = 0x00000000;
    *(volatile uint32_t *)0x31000020 = 0x00000000;
    *(volatile uint32_t *)0x31000024 = 0x00000000;
    *(volatile uint32_t *)0x31000028 = 0x00000000;
    *(volatile uint32_t *)0x3100002C = 0x00000000;
    *(volatile uint32_t *)0x31000030 = 0x00000000;
    *(volatile uint32_t *)0x31000034 = 0x00000000;
    *(volatile uint32_t *)0x31000038 = 0x00000000;
    *(volatile uint32_t *)0x3100003C = 0x00000000;
    *(volatile uint32_t *)0x31000040 = 0x00000000; // middle

    inputs = MSS_GPIO_get_inputs();
	while(!(inputs & 0x80)) // 8th bit is 1 (data_available -> we can enable reading and give the data_out_ready signal)
	{
		inputs = MSS_GPIO_get_inputs();
	}

    MSS_GPIO_set_output( PIN_DATA_IN_READY, 1);

    // We must wait at least 5 cycles
    for(i=0;i<10;i++)
    	asm("NOP");

    // Wait until the controller is waiting for more data
	inputs = MSS_GPIO_get_inputs();
	while(!(inputs & 0x4)) // 3rd bit is 1 (waiting_data)
	{
		inputs = MSS_GPIO_get_inputs();
	}

	/// THIRD BLOCK

	MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);

	// Write to AHB Slave Interface (16 words of 32-bit)
	*(volatile uint32_t *)0x31000000 = 0x00000003;
	*(volatile uint32_t *)0x31000004 = 0x00000000;
	*(volatile uint32_t *)0x31000008 = 0x00000000;
	*(volatile uint32_t *)0x3100000C = 0x00000000;
	*(volatile uint32_t *)0x31000010 = 0x00000000;
	*(volatile uint32_t *)0x31000014 = 0x00000000;
	*(volatile uint32_t *)0x31000018 = 0x00000000;
	*(volatile uint32_t *)0x3100001C = 0x00000000;
	*(volatile uint32_t *)0x31000020 = 0x00000000;
	*(volatile uint32_t *)0x31000024 = 0x00000000;
	*(volatile uint32_t *)0x31000028 = 0x00000000;
	*(volatile uint32_t *)0x3100002C = 0x00000000;
	*(volatile uint32_t *)0x31000030 = 0x00000000;
	*(volatile uint32_t *)0x31000034 = 0x00000000;
	*(volatile uint32_t *)0x31000038 = 0x00000000;
	*(volatile uint32_t *)0x3100003C = 0x00000000;
	*(volatile uint32_t *)0x31000040 = 0x00000002; // last

	inputs = MSS_GPIO_get_inputs();
	while(!(inputs & 0x80)) // 8th bit is 1 (data_available -> we can enable reading and give the data_out_ready signal)
	{
		inputs = MSS_GPIO_get_inputs();
	}

	MSS_GPIO_set_output( PIN_DATA_IN_READY, 1);

    // We must wait at least 5 cycles
    for(i=0;i<10;i++)
    	asm("NOP");

    inputs = MSS_GPIO_get_inputs();
    while(!(inputs & 0x40)) // 7th bit is 1 (valid_output)
    {
    	inputs = MSS_GPIO_get_inputs();
    }

    // We must wait at least 5 cycles
    for(i=0;i<10;i++)
    	asm("NOP");

    MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);
    MSS_GPIO_set_output( PIN_RESET, 0);*/

    /////////////    /////////////    /////////////
    ///////// Now test with four blocks ///////////
    /////////////    /////////////    /////////////

	memset(hash, 0, 32);
    SHA256_FPGA(text0, hash, 64, 1, 0);
    SHA256_FPGA(text1, hash, 64, 0, 0);
    SHA256_FPGA(text2, hash, 64, 0, 0);
    SHA256_FPGA(text3, hash, 64, 0, 1);

    uint8_t text0123[256] = {0};
    memcpy(text0123, text0, 64);
    memcpy(&text0123[64], text1, 64);
    memcpy(&text0123[128], text2, 64);
    memcpy(&text0123[192], text3, 64);
    memset(hash2, 0, 32);
    mbedtls_sha256(text0123, 256, &hash2[0], 0);

    t = 0;
    t++;

    /////////////    /////////////    /////////////
    ////// Now test with incomplete blocks ////////
    /////////////    /////////////    /////////////

    uint8_t text_incomp0[256] = {0};
    memcpy(text_incomp0, text0, 32);
    memset(hash2, 0, 32);
    mbedtls_sha256(text_incomp0, 32, &hash2[0], 0);

    uint8_t text_incomp1[256] = {0};
    memcpy(text_incomp1, text0, 64);
    memcpy(&text_incomp1[64], text1, 16);
    memset(hash2, 0, 32);
    mbedtls_sha256(text_incomp1, 80, &hash2[0], 0);

    uint8_t text_incomp2[256] = {0};
    memcpy(text0123, text0, 64);
    memcpy(&text0123[64], text1, 64);
    memcpy(&text0123[128], text2, 32);
    memset(hash2, 0, 32);
    mbedtls_sha256(text_incomp2, 160, &hash2[0], 0);

    ///// END OF TESTS

    MSS_GPIO_set_output( PIN_LED, 0);

    return 0;
}

