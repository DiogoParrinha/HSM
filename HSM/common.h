/*
 * common.h
 *
 *  Created on: 08/02/2017
 *      Author: diogo
 */

#ifndef COMMON_H_
#define COMMON_H_

#include "drivers/mss_uart/mss_uart.h"
#include "drivers/mss_gpio/mss_gpio.h"
#include "drivers/mss_rtc/mss_rtc.h"

//#include "micro-ecc/uECC.h"
#if !defined(MBEDTLS_CONFIG_FILE)
#include "mbedtls/config.h"
#else
#include MBEDTLS_CONFIG_FILE
#endif

#if defined(MBEDTLS_PLATFORM_C)
#include "mbedtls/platform.h"
#else
//#define mbedtls_printf     __printf
#endif

#include "mbedtls/entropy.h"
#include "mbedtls/ctr_drbg.h"
#include "mbedtls/ecdh.h"
#include "mbedtls/ecdsa.h"

//#define DEBUG_MODE 1
void __printf(char *s);

typedef uint8_t BOOL;
#define TRUE 1
#define FALSE 0

#define ECC_PUBLIC_KEY_SIZE 24 // 48 bytes for P-384 I believe
#define ECC_PUBLIC_KEY_STORE_SIZE 2*ECC_PUBLIC_KEY_SIZE+1 // 2xPUB_KEY_SIZE + 1 (that's how mbedtls_ecp_point_write_binary stores it)
#define ECC_PRIVATE_KEY_SIZE 24 // 32 bytes for P-384 I beleive
#define HASH_SIZE 32

/* Manufacture and device IDs for Winbond Electronics FL128SD___ SPI Flash. */
#define FLASH_MANUFACTURER_ID   (uint8_t)0x01
#define FLASH_DEVICE_ID         (uint8_t)0x17

#define DEV_MODE 1

#define MAX_USERS FLASH_MAX_BLOCKS

#define ERROR_MSG "ERROR: "

/*#define USERS_BASE_ADDRESS 0
#define KEYS_BASE_ADDRESS 4096*/

#define PIN_SIZE (uint8_t)32
#define ADMIN_ID (uint8_t)0
#define ADMIN_PIN (uint8_t*)"12345678912345678912345678912345"

uint32_t calculate_weekday(uint32_t day, uint32_t month, uint32_t year);
uint32_t calculate_totaldays(uint32_t day, uint32_t month, uint32_t year);
uint32_t calculate_week(uint32_t day, uint32_t month, uint32_t year);

#endif /* COMMON_H_ */
