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
static void delay(void);

#define PIN_LED MSS_GPIO_0
#define PIN_DATA_IN_READY MSS_GPIO_1
#define PIN_LAST_BLOCK MSS_GPIO_2
#define PIN_FIRST_BLOCK MSS_GPIO_3
#define PIN_REQ_DATA MSS_GPIO_4
#define PIN_DATA_OUT_READY MSS_GPIO_4
#define PIN_VALID_OUTPUT MSS_GPIO_5
#define PIN_ERROR_OUTPUT MSS_GPIO_6
#define PIN_RESET MSS_GPIO_7
/*==============================================================================
 * main() function.
 */
int main()
{
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
    MSS_GPIO_config( PIN_REQ_DATA, MSS_GPIO_INPUT_MODE ); // Valid Output
    MSS_GPIO_config( PIN_DATA_OUT_READY, MSS_GPIO_INPUT_MODE ); // Data Out Ready (first bank of registers)
    MSS_GPIO_config( PIN_VALID_OUTPUT, MSS_GPIO_INPUT_MODE ); // Valid
    MSS_GPIO_config( PIN_ERROR_OUTPUT, MSS_GPIO_INPUT_MODE ); // Error

    MSS_GPIO_set_output( PIN_DATA_IN_READY, 0);
    MSS_GPIO_set_output( PIN_RESET, 0);
    MSS_GPIO_set_output( PIN_RESET, 1);

    volatile uint32_t readv = 0;
	readv = *(volatile uint32_t *)0x30000000;
	readv = *(volatile uint32_t *)0x30000004;
	readv = *(volatile uint32_t *)0x30000008;
	readv = *(volatile uint32_t *)0x3000000C;
	readv = *(volatile uint32_t *)0x30000010;
	readv = *(volatile uint32_t *)0x30000014;
	readv = *(volatile uint32_t *)0x30000018;
	readv = *(volatile uint32_t *)0x3000001C;
	readv = *(volatile uint32_t *)0x30000020;

    MSS_GPIO_set_output( PIN_LED, 1);
    
    delay();

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

    uint32_t inputs = MSS_GPIO_get_inputs();
    while(!(inputs & 0x80)) // 8th bit is 1 (data_available -> we can enable reading and give the data_out_ready signal)
    {
    	inputs = MSS_GPIO_get_inputs();
    }

    delay();
    delay();
    delay();
    delay();

    MSS_GPIO_set_output( PIN_DATA_IN_READY, 1);

    delay();
    delay();
    delay();

    readv = *(volatile uint32_t *)0x30000000;
	readv = *(volatile uint32_t *)0x30000004;
	readv = *(volatile uint32_t *)0x30000008;
	readv = *(volatile uint32_t *)0x3000000C;
	readv = *(volatile uint32_t *)0x30000010;
	readv = *(volatile uint32_t *)0x30000014;
	readv = *(volatile uint32_t *)0x30000018;
	readv = *(volatile uint32_t *)0x3000001C;
	readv = *(volatile uint32_t *)0x30000020;



    delay();
    delay();
    delay();
    delay();
    delay();

    for(;;)
    {
    	readv = *(volatile uint32_t *)0x30000000;
    	readv = *(volatile uint32_t *)0x30000004;
    	readv = *(volatile uint32_t *)0x30000008;
    	readv = *(volatile uint32_t *)0x3000000C;
    	readv = *(volatile uint32_t *)0x30000010;
    	readv = *(volatile uint32_t *)0x30000014;
    	readv = *(volatile uint32_t *)0x30000018;
    	readv = *(volatile uint32_t *)0x3000001C;
    	readv = *(volatile uint32_t *)0x30000020;


    	inputs = MSS_GPIO_get_inputs();
    }

    /*
     * Infinite loop.
     */
    /*volatile uint32_t readv = 0;
    for(;;)
    {
        uint32_t gpio_pattern;
        //Decrement delay counter.
        delay();
        
        // Toggle GPIO output pattern by doing an exclusive OR of all pattern bits with ones.
        gpio_pattern = MSS_GPIO_get_outputs();
        gpio_pattern ^= 0xFFFFFFFF;
        MSS_GPIO_set_outputs( gpio_pattern );

        readv = *(volatile uint32_t *)0x30000000;
    }*/
    
    return 0;
}

/*==============================================================================
  Delay between displays of the watchdog counter value.
 */
static void delay(void)
{
    volatile uint32_t delay_count = SystemCoreClock / 128u;
    
    while(delay_count > 0u)
    {
        --delay_count;
    }
}
