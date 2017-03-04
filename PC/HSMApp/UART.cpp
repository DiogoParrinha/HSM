#include "stdafx.h"
#include "UART.h"
#include <cstdlib>
#include <cmath>

#include "mbedtls/config.h"

#if defined(MBEDTLS_PLATFORM_C)
#include "mbedtls/platform.h"
#else
#include <stdio.h>
#define mbedtls_printf     printf
#endif

#define VERBOSE 0

#include "mbedtls/entropy.h"
#include "mbedtls/ctr_drbg.h"
#include "mbedtls/ecdh.h"
#include "mbedtls/aes.h"
#include "mbedtls/sha256.h"
#include "mbedtls/md.h"

#define BLOCK_SIZE 16

//#define DEBUG_MODE 1

UART::UART() {
	usb = new SerialPort();
	usingKey = false;
}
 
UART::~UART() {
	if (usb!=NULL)
		disconnect();

	usb = NULL;
}

void UART::init()
{
	printf("Linking...");
	if (usb->connect())
	{
		printf("\nError: cannot connect.\n");
		return;
	}
	printf("OK.\n");
}

void UART::connect()
{
	// Send 'Connected'
	printf("Sending CONNECTED...");
	uint8_t buffer[4096];
	sprintf_s((char*)buffer, sizeof(buffer), "CONNECTED");
	usb->sendArray(buffer, 9);

	// Wait for 'OK'
#ifndef DEBUG_MODE
	waitOK();
#endif

	printf("OK\n");
}

void UART::setKey(uint8_t * key)
{
	memcpy(sessionKey, key, 32);
	usingKey = true;
}

void UART::disconnect()
{
	usb->disconnect();
}

void UART::reqCommand()
{
	// Send 'COMMAND'
	printf("Sending COMMAND...");
	uint8_t buffer[4096];
	sprintf_s((char*)buffer, sizeof(buffer), "COMMAND");
	usb->sendArray(buffer, 7);

	// Wait for 'OK'
#ifndef DEBUG_MODE
	waitOK();
#endif

	printf("OK\n");
}
 
uint8_t UART::get
(
	uint8_t* location,
	uint8_t size
)
{
	uint8_t count = 0u;

	/* Clear the memory location. */
	clear_variable(location, size);

	// Read data
	getDataUART(location, size);

	/* Read the 16 bytes of input data from UART terminal. */
	//count = getDataUART(location, size);

	/* Convert ASCII key to Hex format */
	//convert_ascii_to_hex(location, size);

	return count;
}

