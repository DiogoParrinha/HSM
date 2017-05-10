/*
 * common.h
 *
 *  Created on: 08/02/2017
 *      Author: diogo
 */

#ifndef COMMON_H_
#define COMMON_H_

// comment to use M2S060
#define SECURITY_DEVICE 1

#include "drivers/mss_uart/mss_uart.h"
#include "drivers/mss_gpio/mss_gpio.h"
#include "drivers/mss_rtc/mss_rtc.h"
#include "drivers/mss_sys_services/mss_sys_services.h"

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

/*------------------------------------------------------------------------------
 * System Status
 **/

// System functioning statuses
#define STATUS_DEFAULT 0x0
#define STATUS_INITED 0x01
#define STATUS_CONNECTED 0x02
#define STATUS_LOGGEDIN 0x04
#define STATUS_ISADMIN 0x08

// Failure statuses
#define STATUS_KEY_LOAD_FAILED 0x20
#define STATUS_TAMPER_DETECTED 0x40
#define STATUS_POR_FAILED 0x80

// Tamper detection statuses
#define STATUS_TAMPER_EVENT_DETECTED 0x01
#define STATUS_TAMPER_FAILURE_EVENT_DETECTED 0x02
#define STATUS_TAMPER_CLOCK_ERROR_DETECTED 0x04
#define STATUS_TAMPER_HARDWARE_MONITOR_ERROR_DETECTED 0x08

// POR Digest Check statuses
#define STATUS_POR_FABRIC_DIGEST_FAILED 0x20
#define STATUS_POR_ENVM0_DIGEST_FAILED 0x40
#define STATUS_POR_ENVM1_DIGEST_FAILED 0x80

uint8_t system_status;
uint8_t tamper_status;

/*------------------------------------------------------------------------------
 * Key and Sizes
 **/

// size of ECC public key certificates (1048 seems enough)
#define ECC_PUBLIC_KEY_CERT_SIZE 1048

// size of the PEM strings (512 is enough to hold them)
#define ECC_PUBLIC_KEY_SIZE 512
#define ECC_PRIVATE_KEY_SIZE 512
#define HASH_SIZE 32

// Issuer keys
// P-192
//#define ISSUER_PRIVATE_KEY "-----BEGIN EC PRIVATE KEY-----\nMGACAQEEGQDmasoEkQx8q6S//Ubt+oyQA/4YeoXgj9agCgYIKoZIzj0DAQGhNAMy\nAATFWTpjMnjv9zHHIH2dM1J/RDj0HP+cpvG2eLLKsijkAELpzJhsCwV2ZAAVNp5n\nyXw=\n-----END EC PRIVATE KEY-----\n"
//#define ISSUER_PUBLIC_KEY "-----BEGIN PUBLIC KEY-----\nMEkwEwYHKoZIzj0CAQYIKoZIzj0DAQEDMgAExVk6YzJ47/cxxyB9nTNSf0Q49Bz/\nnKbxtniyyrIo5ABC6cyYbAsFdmQAFTaeZ8l8\n-----END PUBLIC KEY-----\n"
// P-384
//#define ISSUER_PRIVATE_KEY "-----BEGIN EC PRIVATE KEY-----\nMIGkAgEBBDAYR7hMS6pkSYGmvTPh/AdFjha+nJKWqgNd7TJA2sW8wPUd2yD0wpIn\nPPZl69aQfgOgBwYFK4EEACKhZANiAAQwcZr173v0CKLmx+OJ1GLcsNBRnWCxDKWj\nL4sBox7Nk/e9gYZQYa5jQQzh943LtNLXmKz3xTBZD2Gwlyxa5q+gcCcoTbKmCvvD\nrPUQ9B/SD/t3LK1lShsAyHv7O4x42Kc=\n-----END EC PRIVATE KEY-----\n"
//#define ISSUER_PUBLIC_KEY "-----BEGIN PUBLIC KEY-----\nMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEMHGa9e979Aii5sfjidRi3LDQUZ1gsQyl\noy+LAaMezZP3vYGGUGGuY0EM4feNy7TS15is98UwWQ9hsJcsWuavoHAnKE2ypgr7\nw6z1EPQf0g/7dyytZUobAMh7+zuMeNin\n-----END PUBLIC KEY-----\n"

uint8_t ISSUER_PRIVATE_KEY[ECC_PRIVATE_KEY_SIZE];
uint8_t ISSUER_PUBLIC_KEY[ECC_PUBLIC_KEY_SIZE];

