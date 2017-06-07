/*******************************************************************************
 *
 *
 * Simple SmartFusion2 Microcontroller subsystem (MSS) GPIO example program.
 *
 *
 */
#include "drivers/mss_gpio/mss_gpio.h"
#include "CMSIS/system_m2sxxx.h"

/*==============================================================================
  Private functions.
 */
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
/*==============================================================================
 * main() function.
 */
int main()
{
    volatile uint32_t readv = 0;
    uint32_t inputs = 0;
    int i =0;

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

    MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);
	MSS_GPIO_set_output( PIN_RESET, 0);
	MSS_GPIO_set_output( PIN_RESET, 1);

    // Write to AHB Slave Interface (16 words of 32-bit)
    *(volatile uint32_t *)0x30000000 = 0x00000001;
    *(volatile uint32_t *)0x30000004 = 0x00000000;
    *(volatile uint32_t *)0x30000008 = 0x00000000;
    *(volatile uint32_t *)0x3000000C = 0x00000000;
    *(volatile uint32_t *)0x30000010 = 0x00000000;
    *(volatile uint32_t *)0x30000014 = 0x00000000;
    *(volatile uint32_t *)0x30000018 = 0x00000000;
    *(volatile uint32_t *)0x3000001C = 0x00000000;
    *(volatile uint32_t *)0x30000020 = 0x00000000;
    *(volatile uint32_t *)0x30000024 = 0x00000000;
    *(volatile uint32_t *)0x30000028 = 0x00000000;
    *(volatile uint32_t *)0x3000002C = 0x00000000;
    *(volatile uint32_t *)0x30000030 = 0x00000000;
    *(volatile uint32_t *)0x30000034 = 0x00000000;
    *(volatile uint32_t *)0x30000038 = 0x00000000;
    *(volatile uint32_t *)0x3000003C = 0x00000000;
    *(volatile uint32_t *)0x30000040 = 0x00000003;

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

    /////////////    /////////////    /////////////
    ////////// Now test with two blocks ///////////
    /////////////    /////////////    /////////////

    /*MSS_GPIO_set_output( PIN_RESET, 1);

    inputs = MSS_GPIO_get_inputs();

    // Write to AHB Slave Interface (16 words of 32-bit)
    *(volatile uint32_t *)0x30000000 = 0x00000001;
    *(volatile uint32_t *)0x30000004 = 0x00000000;
    *(volatile uint32_t *)0x30000008 = 0x00000000;
    *(volatile uint32_t *)0x3000000C = 0x00000000;
    *(volatile uint32_t *)0x30000010 = 0x00000000;
    *(volatile uint32_t *)0x30000014 = 0x00000000;
    *(volatile uint32_t *)0x30000018 = 0x00000000;
    *(volatile uint32_t *)0x3000001C = 0x00000000;
    *(volatile uint32_t *)0x30000020 = 0x00000000;
    *(volatile uint32_t *)0x30000024 = 0x00000000;
    *(volatile uint32_t *)0x30000028 = 0x00000000;
    *(volatile uint32_t *)0x3000002C = 0x00000000;
    *(volatile uint32_t *)0x30000030 = 0x00000000;
    *(volatile uint32_t *)0x30000034 = 0x00000000;
    *(volatile uint32_t *)0x30000038 = 0x00000000;
    *(volatile uint32_t *)0x3000003C = 0x00000000;
    *(volatile uint32_t *)0x30000040 = 0x00000001; // first

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
	*(volatile uint32_t *)0x30000000 = 0x00000002;
	*(volatile uint32_t *)0x30000004 = 0x00000000;
	*(volatile uint32_t *)0x30000008 = 0x00000000;
	*(volatile uint32_t *)0x3000000C = 0x00000000;
	*(volatile uint32_t *)0x30000010 = 0x00000000;
	*(volatile uint32_t *)0x30000014 = 0x00000000;
	*(volatile uint32_t *)0x30000018 = 0x00000000;
	*(volatile uint32_t *)0x3000001C = 0x00000000;
	*(volatile uint32_t *)0x30000020 = 0x00000000;
	*(volatile uint32_t *)0x30000024 = 0x00000000;
	*(volatile uint32_t *)0x30000028 = 0x00000000;
	*(volatile uint32_t *)0x3000002C = 0x00000000;
	*(volatile uint32_t *)0x30000030 = 0x00000000;
	*(volatile uint32_t *)0x30000034 = 0x00000000;
	*(volatile uint32_t *)0x30000038 = 0x00000000;
	*(volatile uint32_t *)0x3000003C = 0x00000000;
	*(volatile uint32_t *)0x30000040 = 0x00000002;

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
    *(volatile uint32_t *)0x30000000 = 0x00000001;
    *(volatile uint32_t *)0x30000004 = 0x00000000;
    *(volatile uint32_t *)0x30000008 = 0x00000000;
    *(volatile uint32_t *)0x3000000C = 0x00000000;
    *(volatile uint32_t *)0x30000010 = 0x00000000;
    *(volatile uint32_t *)0x30000014 = 0x00000000;
    *(volatile uint32_t *)0x30000018 = 0x00000000;
    *(volatile uint32_t *)0x3000001C = 0x00000000;
    *(volatile uint32_t *)0x30000020 = 0x00000000;
    *(volatile uint32_t *)0x30000024 = 0x00000000;
    *(volatile uint32_t *)0x30000028 = 0x00000000;
    *(volatile uint32_t *)0x3000002C = 0x00000000;
    *(volatile uint32_t *)0x30000030 = 0x00000000;
    *(volatile uint32_t *)0x30000034 = 0x00000000;
    *(volatile uint32_t *)0x30000038 = 0x00000000;
    *(volatile uint32_t *)0x3000003C = 0x00000000;
    *(volatile uint32_t *)0x30000040 = 0x00000001; // first

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
    *(volatile uint32_t *)0x30000000 = 0x00000002;
    *(volatile uint32_t *)0x30000004 = 0x00000000;
    *(volatile uint32_t *)0x30000008 = 0x00000000;
    *(volatile uint32_t *)0x3000000C = 0x00000000;
    *(volatile uint32_t *)0x30000010 = 0x00000000;
    *(volatile uint32_t *)0x30000014 = 0x00000000;
    *(volatile uint32_t *)0x30000018 = 0x00000000;
    *(volatile uint32_t *)0x3000001C = 0x00000000;
    *(volatile uint32_t *)0x30000020 = 0x00000000;
    *(volatile uint32_t *)0x30000024 = 0x00000000;
    *(volatile uint32_t *)0x30000028 = 0x00000000;
    *(volatile uint32_t *)0x3000002C = 0x00000000;
    *(volatile uint32_t *)0x30000030 = 0x00000000;
    *(volatile uint32_t *)0x30000034 = 0x00000000;
    *(volatile uint32_t *)0x30000038 = 0x00000000;
    *(volatile uint32_t *)0x3000003C = 0x00000000;
    *(volatile uint32_t *)0x30000040 = 0x00000000; // middle

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
	*(volatile uint32_t *)0x30000000 = 0x00000003;
	*(volatile uint32_t *)0x30000004 = 0x00000000;
	*(volatile uint32_t *)0x30000008 = 0x00000000;
	*(volatile uint32_t *)0x3000000C = 0x00000000;
	*(volatile uint32_t *)0x30000010 = 0x00000000;
	*(volatile uint32_t *)0x30000014 = 0x00000000;
	*(volatile uint32_t *)0x30000018 = 0x00000000;
	*(volatile uint32_t *)0x3000001C = 0x00000000;
	*(volatile uint32_t *)0x30000020 = 0x00000000;
	*(volatile uint32_t *)0x30000024 = 0x00000000;
	*(volatile uint32_t *)0x30000028 = 0x00000000;
	*(volatile uint32_t *)0x3000002C = 0x00000000;
	*(volatile uint32_t *)0x30000030 = 0x00000000;
	*(volatile uint32_t *)0x30000034 = 0x00000000;
	*(volatile uint32_t *)0x30000038 = 0x00000000;
	*(volatile uint32_t *)0x3000003C = 0x00000000;
	*(volatile uint32_t *)0x30000040 = 0x00000002; // last

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
