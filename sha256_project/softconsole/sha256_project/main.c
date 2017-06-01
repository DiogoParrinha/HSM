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
    MSS_GPIO_config( MSS_GPIO_0 , MSS_GPIO_OUTPUT_MODE );
    //MSS_GPIO_config( MSS_GPIO_1 , MSS_GPIO_OUTPUT_MODE );
    
    // Write to AHB Slave Interface
    *(volatile uint32_t *)0x30000000 = 0x11111111;
    *(volatile uint32_t *)0x30000004 = 0x22222222;
    *(volatile uint32_t *)0x30000008 = 0x33333333;
    *(volatile uint32_t *)0x3000000C = 0x44444444;
    *(volatile uint32_t *)0x30000010 = 0x55555555;
    *(volatile uint32_t *)0x30000014 = 0x66666666;
    *(volatile uint32_t *)0x30000018 = 0x77777777;
    *(volatile uint32_t *)0x3000001C = 0x88888888;
    *(volatile uint32_t *)0x30000020 = 0x99999999;

    /*
     * Infinite loop.
     */
    volatile uint32_t readv = 0;
    for(;;)
    {
        uint32_t gpio_pattern;
        /*
         * Decrement delay counter.
         */
        delay();
        
        /*
         * Toggle GPIO output pattern by doing an exclusive OR of all
         * pattern bits with ones.
         */
        gpio_pattern = MSS_GPIO_get_outputs();
        gpio_pattern ^= 0xFFFFFFFF;
        MSS_GPIO_set_outputs( gpio_pattern );

        readv = *(volatile uint32_t *)0x30000000;
    }
    
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
