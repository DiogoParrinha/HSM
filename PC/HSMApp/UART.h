#ifndef UART_H
#define UART_H

#include <windows.h>
#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include "SerialPort.h"

 
class UART {
	private:
		void clear_variable(uint8_t *p_var, uint16_t size);
		uint8_t convert_ascii_to_hex(uint8_t* arr, uint32_t length);
		uint8_t validate_input(uint8_t ascii_input);
		uint8_t getDataFormatted(uint8_t* src_ptr, uint8_t size);
		size_t getDataUART(uint8_t * rx_buff, size_t buff_size);
		uint8_t get(uint8_t* src_ptr, uint8_t size);
		void waitOK();
		void sendOK();
		void printBits(size_t const size, void const * const ptr);
		SerialPort *usb;

	public:
		UART();
		~UART();
	 
		void connect();
		void disconnect();

		void reqCommand();

		uint32_t receive(uint8_t *location, uint32_t locsize);
		int send(uint8_t *buffer, uint32_t len);
		void display(const uint8_t * in_buffer, uint32_t byte_length);
};

#endif // UART_H