int UART::send(uint8_t *buffer, uint32_t len)
{
	// > ~4GB? fail (4*1024^3)
	if (len >= 4294967295)
	{
		printf("\nError: can't send data bigger than 4GiB.");
		return -1;
	}

	// Place the size into an array
	unsigned char size[4];
	size[0] = len & 0x000000FF;
	size[1] = (len & 0x0000FF00) >> 8;
	size[2] = (len & 0x00FF0000) >> 16;
	size[3] = (len & 0xFF000000) >> 24;

	printf("Size (%ld | %d):\n", len, sizeof(len));

#ifdef DEBUG_MODE
	printf("Size (%ld | %d):\n", len, sizeof(len));
	printBits(sizeof(size[0]), &size[0]);
	printBits(sizeof(size[1]), &size[1]);
	printBits(sizeof(size[2]), &size[2]);
	printBits(sizeof(size[3]), &size[3]);
	printf("\n");

	// Putting the size back together
	uint32_t s = (0x000000FF & size[0]) | ((0x000000FF & size[1]) << 8) | ((0x000000FF & size[2]) << 16) | ((0x000000FF & size[3]) << 24);
	printf("New size: %d\n", s);
#else
	// Send size
	if (usb->sendArray(size, sizeof(size)) != sizeof(size))
	{
		printf("\nError: (size) total bytes sent do not match.");
		return -1;
	}

	// Wait for OK
	waitOK();
#endif

	// Calculate total chunks
	uint32_t totalChunks = len / BLOCK_SIZE;

	// Send chunks of 16B
	unsigned char data[BLOCK_SIZE+1]; // +1 because we want the last char to be 0 for printing possibilities
	memset(data, 0, sizeof(data));

	uint32_t bytes = 0;
	uint32_t chunk = 0;
	for (chunk = 0; chunk < totalChunks; chunk++)
	{
		memset(data, 0, sizeof(data));
		memcpy(data, buffer + chunk * BLOCK_SIZE, BLOCK_SIZE);

#ifdef DEBUG_MODE
		printf("\ndata (%d): %s", chunk * BLOCK_SIZE, data);

		bytes += BLOCK_SIZE;
#else
		uint8_t bw = 0;
		if((bw = usb->sendArray(data, BLOCK_SIZE)) != BLOCK_SIZE)
		{
			printf("\nError: (block %d) total bytes sent do not match.", chunk);
			return -1;
		}

		bytes += bw;

		// Wait for OK
		waitOK();
#endif
	}

	// Anything left to sent? (last block may not be 16B)
	if (bytes < len)
	{
		uint32_t remaining = len - bytes;
		if (remaining > BLOCK_SIZE)
		{
			printf("\nError: remaining amount bigger than block size.");
			return -1;
		}
		memset(data, 0, sizeof(data));
		memcpy(data, buffer + chunk * BLOCK_SIZE, remaining);
		
#ifdef DEBUG_MODE
		printf("\nremaining (%d): %s", remaining, data);

		bytes += remaining;
#else
		uint8_t bw = 0;
		if ((bw = usb->sendArray(data, remaining)) != remaining)
		{
			printf("\nError: (block %d) total bytes sent do not match.", chunk);
			return -1;
		}

		bytes += bw;

		// Wait for OK
		waitOK();
#endif
	}
	
	return bytes;
}