// Admin Logs keys
// P-192
//#define LOGS_PRIVATE_KEY "-----BEGIN EC PRIVATE KEY-----\nMGACAQEEGQDmasoEkQx8q6S//Ubt+oyQA/4YeoXgj9agCgYIKoZIzj0DAQGhNAMy\nAATFWTpjMnjv9zHHIH2dM1J/RDj0HP+cpvG2eLLKsijkAELpzJhsCwV2ZAAVNp5n\nyXw=\n-----END EC PRIVATE KEY-----\n"
//#define LOGS_PUBLIC_KEY "-----BEGIN PUBLIC KEY-----\nMEkwEwYHKoZIzj0CAQYIKoZIzj0DAQEDMgAExVk6YzJ47/cxxyB9nTNSf0Q49Bz/\nnKbxtniyyrIo5ABC6cyYbAsFdmQAFTaeZ8l8\n-----END PUBLIC KEY-----\n"
//#define LOGS_PRIVATE_KEY "-----BEGIN EC PRIVATE KEY-----\nMIGkAgEBBDAYR7hMS6pkSYGmvTPh/AdFjha+nJKWqgNd7TJA2sW8wPUd2yD0wpIn\nPPZl69aQfgOgBwYFK4EEACKhZANiAAQwcZr173v0CKLmx+OJ1GLcsNBRnWCxDKWj\nL4sBox7Nk/e9gYZQYa5jQQzh943LtNLXmKz3xTBZD2Gwlyxa5q+gcCcoTbKmCvvD\nrPUQ9B/SD/t3LK1lShsAyHv7O4x42Kc=\n-----END EC PRIVATE KEY-----\n"
//#define LOGS_PUBLIC_KEY "-----BEGIN PUBLIC KEY-----\nMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEMHGa9e979Aii5sfjidRi3LDQUZ1gsQyl\noy+LAaMezZP3vYGGUGGuY0EM4feNy7TS15is98UwWQ9hsJcsWuavoHAnKE2ypgr7\nw6z1EPQf0g/7dyytZUobAMh7+zuMeNin\n-----END PUBLIC KEY-----\n"

uint8_t LOGS_PRIVATE_KEY[ECC_PRIVATE_KEY_SIZE];
uint8_t LOGS_PUBLIC_KEY[ECC_PUBLIC_KEY_SIZE];

uint8_t FLASH_ENCRYPT_KEY[32];
uint8_t FLASH_ENCRYPT_IV[16];

uint8_t SESS_PRIVATE_KEY[ECC_PRIVATE_KEY_SIZE];
uint8_t SESS_PUBLIC_KEY[ECC_PUBLIC_KEY_SIZE];

/*------------------------------------------------------------------------------
 * Flash
 **/
// Manufacture and device IDs for Winbond Electronics FL128SD___ SPI Flash.
#define FLASH_MANUFACTURER_ID   (uint8_t)0x01
#define FLASH_DEVICE_ID         (uint8_t)0x17

#define FLASH_GLOBAL_BASE_ADDRESS 0
#define FLASH_USERS_BASE_ADDRESS 1

// 255 blocks lead to 255 hashes in the eNVM (that's ~8KB)
// because we'd need more than 1B to store greater IDs, we stick to 255 as the maximum
#define FLASH_MAX_USER_BLOCKS 255 // 1-255
#define MAX_USERS FLASH_MAX_USER_BLOCKS

#define FLASH_BLOCK_SIZE 4096

/*------------------------------------------------------------------------------
 * Global PINs
 **/
#define HASHED_PIN_SIZE (uint8_t)32
#define PIN_SIZE (uint8_t)32
#define ADMIN_ID (uint8_t)0
uint8_t ADMIN_PIN[PIN_SIZE];

/*------------------------------------------------------------------------------
 * Buffers
 **/
#define GLOBAL_BUFFER_SIZE FLASH_BLOCK_SIZE*2
uint8_t global_buffer[GLOBAL_BUFFER_SIZE]; // goes in the BSS section

/*------------------------------------------------------------------------------
 * Other functions
 **/
uint32_t calculate_weekday(uint32_t day, uint32_t month, uint32_t year);
uint32_t calculate_totaldays(uint32_t day, uint32_t month, uint32_t year);
uint32_t calculate_week(uint32_t day, uint32_t month, uint32_t year);
int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len, size_t *olen);
//uint8_t get_timestamp();
void add_pkcs_padding(unsigned char *output, size_t output_len, size_t data_len);
int get_pkcs_padding(unsigned char *input, size_t input_len, size_t *data_len);
uint32_t convertDateToUnixTime(const mss_rtc_calendar_t *date);

/*------------------------------------------------------------------------------
  RTC prescaler value.
  Uncomment the value corresponding to your hardware configuration.
 */
/* #define RTC_PRESCALER    (32768u - 1u)    */ /* 32KHz crystal is RTC clock source. */
/* #define RTC_PRESCALER    (1000000u - 1u) */       /* 1MHz clock is RTC clock source. */
/*#define RTC_PRESCALER    (25000000u - 1u) */ /* 25MHz clock is RTC clock source. */
#define RTC_PRESCALER    (50000000u - 1u) /* 50MHz clock is RTC clock source. */

/*------------------------------------------------------------------------------
 * System Services
 **/
// DRBG
uint8_t drbg_handle;

void sys_services_event_handler(uint8_t opcode, uint8_t response);
void sys_services_data_event_handler(uint8_t error_type);
int sys_keys_to_pem(uint8_t * private_key, uint8_t * pub_dest, uint32_t pub_size, uint8_t * pri_dest, uint32_t pri_size);

#include "UART.h"
#include "SPIFLASH.h"
#include "PKC.h"
#include "SecComm.h"
#include "User.h"
#include "Command.h"
#include "Logs.h"

#endif /* COMMON_H_ */
