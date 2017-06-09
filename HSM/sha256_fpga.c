#include "sha256_fpga.h"
#include "drivers/mss_gpio/mss_gpio.h"

#define PIN_DATA_IN_READY MSS_GPIO_1 // jump start the module if we have data available (PIN_DATA_AVAILABLE=1)
#define PIN_WAITING_DATA MSS_GPIO_2 // sha256 core is waiting for data (state machine)
#define PIN_LASTBLOCK_OUT MSS_GPIO_3 // the signal lastblock output by the sha256 module (should match our lastblock input)
#define PIN_REQ_DATA MSS_GPIO_4 // sha256 core req_o
#define PIN_NOT_USED1 MSS_GPIO_5 // N/A
#define PIN_VALID_OUTPUT MSS_GPIO_6 // sha256 core valid_o AND start_high)
#define PIN_DATA_AVAILABLE MSS_GPIO_7 // if first register bank has all data, this input will be 1
#define PIN_ERROR_OUTPUT MSS_GPIO_8 // sha256 core error_o

#define PIN_RESET MSS_GPIO_9 // output pin to reset sha256 module

void SHA256_FPGA_init()
{
	MSS_GPIO_init();

    MSS_GPIO_config( PIN_DATA_IN_READY , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( PIN_RESET , MSS_GPIO_OUTPUT_MODE );

    MSS_GPIO_config( PIN_WAITING_DATA, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_LASTBLOCK_OUT, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_REQ_DATA, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_NOT_USED1, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_VALID_OUTPUT, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_ERROR_OUTPUT, MSS_GPIO_INPUT_MODE );
    MSS_GPIO_config( PIN_DATA_AVAILABLE, MSS_GPIO_INPUT_MODE );
}

// Accepts max of 64B input. Smaller size will be padded by hardware
// Input is big-endian
// Output is big-endian
void SHA256_FPGA(uint8_t * data, uint8_t * hash, uint8_t size, uint8_t first, uint8_t last)
{
	if(size == 0)
		return;

	int i = 0;
	uint32_t inputs = 0;

	/// COMMENTED because we do the conversion directly when writing to memory below
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

	if(first == 1)
	{
		MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);
		MSS_GPIO_set_output( PIN_RESET, 0);
		MSS_GPIO_set_output( PIN_RESET, 1);
	}

	// Figure out how many 4B words we have and subtract 1 to get the position
	int word_pos = ((size + (4 - 1)) / 4) - 1;
	blockinfo[0] = (word_pos) << 4; // shift by 4 because it must be in the most significant 4bits below

	// Find out how many valid bytes we have in our last word if size % 4 != 0 (not a multiple of 4B)
	uint32_t valid_bytes_word = 0;
	if(size % 4 != 0)
	{
		// Last word can't be complete so find how many bytes are valid
		int byte_pos = size-(word_pos*4);

		blockinfo[1] = byte_pos << 4;
	}

	// Write to AHB Slave Interface (16 words of 32-bit)
	*(volatile uint32_t *)0x50000000 = (0x000000FF & data[0]) << 24 | ((0x000000FF & data[1]) << 16) | ((0x000000FF & data[2]) << 8) | ((0x000000FF & data[3]) << 0);
	*(volatile uint32_t *)0x50000004 = (0x000000FF & data[4]) << 24 | ((0x000000FF & data[5]) << 16) | ((0x000000FF & data[6]) << 8) | ((0x000000FF & data[7]) << 0);
	*(volatile uint32_t *)0x50000008 = (0x000000FF & data[8]) << 24 | ((0x000000FF & data[9]) << 16) | ((0x000000FF & data[10]) << 8) | ((0x000000FF & data[11]) << 0);
	*(volatile uint32_t *)0x5000000C = (0x000000FF & data[12]) << 24 | ((0x000000FF & data[13]) << 16) | ((0x000000FF & data[14]) << 8) | ((0x000000FF & data[15]) << 0);
	*(volatile uint32_t *)0x50000010 = (0x000000FF & data[16]) << 24 | ((0x000000FF & data[17]) << 16) | ((0x000000FF & data[18]) << 8) | ((0x000000FF & data[19]) << 0);
	*(volatile uint32_t *)0x50000014 = (0x000000FF & data[20]) << 24 | ((0x000000FF & data[21]) << 16) | ((0x000000FF & data[22]) << 8) | ((0x000000FF & data[23]) << 0);
	*(volatile uint32_t *)0x50000018 = (0x000000FF & data[24]) << 24 | ((0x000000FF & data[25]) << 16) | ((0x000000FF & data[26]) << 8) | ((0x000000FF & data[27]) << 0);
	*(volatile uint32_t *)0x5000001C = (0x000000FF & data[28]) << 24 | ((0x000000FF & data[29]) << 16) | ((0x000000FF & data[30]) << 8) | ((0x000000FF & data[31]) << 0);
	*(volatile uint32_t *)0x50000020 = (0x000000FF & data[32]) << 24 | ((0x000000FF & data[33]) << 16) | ((0x000000FF & data[34]) << 8) | ((0x000000FF & data[35]) << 0);
	*(volatile uint32_t *)0x50000024 = (0x000000FF & data[36]) << 24 | ((0x000000FF & data[37]) << 16) | ((0x000000FF & data[38]) << 8) | ((0x000000FF & data[39]) << 0);
	*(volatile uint32_t *)0x50000028 = (0x000000FF & data[40]) << 24 | ((0x000000FF & data[41]) << 16) | ((0x000000FF & data[42]) << 8) | ((0x000000FF & data[43]) << 0);
	*(volatile uint32_t *)0x5000002C = (0x000000FF & data[44]) << 24 | ((0x000000FF & data[45]) << 16) | ((0x000000FF & data[46]) << 8) | ((0x000000FF & data[47]) << 0);
	*(volatile uint32_t *)0x50000030 = (0x000000FF & data[48]) << 24 | ((0x000000FF & data[49]) << 16) | ((0x000000FF & data[50]) << 8) | ((0x000000FF & data[51]) << 0);
	*(volatile uint32_t *)0x50000034 = (0x000000FF & data[52]) << 24 | ((0x000000FF & data[53]) << 16) | ((0x000000FF & data[54]) << 8) | ((0x000000FF & data[55]) << 0);
	*(volatile uint32_t *)0x50000038 = (0x000000FF & data[56]) << 24 | ((0x000000FF & data[57]) << 16) | ((0x000000FF & data[58]) << 8) | ((0x000000FF & data[59]) << 0);
	*(volatile uint32_t *)0x5000003C = (0x000000FF & data[60]) << 24 | ((0x000000FF & data[61]) << 16) | ((0x000000FF & data[62]) << 8) | ((0x000000FF & data[63]) << 0);
	*(volatile uint32_t *)0x50000040 = (0x000000FF & blockinfo[0]) << 24 | ((0x000000FF & blockinfo[1]) << 16) | ((0x000000FF & blockinfo[2]) << 8) | ((0x000000FF & blockinfo[3]) << 0);
	//(blockinfo[3] & 0x000000FF) | (blockinfo[2] & 0x000000FF) | ((blockinfo[1] & 0x000000FF) << 16) | ((blockinfo[0] & 0x000000FF) << 24);

	inputs = MSS_GPIO_get_inputs();
	while(!(inputs & 0x80)) // 8th bit is 1 (data_available -> we can enable reading and give the data_out_ready signal)
	{
		inputs = MSS_GPIO_get_inputs();
	}

	MSS_GPIO_set_output( PIN_DATA_IN_READY, 1);

	// We must wait at least 5 cycles
	for(i=0;i<10;i++)
		asm("NOP");

	if(last == 1)
	{
		// Wait for valid
		inputs = MSS_GPIO_get_inputs();
		while(!(inputs & 0x40)) // 7th bit is 1 (valid_output)
		{
			inputs = MSS_GPIO_get_inputs();
		}
	}
	else
	{
	    // Wait until the controller is waiting for more data
		inputs = MSS_GPIO_get_inputs();
		while(!(inputs & 0x4)) // 3rd bit is 1 (waiting_data)
		{
			inputs = MSS_GPIO_get_inputs();
		}
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
