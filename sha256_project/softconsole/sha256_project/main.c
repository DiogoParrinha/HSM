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

#include "mbedtls/config.h"
#include "mbedtls/sha256.h"

#define PIN_LED MSS_GPIO_0
#define PIN_DATA_IN_READY MSS_GPIO_1 // jump start the module if we have data available (PIN_DATA_AVAILABLE=1)
#define PIN_WAITING_DATA MSS_GPIO_2 // sha256 core is waiting for data (state machine)
#define PIN_LASTBLOCK_OUT MSS_GPIO_3 // the signal lastblock output by the sha256 module (should match our lastblock input)
#define PIN_REQ_DATA MSS_GPIO_4 // sha256 core req_o
#define PIN_NOT_USED1 MSS_GPIO_5 // N/A
#define PIN_VALID_OUTPUT MSS_GPIO_6 // sha256 core valid_o AND start_high)
#define PIN_DATA_AVAILABLE MSS_GPIO_7 // if first register bank has all data, this input will be 1
#define PIN_ERROR_OUTPUT MSS_GPIO_8 // sha256 core error_o

#define PIN_RESET MSS_GPIO_9 // output pin to reset sha256 module

#define AHB_BASE_ADDR 0x31000000

/*==============================================================================
  Private functions.
 */
void SHA256_FPGA(uint8_t * data, uint8_t * hash, uint8_t first, uint8_t last);

/*==============================================================================
 * main() function.
 */
int main()
{
    volatile uint32_t readv = 0;
    uint32_t inputs = 0;
    int i =0;

    uint8_t text0[64] = {
			0x00, 0x00, 0x00, 0x01,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
			0x00, 0x00, 0x00, 0x00,
	};

    uint32_t text1[16] = {
    		0x01000000,
    		0x00000000,
    		0x00000000,
    		0x00000000,
    		0x00000000,
			0x00000000,
    		0x00000000,
    		0x00000000,
    		0x00000000,
    		0x00000000,
    		0x00000000,
    		0x00000000,
    		0x00000000,
    		0x00000000,
    		0x00000000,
    };
    uint8_t text2[64] = {0};
    memcpy(text2, text1, sizeof(text1));

    uint8_t hash[32] = {0};
    mbedtls_sha256(text0, 64, &hash[0], 0);

    /*
     * Initialize MSS GPIOs.
     */
    MSS_GPIO_init();

    /*
     * Configure MSS GPIOs.
     */
    MSS_GPIO_config( PIN_LED , MSS_GPIO_OUTPUT_MODE ); // LED
    MSS_GPIO_config( PIN_DATA_IN_READY , MSS_GPIO_OUTPUT_MODE ); // Read Enable
    MSS_GPIO_config( PIN_RESET , MSS_GPIO_OUTPUT_MODE ); // Reset

    MSS_GPIO_config( PIN_WAITING_DATA, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_LASTBLOCK_OUT, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_REQ_DATA, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_NOT_USED1, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_VALID_OUTPUT, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_ERROR_OUTPUT, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_DATA_AVAILABLE, MSS_GPIO_INPUT_MODE );

    inputs = MSS_GPIO_get_inputs();

    MSS_GPIO_set_output( PIN_LED, 1);

    /////////////    /////////////    /////////////
    ////////// Now test with one block ////////////
    /////////////    /////////////    /////////////

    uint8_t hash2[32] = {0};
    SHA256_FPGA(text0, hash2, 1, 1);

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

    MSS_GPIO_set_output( PIN_RESET, 1);

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
    MSS_GPIO_set_output( PIN_RESET, 0);

    ///// END OF TESTS

    MSS_GPIO_set_output( PIN_LED, 0);

    return 0;
}