uint32_t UART::receive(uint8_t *location, uint32_t locsize)
{
	mbedtls_aes_context aes_ctx;
	mbedtls_md_context_t sha_ctx;
	uint8_t HMAC[32] = { 0 };
	uint8_t IV[16];

	if (usingKey)
	{
		mbedtls_aes_init(&aes_ctx);
		mbedtls_md_init(&sha_ctx);

		// Set AES key
		//mbedtls_aes_setkey_enc(&aes_ctx, sessionKey, 256);
		mbedtls_aes_setkey_dec(&aes_ctx, sessionKey, 256);

		// Expect IV (16B)
		get(&IV[0], 16u);
		sendOK();

		// Setup HMAC
		int ret = mbedtls_md_setup(&sha_ctx, mbedtls_md_info_from_type(MBEDTLS_MD_SHA256), 1);
		if (ret != 0)
		{
			char error[10];
			sprintf_s(error, 10, "\nE: %d\n", ret);
			printf(error);
			return -1;
		}

		mbedtls_md_hmac_starts(&sha_ctx, sessionKey, 32);
		mbedtls_md_hmac_update(&sha_ctx, IV, BLOCK_SIZE);
	}

	// Expect data size (bytes) first
	// We are supposed to receive 4B
	// Size is split among 4B (up to ~4GB (4*1024^3))
	uint8_t dataArray[8];
	get(&dataArray[0], 8u);
	// Send OK
	sendOK();

	// Add dataInfo to HMAC
	if (usingKey)
	{
		mbedtls_md_hmac_update(&sha_ctx, dataArray, 8);
	}

	// Put back the size together into a 32 bit integer
	volatile uint32_t size = (0x000000FF & dataArray[0]) | ((0x000000FF & dataArray[1]) << 8) | ((0x000000FF & dataArray[2]) << 16) | ((0x000000FF & dataArray[3]) << 24);
	volatile uint32_t blocks = (0x000000FF & dataArray[4]) | ((0x000000FF & dataArray[5]) << 8) | ((0x000000FF & dataArray[6]) << 16) | ((0x000000FF & dataArray[7]) << 24);

	// Now get the actual command
	memset(location, 0, locsize);

	// Truncate command size
	if (size > locsize)
		size = locsize;

	// Calculate total chunks
	uint32_t totalChunks = size / BLOCK_SIZE;
	// TODO: If the client knows the size, we don't need an extra padding block (this can only be done if attacker knowing the size is not a problem)
	/*if(size % BLOCK_SIZE == 0) // Block boundary -> add another extra block of 0x10
		totalChunks++;*/
	if (totalChunks != blocks) // not equal?
	{
		return 0;
	}

	// Send chunks of 16B
	unsigned char data[BLOCK_SIZE];
	memset(data, 0, sizeof(data));

	uint32_t bytes = 0;
	uint32_t chunk = 0;
	for (chunk = 0; chunk < totalChunks; chunk++)
	{
		memset(data, 0, sizeof(data));

		// Read chunk
		get(data, BLOCK_SIZE);

		if (usingKey)
		{
			// Update HMAC
			mbedtls_md_hmac_update(&sha_ctx, data, BLOCK_SIZE);

			// Decrypt
			uint8_t plaintext[BLOCK_SIZE];
			mbedtls_aes_crypt_cbc(&aes_ctx, MBEDTLS_AES_DECRYPT, BLOCK_SIZE, IV, data, &plaintext[0]);

			memcpy(data, plaintext, BLOCK_SIZE);
		}
		
		memcpy(location + chunk * BLOCK_SIZE, data, BLOCK_SIZE);
		
		bytes += BLOCK_SIZE;

		// Wait for OK
		sendOK();
	}

	if (usingKey)
	{
		// Finally write the HMAC.
		mbedtls_md_hmac_finish(&sha_ctx, HMAC);

		// The last two 16B blocks make up the HMAC
		// HMAC(IV || dataInfo || C)
		// Compare HMACs
		uint8_t recHMAC[32];
		get(&recHMAC[0], 16u);
		// Send OK
		sendOK();
		get(&recHMAC[16], 16u);
		// Send OK
		sendOK();

		// Compare HMACs
		unsigned char diff = 0;
		for (int i = 0; i < 32; i++)
			diff |= HMAC[i] ^ recHMAC[i]; // XOR = 1 if one is different from the other

		if (diff != 0)
		{
			mbedtls_fprintf(stderr, "HMAC check failed: wrong key, "
				"or file corrupted.\n");
			return -1;
		}
		else
			printf("\nHMAC-256 Matches.\n");
	}
	else
	{
		// Anything left to sent? (last block may not be 16B)
		// Only happens when not in a secure communication (otherwise the last block is padded so it matches 16B)
		if (bytes < size)
		{
			uint32_t remaining = size - bytes;
			if (remaining > BLOCK_SIZE)
			{
				printf("\nError: remaining amount bigger than block size: %d (total size: %d | %d).", remaining, size, bytes);
				return 0;
			}
			memset(data, 0, sizeof(data));

			// Read remaining data
			get(data, remaining);

			memcpy(location + chunk * BLOCK_SIZE, data, remaining);

			bytes += remaining;

			// Send OK
			sendOK();
		}
	}

	return size;
}

void UART::sendOK()
{
	usb->sendArray((uint8_t *)"01", 2);
}

void UART::waitOK()
{
	uint16_t count = 0u;
	
	uint8_t ok[64] = { 0 };
	
	get(&ok[0], 2u);
	if (ok[0] != '0' || ok[1] != '1')
	{
		printf("NOT OK! ");
	}
}

void UART::clear_variable(uint8_t *p_var, uint16_t size)
{
	uint16_t inc;

	for (inc = 0; inc < size; inc++)
	{
		*p_var = 0x00;
		p_var++;
	}
}

void UART::display
(
	const uint8_t * in_buffer,
	uint32_t byte_length
)
{
	char display_buffer[128];
	uint32_t inc;

	if (byte_length > 8u)
	{
		printf("\r\n");
	}

	for (inc = 0; inc < byte_length; ++inc)
	{
		if ((inc > 1u) && (0u == (inc % 8u)))
		{
			printf("\r\n");
		}
		snprintf((char *)display_buffer,
			sizeof(display_buffer),
			"%02x", in_buffer[inc]);
		printf(" 0x");
		printf((const char *)display_buffer);
	}
}

