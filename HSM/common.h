/*
 * common.h
 *
 *  Created on: 08/02/2017
 *      Author: diogo
 */

#ifndef COMMON_H_
#define COMMON_H_

// comment to use M2S060
//#define SECURITY_DEVICE 1

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

//#define DEBUG_MODE 1
void __printf(char *s);

typedef uint8_t BOOL;
#define TRUE 1
#define FALSE 0

// size of ECC public key certificates (1048 seems enough)
#define ECC_PUBLIC_KEY_CERT_SIZE 1048

// size of the PEM strings (512 is enough to hold them)
#define ECC_PUBLIC_KEY_SIZE 512
#define ECC_PRIVATE_KEY_SIZE 512
#define HASH_SIZE 32

// Issuer keys
#define ISSUER_PRIVATE_KEY "-----BEGIN EC PRIVATE KEY-----\nMGACAQEEGQDmasoEkQx8q6S//Ubt+oyQA/4YeoXgj9agCgYIKoZIzj0DAQGhNAMy\nAATFWTpjMnjv9zHHIH2dM1J/RDj0HP+cpvG2eLLKsijkAELpzJhsCwV2ZAAVNp5n\nyXw=\n-----END EC PRIVATE KEY-----\n"
#define ISSUER_PUBLIC_KEY "-----BEGIN PUBLIC KEY-----\nMEkwEwYHKoZIzj0CAQYIKoZIzj0DAQEDMgAExVk6YzJ47/cxxyB9nTNSf0Q49Bz/\nnKbxtniyyrIo5ABC6cyYbAsFdmQAFTaeZ8l8\n-----END PUBLIC KEY-----\n"

// Admin Logs keys
#define LOGS_PRIVATE_KEY "-----BEGIN EC PRIVATE KEY-----\nMGACAQEEGQDmasoEkQx8q6S//Ubt+oyQA/4YeoXgj9agCgYIKoZIzj0DAQGhNAMy\nAATFWTpjMnjv9zHHIH2dM1J/RDj0HP+cpvG2eLLKsijkAELpzJhsCwV2ZAAVNp5n\nyXw=\n-----END EC PRIVATE KEY-----\n"
#define LOGS_PUBLIC_KEY "-----BEGIN PUBLIC KEY-----\nMEkwEwYHKoZIzj0CAQYIKoZIzj0DAQEDMgAExVk6YzJ47/cxxyB9nTNSf0Q49Bz/\nnKbxtniyyrIo5ABC6cyYbAsFdmQAFTaeZ8l8\n-----END PUBLIC KEY-----\n"

/// ----- FLASH ----- ///
/* Manufacture and device IDs for Winbond Electronics FL128SD___ SPI Flash. */
#define FLASH_MANUFACTURER_ID   (uint8_t)0x01
#define FLASH_DEVICE_ID         (uint8_t)0x17

#define FLASH_GLOBAL_BASE_ADDRESS 0
#define FLASH_USERS_BASE_ADDRESS 1
//#define FLASH_LOGS_BASE_ADDRESS 2000 // currently not used

// 255 blocks lead to 255 hashes in the eNVM (that's ~8KB)
// because we'd need more than 1B to store greater IDs, we stick to 255 as the maximum
#define FLASH_MAX_USER_BLOCKS 255 // 1-255
#define MAX_USERS FLASH_MAX_USER_BLOCKS

#define FLASH_BLOCK_SIZE 4096
/// ----- FLASH ----- ///

#define PIN_SIZE (uint8_t)32
#define ADMIN_ID (uint8_t)0
#define ADMIN_PIN (uint8_t*)"12345678912345678912345678912345"

#define GLOBAL_BUFFER_SIZE FLASH_BLOCK_SIZE
uint8_t global_buffer[GLOBAL_BUFFER_SIZE]; // goes in the BSS section

uint32_t calculate_weekday(uint32_t day, uint32_t month, uint32_t year);
uint32_t calculate_totaldays(uint32_t day, uint32_t month, uint32_t year);
uint32_t calculate_week(uint32_t day, uint32_t month, uint32_t year);
int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len, size_t *olen);
//uint8_t get_timestamp();
void add_pkcs_padding(unsigned char *output, size_t output_len, size_t data_len);
int get_pkcs_padding(unsigned char *input, size_t input_len, size_t *data_len);

// RNG Handle
uint8_t drbg_handle;

/*------------------------------------------------------------------------------
  RTC prescaler value.
  Uncomment the value corresponding to your hardware configuration.
 */
/* #define RTC_PRESCALER    (32768u - 1u)    */ /* 32KHz crystal is RTC clock source. */
/* #define RTC_PRESCALER    (1000000u - 1u) */       /* 1MHz clock is RTC clock source. */
/*#define RTC_PRESCALER    (25000000u - 1u) */ /* 25MHz clock is RTC clock source. */
#define RTC_PRESCALER    (50000000u - 1u) /* 50MHz clock is RTC clock source. */

#include "UART.h"
#include "SPIFLASH.h"
#include "PKC.h"
#include "SecComm.h"
#include "User.h"
#include "Command.h"
#include "Logs.h"

#endif /* COMMON_H_ */
