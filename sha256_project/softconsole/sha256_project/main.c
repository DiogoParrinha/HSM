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
#define PIN_READ_ENABLE MSS_GPIO_1
#define PIN_LAST_BLOCK MSS_GPIO_2
#define PIN_FIRST_BLOCK MSS_GPIO_3
#define PIN_REQ_DATA MSS_GPIO_4
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
    MSS_GPIO_config( PIN_READ_ENABLE , MSS_GPIO_OUTPUT_MODE ); // Read Enable
    MSS_GPIO_config( PIN_LAST_BLOCK, MSS_GPIO_OUTPUT_MODE ); // Last Block
    MSS_GPIO_config( PIN_FIRST_BLOCK , MSS_GPIO_OUTPUT_MODE ); // First Block
    MSS_GPIO_config( PIN_REQ_DATA, MSS_GPIO_INPUT_MODE ); // Valid Output

    MSS_GPIO_set_output( PIN_LED, 1);
    MSS_GPIO_set_output( PIN_READ_ENABLE, 0);
    MSS_GPIO_set_output( PIN_LAST_BLOCK, 0);
    MSS_GPIO_set_output( PIN_FIRST_BLOCK, 0);
    
    // Write to AHB Slave Interface
    *(volatile uint32_t *)0x30000000 = 0x00000001;
    *(volatile uint32_t *)0x30000004 = 0x00000000;
    *(volatile uint32_t *)0x30000008 = 0x00000000;
    *(volatile uint32_t *)0x3000000C = 0x00000000;
    *(volatile uint32_t *)0x30000010 = 0x00000000;
    *(volatile uint32_t *)0x30000014 = 0x00000000;
    *(volatile uint32_t *)0x30000018 = 0x00000000;
    *(volatile uint32_t *)0x3000001C = 0x00000000;
    *(volatile uint32_t *)0x30000020 = 0x00000000;

    MSS_GPIO_set_output( PIN_READ_ENABLE, 1);
    MSS_GPIO_set_output( PIN_LAST_BLOCK, 1);
    MSS_GPIO_set_output( PIN_FIRST_BLOCK, 1);

    delay();
    delay();
    delay();
    delay();

    for(;;)
    {
    	uint32_t inputs = MSS_GPIO_get_inputs();
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
