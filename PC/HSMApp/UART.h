#ifndef UART_H
#define UART_H

#include <windows.h>
#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include "SerialPort.h"

#define ERROR_UART_HMAC_SETUP 			0x01
#define ERROR_UART_CHUNKS_MISMATCH 		0x02
#define ERROR_UART_HMAC_MISMATCH 		0x03
#define ERROR_UART_BLOCK_SIZE_INVALID	0x04
#define ERROR_UART_INVALID_SIZE			0x05
 
class UART {
	private:
		void clear_variable(uint8_t *p_var, uint16_t size);
		uint8_t convert_ascii_to_hex(uint8_t* arr, uint32_t length);
		uint8_t validate_input(uint8_t ascii_input);
		uint8_t getDataFormatted(uint8_t* src_ptr, uint8_t size);
		size_t getDataUART(uint8_t * rx_buff, size_t buff_size);
		uint8_t get(uint8_t* src_ptr, uint8_t size);
		void printBits(size_t const size, void const * const ptr);
		void add_pkcs_padding(unsigned char *output, size_t output_len, size_t data_len);
		int get_pkcs_padding(unsigned char *input, size_t input_len, size_t *data_len);

		SerialPort *usb;
		bool usingKey;
		uint8_t sessionKey[32];

	public:
		UART();
		~UART();
	 
		void init();
		void connect();
		void disconnect();

		void reqCommand();

		void setKey(uint8_t * key);
		uint32_t receive(uint8_t *location, uint32_t locsize);
		int send(uint8_t *buffer, uint32_t len);
		void display(const uint8_t * in_buffer, uint32_t byte_length);

		void waitOK();
		void sendOK();
};

#endif // UART_H