size_t UART::getDataUART
(
	uint8_t * rx_buff,
	size_t buff_size
)
{
	size_t rx_size = 0U;

	uint8_t tmp_size = 0u;
	unsigned char tmp_buff[256];
	clear_variable(tmp_buff, 256);

	while (rx_size < buff_size)
	{
		tmp_size = usb->getArray(tmp_buff, 1); // Byte by Byte
		if(tmp_size > 0)
		{
			rx_buff[rx_size] = tmp_buff[0];
			++rx_size;
		}
	}

	return rx_size;
}

uint8_t UART::getDataFormatted
(
	uint8_t* src_ptr,
	uint8_t size
)
{
	uint8_t complete = 0u;
	uint8_t rx_size = 0u;
	unsigned char rx_buff[256];
	clear_variable(rx_buff, 256);

	/* Read the key size sent by user and store it. */
	uint8_t count = 0u;
	while (!complete)
	{
		rx_size = usb->getArray(rx_buff, sizeof(rx_buff));
		if (rx_size > 0u)
		{
			int i;
			for (i = 0; i<size; i++)
			{
				// Is entered key valid
				if (validate_input(rx_buff[i]) != 1u)
				{
					printf("%c", rx_buff[i]);
					printf("\r\n Invalid input.");
					complete = 0u;
					count = 0u;
					clear_variable(src_ptr, 4);
				}
				else
				{
					src_ptr[count] = rx_buff[i];

					// Switching to next line after every 8 bytes 
					if (((count % 16u) == 0x00u) && (count > 0x00u) && (complete != 0x01u))
					{
						printf("\n\r");
					}

					if ((count % 2u) == 0u)
					{
						printf(" 0x");
					}
					printf("%c", rx_buff[i]);
					count++;
					if (size == count)
					{
						complete = 1u;
					}
				}
			}
		}
	}

	return count;
}

uint8_t UART::convert_ascii_to_hex(uint8_t* arr, uint32_t length)
{
	uint32_t inc = 0u;
	uint8_t nb_digit = 0u;
	uint8_t hex_byte = 0u;
	uint8_t error_flag = 0u;
	uint8_t* src_ptr = arr;
	uint8_t* dst_ptr = arr;

	for (inc = 0; inc < length; inc++)
	{
		if ((*src_ptr >= '0') && (*src_ptr <= '9'))
		{
			hex_byte = (hex_byte * 16u) + (*src_ptr - '0');
			*src_ptr = 0u;
			src_ptr++;
			nb_digit++;
		}
		else if ((*src_ptr >= 'a') && (*src_ptr <= 'f'))
		{
			hex_byte = (hex_byte * 16u) + (*src_ptr - 'a') + 10u;
			*src_ptr = 0u;
			src_ptr++;
			nb_digit++;
		}
		else if ((*src_ptr >= 'A') && (*src_ptr <= 'F'))
		{
			hex_byte = (hex_byte * 16u) + (*src_ptr - 'A') + 10u;
			*src_ptr = 0u;
			src_ptr++;
			nb_digit++;
		}
		else if (*src_ptr != 0x00u)
		{
			printf("\r\n Invalid data.");
			error_flag = 1u;
			break;
		}

		if (nb_digit >= 2u)
		{
			*dst_ptr = hex_byte;
			nb_digit = 0u;
			hex_byte = 0u;
			dst_ptr++;
		}
	}

	if (nb_digit == 1u)
	{
		*dst_ptr = (hex_byte * 16u);
	}
	return error_flag;
}
 
uint8_t UART::validate_input(uint8_t ascii_input)
{
	uint8_t valid_key = 0u;

	if (((ascii_input >= 'A') && (ascii_input <= 'F')) || \
		((ascii_input >= 'a') && (ascii_input <= 'f')) || \
		((ascii_input >= '0') && (ascii_input <= '9')))
	{
		valid_key = 1u;
	}
	else
	{
		valid_key = 0u;
	}
	return valid_key;
}

void UART::printBits(size_t const size, void const * const ptr)
{
	unsigned char *b = (unsigned char*)ptr;
	unsigned char byte;
	int i, j;

	for (i = size - 1; i >= 0; i--)
	{
		for (j = 7; j >= 0; j--)
		{
			byte = (b[i] >> j) & 1;
			printf("%u", byte);
		}
	}
	puts("");
}