// Only accepts blocks of size 64B
// Input is big-endian
// Output is big-endian
void SHA256_FPGA(uint8_t * data, uint8_t * hash, uint8_t first, uint8_t last)
{
	int i = 0;
	uint32_t inputs = 0;

	// Convert data from big-endian to little-endian
	/*uint8_t data_le[64] = {0};
	int i;
	for(i=0;i<64;i+=4) // jump every 4 bytes (32-bit words)
	{
		data_le[i] = data[i+3];
		data_le[i+1] = data[i+2];
		data_le[i+2] = data[i+1];
		data_le[i+3] = data[i];
	}*/

	// First block? Last block?
	uint8_t blockinfo[4] = {0x00, 0x00, 0x00, 0x00};
	if(first == 1)
		blockinfo[3] |= 0x01;
	if(last == 1)
		blockinfo[3] |= 0x02;

	MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);
	MSS_GPIO_set_output( PIN_RESET, 0);
	MSS_GPIO_set_output( PIN_RESET, 1);

	// Write to AHB Slave Interface (16 words of 32-bit)
	*(volatile uint32_t *)0x31000000 = (data[3] & 0x000000FF) | ((data[2] & 0x000000FF) << 8) | ((data[1] & 0x0000FF00) << 16) | ((data[0] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000004 = (data[7] & 0x000000FF) | ((data[6] & 0x000000FF) << 8) | ((data[5] & 0x000000FF) << 16) | ((data[4] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000008 = (data[11] & 0x000000FF) | ((data[10] & 0x000000FF) << 8) | ((data[9] & 0x000000FF) << 16) | ((data[8] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x3100000C = (data[15] & 0x000000FF) | ((data[14] & 0x000000FF) << 8) | ((data[13] & 0x000000FF) << 16) | ((data[12] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000010 = (data[19] & 0x000000FF) | ((data[18] & 0x000000FF) << 8) | ((data[17] & 0x000000FF) << 16) | ((data[16] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000014 = (data[23] & 0x000000FF) | ((data[22] & 0x000000FF) << 8) | ((data[21] & 0x000000FF) << 16) | ((data[20] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000018 = (data[27] & 0x000000FF) | ((data[26] & 0x000000FF) << 8) | ((data[25] & 0x000000FF) << 16) | ((data[24] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x3100001C = (data[31] & 0x000000FF) | ((data[30] & 0x000000FF) << 8) | ((data[29] & 0x000000FF) << 16) | ((data[28] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000020 = (data[35] & 0x000000FF) | ((data[34] & 0x000000FF) << 8) | ((data[33] & 0x000000FF) << 16) | ((data[32] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000024 = (data[39] & 0x000000FF) | ((data[38] & 0x000000FF) << 8) | ((data[37] & 0x000000FF) << 16) | ((data[36] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000028 = (data[43] & 0x000000FF) | ((data[42] & 0x000000FF) << 8) | ((data[41] & 0x000000FF) << 16) | ((data[40] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x3100002C = (data[47] & 0x000000FF) | ((data[46] & 0x000000FF) << 8) | ((data[45] & 0x000000FF) << 16) | ((data[44] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000030 = (data[51] & 0x000000FF) | ((data[50] & 0x000000FF) << 8) | ((data[49] & 0x000000FF) << 16) | ((data[48] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000034 = (data[55] & 0x000000FF) | ((data[54] & 0x000000FF) << 8) | ((data[53] & 0x000000FF) << 16) | ((data[52] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000038 = (data[59] & 0x000000FF) | ((data[58] & 0x000000FF) << 8) | ((data[57] & 0x000000FF) << 16) | ((data[56] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x3100003C = (data[63] & 0x000000FF) | ((data[62] & 0x000000FF) << 8) | ((data[61] & 0x000000FF) << 16) | ((data[60] & 0x000000FF) << 24);
	*(volatile uint32_t *)0x31000040 = (blockinfo[3] & 0x000000FF) | (blockinfo[2] & 0x000000FF) | ((blockinfo[1] & 0x000000FF) << 16) | ((blockinfo[0] & 0x000000FF) << 24);

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

	// Take out the hash from [0x31000000, 8]
	uint32_t * p;
	p = (uint32_t *)AHB_BASE_ADDR;
	for(i=0;i<32;i+=4)
	{
		uint32_t word = *p;

		// Little endian to big endian
		hash[i+3] = (word & 0x000000FF);
		hash[i+2] = (word & 0x0000FF00) >> 8;
		hash[i+1] = (word & 0x00FF0000) >> 16;
		hash[i+0] = (word & 0xFF000000) >> 24;

		p++; //reading can be done with a 1 position jump
	}

	MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);
	if(last == 1)
		MSS_GPIO_set_output( PIN_RESET, 0);
}
