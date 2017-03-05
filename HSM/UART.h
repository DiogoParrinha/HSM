#ifndef UART_H
#define UART_H

#include <string.h>
#include <stdlib.h>
#include "drivers/mss_uart/mss_uart.h"
#include "common.h"

#define BLOCK_SIZE 16

#define ERROR_UART_HMAC_SETUP 			0x01
#define ERROR_UART_CHUNKS_MISMATCH 		0x02
#define ERROR_UART_HMAC_MISMATCH 		0x03
#define ERROR_UART_BLOCK_SIZE_INVALID	0x04
#define ERROR_UART_INVALID_SIZE			0x05

/*==============================================================================
  Globlal Variables
 */
uint8_t UART_sessionKey[32]; // 256-bit key
BOOL UART_usingKey;

/*==============================================================================
  Macro
 */
#define   BUFFER_SIZE			  1024
#define   ENTER                   13u
#define   VALID                   0U
#define   INVALID                 1U
#define   INIT_VECTOR_VALUE       8u
#define   ASCII_2_CHARACTERS      2u
#define   ASCII_32_CHARACTERS     32u
#define   ASCII_64_CHARACTERS     (ASCII_32_CHARACTERS * 2)
#define   ASCII_128_CHARACTERS    (ASCII_32_CHARACTERS * 4)
#define   DATA_LENGTH_128_BITS    ASCII_32_CHARACTERS
#define   DATA_LENGTH_256_BITS    ASCII_64_CHARACTERS
#define   DATA_LENGTH_512_BITS    ASCII_128_CHARACTERS
#define   DATA_LENGTH_16_BYTES    (ASCII_32_CHARACTERS / 2)
#define   DATA_LENGTH_32_BYTES    (ASCII_64_CHARACTERS / 2)
#define   DATA_LENGTH_64_BYTES    (ASCII_128_CHARACTERS / 2)

/*==============================================================================
  Functions
 */
void __printf(char *s);
void UART_clear_variable(uint8_t *p_var, uint16_t size);
uint8_t UART_convert_ascii_to_hex(uint8_t* arr, uint32_t length);
uint8_t UART_validate_input(uint8_t ascii_input);
uint8_t UART_getDataUART(uint8_t* src_ptr, uint8_t size);
void UART_waitOK();
void UART_sendOK();
void UART_waitCOMMAND();
uint8_t UART_receive(char *location, uint32_t locsize);
size_t UART_Polled_Rx(mss_uart_instance_t * this_uart, uint8_t * rx_buff, size_t buff_size);

void UART_setKey(uint8_t * key);
void UART_init();
BOOL UART_connect();
uint8_t UART_get(uint8_t* src_ptr, uint8_t size);
uint8_t UART_send(uint8_t *buffer, uint32_t len);
void UART_display(const uint8_t * in_buffer, uint32_t byte_length);

#endif // UART_H
