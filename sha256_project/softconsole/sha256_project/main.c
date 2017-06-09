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
    uint32_t inputs = 0;
    int i = 0;
    int t = 0;

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

    memset(hash2, 0, 32);
    mbedtls_sha256(text0, 64, &hash2[0], 0);

    t = 0;
    t++;

    /////////////    /////////////    /////////////
    ////////// Now test with two blocks ///////////
    /////////////    /////////////    /////////////

    uint8_t text01[128] = {0};
    memcpy(text01, text0, 64);
    memcpy(&text01[64], text1, 64);
    memset(hash2, 0, 32);
    mbedtls_sha256(text01, 128, &hash2[0], 0);

    t = 0;
    t++;
    
    /////////////    /////////////    /////////////
    ///////// Now test with three blocks //////////
    /////////////    /////////////    /////////////

    uint8_t text012[192] = {0};
    memcpy(text012, text0, 64);
    memcpy(&text012[64], text1, 64);
    memcpy(&text012[128], text2, 64);
    memset(hash2, 0, 32);
    mbedtls_sha256(text012, 192, &hash2[0], 0);

    t = 0;
    t++;

    /////////////    /////////////    /////////////
    ///////// Now test with four blocks ///////////
    /////////////    /////////////    /////////////

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
    memcpy(text_incomp2, text0, 64);
    memcpy(&text_incomp2[64], text1, 64);
    memcpy(&text_incomp2[128], text2, 32);
    memset(hash2, 0, 32);
    mbedtls_sha256(text_incomp2, 160, &hash2[0], 0);

    /////////////    /////////////    /////////////
    ////// Now test with incomplete words /////////
    /////////////    /////////////    /////////////

    uint8_t text_incomp3[30] = {
    			0x00, 0x00, 0x00, 0x01,
    			0x00, 0x00, 0x00, 0x02,
    			0x00, 0x00, 0x00, 0x03,
    			0x00, 0x00, 0x00, 0x04,
    			0x00, 0x00, 0x00, 0x05,
    			0x00, 0x00, 0x00, 0x06,
    			0x00, 0x00, 0x00, 0x07,
    			0x00, 0x08
    	};
    memset(hash2, 0, 32);
    mbedtls_sha256(text_incomp3, 30, &hash2[0], 0);

    uint8_t text_incomp4[256] = {0};
    memcpy(text_incomp4, text0, 64);
    memcpy(&text_incomp4[64], text1, 11);
    memset(hash2, 0, 32);
    mbedtls_sha256(text_incomp4, 75, &hash2[0], 0);

    ///// END OF TESTS

    MSS_GPIO_set_output( PIN_LED, 0);

    return 0;
}

