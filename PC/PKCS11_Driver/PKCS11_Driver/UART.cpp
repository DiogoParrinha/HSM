#include "stdafx.h"
#include "UART.h"
#include <stdbool.h>
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

FILE *fpIn;

UART::UART() {
	usb = new SerialPort();
	usingKey = false;
	memset(sessionKey, 0, 32);
	fopen_s(&fpIn, "./logIn.txt", "w+");
}
 
UART::~UART() {
	fclose(fpIn);

	if (usb!=NULL)
		disconnect();

	usb = NULL;
}

bool UART::init()
{
	if (usb->connect())
	{
		printf("\nError: cannot connect.\n");
		return false;
	}

	return true;
}

bool UART::checkDevice()
{
	// Send 'DVC_CHECK'
	reqCommand();
	uint8_t buffer[4096];
	sprintf_s((char*)buffer, sizeof(buffer), "DVC_CHECK");
	int r = send(buffer, 9);
	if (r != 9)
	{
		return false;
	}

	// Expect SUCCESS
	memset(buffer, 0, sizeof(buffer));
	r = receive(&buffer[0], 4096);
	if (r != 7)
		return false;
	buffer[7] = '\0';
	if (strcmp((char*)buffer, "SUCCESS") != 0)
		return false;

	// Expect HSM_SERIAL_NUMBER
	uint8_t data[128] = { 0 };
	r = receive(&data[0], 128);
	if (r != strlen(HSM_SERIAL_NUMBER))
	{
		return false;
	}
	buffer[strlen(HSM_SERIAL_NUMBER)] = '\0';
	if (strcmp((char*)data, HSM_SERIAL_NUMBER) != 0)
		return false;

	return true;
}

bool UART::connect()
{
	// Send 'Connected'
	printf("\n\tCONNECTED...");
	uint8_t buffer[4096];
	sprintf_s((char*)buffer, sizeof(buffer), "CONNECTED");
	int r = usb->sendArray(buffer, 9);
	if (r != 9)
	{
		return false;
	}

	waitOK();
	printf("OK\n");

	return true;
}

void UART::setKey(uint8_t * key, bool use)
{
	memcpy(sessionKey, key, 32);
	usingKey = use;
}

void UART::useTime(bool use)
{
	usingTime = use;
}

void UART::disconnect()
{
	usb->disconnect();

	fclose(fpIn);
}

bool UART::reqCommand()
{
	// Send 'COMMAND'
	uint8_t buffer[7] = {'C','O','M','M','A','N','D'};
	if(send(buffer, 7) != 7)
	{
		return false;
	}
	
	waitOK();

	return true;
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
	// Encapsulate data
	uint8_t * data = (uint8_t*)malloc(sizeof(uint8_t)*(len + 4)); // timestamp goes in the last 4B
	if (data == NULL)
		return ERROR_UART_MEMORY;

	memcpy(data, buffer, len);

	// Get timestamp
	time_t t = time(NULL);

	// Place the size into an array
	data[len] = t & 0x000000FF;
	data[len + 1] = (t & 0x0000FF00) >> 8;
	data[len + 2] = (t & 0x00FF0000) >> 16;
	data[len + 3] = (t & 0xFF000000) >> 24;

	int r = send_e(data, len + 4);
	free(data);

	if (r > 0)
		r -= 4;

	return r;
}

int UART::send_e(uint8_t *buffer, uint32_t len)
{
	// > ~4GB? fail (4*1024^3)
	if (len >= 4294967295)
	{
		printf("\nError: can't send data bigger than 4GiB.");
		return ERROR_UART_INVALID_SIZE;
	}

	int ret = 0;
	mbedtls_aes_context aes_ctx;
	mbedtls_md_context_t sha_ctx;
	uint8_t IV[16] = { 0x72, 0x88, 0xd4, 0x11, 0x94, 0xea, 0xf7, 0x1c, 0x31, 0xac, 0xc3, 0x8c, 0xc7, 0xdc, 0x82, 0x4b };
	uint8_t HMAC[32] = { 0 };
	unsigned char data[BLOCK_SIZE];

	uint32_t plainBytesSent = 0;

	if (usingKey)
	{
		mbedtls_aes_init(&aes_ctx);
		mbedtls_md_init(&sha_ctx);

		// Set AES key
		mbedtls_aes_setkey_enc(&aes_ctx, sessionKey, 256);

		// TODO: Generate IV

		// Send IV
		if(usb->sendArray(IV, BLOCK_SIZE) != BLOCK_SIZE)
		{
			return ERROR_UART_INVALID_IV;
		}

		// Wait for OK
		waitOK();

		// Setup HMAC
		ret = mbedtls_md_setup(&sha_ctx, mbedtls_md_info_from_type(MBEDTLS_MD_SHA256), 1);
		if (ret != 0)
		{
			mbedtls_aes_free(&aes_ctx);

			char error[10];
			sprintf_s(error, 10, "E: %d", ret);
			printf(error);
			return ERROR_UART_HMAC_SETUP;
		}

		mbedtls_md_hmac_starts(&sha_ctx, sessionKey, 32);
		mbedtls_md_hmac_update(&sha_ctx, IV, BLOCK_SIZE);
	}

	// Calculate total chunks
	uint32_t totalChunks = len / BLOCK_SIZE;

	// Place the size into an array
	unsigned char size[4];
	size[0] = len & 0x000000FF;
	size[1] = (len & 0x0000FF00) >> 8;
	size[2] = (len & 0x00FF0000) >> 16;
	size[3] = (len & 0xFF000000) >> 24;

	// Place the total chunks into an array
	uint32_t totalC = totalChunks;
	if (usingKey)
	{
		if (len % BLOCK_SIZE != 0)
			totalC++;
	}
	
	unsigned char total_blocks[4];
	total_blocks[0] = totalC & 0x000000FF;
	total_blocks[1] = (totalC & 0x0000FF00) >> 8;
	total_blocks[2] = (totalC & 0x00FF0000) >> 16;
	total_blocks[3] = (totalC & 0xFF000000) >> 24;

	// Send size + total blocks
	// TODO: If the attacker knows the size already, is it dangerous?
	uint8_t dataInfo[8];
	memcpy(dataInfo, size, 4);
	memcpy(dataInfo + 4, total_blocks, 4);

	// Send size
	if (usb->sendArray(dataInfo, sizeof(dataInfo)) != sizeof(dataInfo))
	{
		if (usingKey)
		{
			mbedtls_aes_free(&aes_ctx);
			mbedtls_md_free(&sha_ctx);
		}

		return ERROR_UART_INVALID_DATAINFO;
	}
	// Wait for OK
	waitOK();

	// Add dataInfo to HMAC
	if (usingKey)
	{
		mbedtls_md_hmac_update(&sha_ctx, dataInfo, 8);
	}

	// Send chunks of 16B
	uint8_t ciphertext[BLOCK_SIZE];

	uint32_t bytes = 0;
	uint32_t chunk = 0;
	for (chunk = 0; chunk < totalChunks; chunk++)
	{
		memset(data, 0, sizeof(data));
		memcpy(data, buffer + chunk * BLOCK_SIZE, BLOCK_SIZE);

		if (usingKey)
		{
			// Encrypt block
			memset(ciphertext, 0, BLOCK_SIZE);
			mbedtls_aes_crypt_cbc(&aes_ctx, MBEDTLS_AES_ENCRYPT, BLOCK_SIZE, IV, data, &ciphertext[0]);

			// Update HMAC
			mbedtls_md_hmac_update(&sha_ctx, ciphertext, BLOCK_SIZE);

			// Copy ciphertext to data
			memcpy(data, ciphertext, BLOCK_SIZE);
		}

		uint8_t bw = 0;
		if((bw = usb->sendArray(data, BLOCK_SIZE)) != BLOCK_SIZE)
		{
			if (usingKey)
			{
				mbedtls_aes_free(&aes_ctx);
				mbedtls_md_free(&sha_ctx);
			}

			return ERROR_UART_BLOCK_SIZE_INVALID;
		}

		bytes += bw;
		plainBytesSent += BLOCK_SIZE;

		// Wait for OK
		waitOK();
	}

	// Anything left to sent? (last block may not be 16B)
	if (bytes < len)
	{
		uint32_t remaining = len - bytes;
		if (remaining > BLOCK_SIZE)
		{
			if (usingKey)
			{
				mbedtls_aes_free(&aes_ctx);
				mbedtls_md_free(&sha_ctx);
			}

			return ERROR_UART_BLOCK_SIZE_INVALID;
		}
		memset(data, 0, sizeof(data));
		memcpy(data, buffer + chunk * BLOCK_SIZE, remaining);
		plainBytesSent += remaining;
		
		if (usingKey)
		{
			// TODO: Apply PKCS#7 padding
			// Set the padded bytes to the padded length value
			// Send another block with all bytes set to the padded length value
			add_pkcs_padding(data, BLOCK_SIZE, remaining);
			remaining = BLOCK_SIZE;

			// Encrypt block
			memset(ciphertext, 0, BLOCK_SIZE);
			mbedtls_aes_crypt_cbc(&aes_ctx, MBEDTLS_AES_ENCRYPT, BLOCK_SIZE, IV, data, &ciphertext[0]);

			// Update HMAC
			mbedtls_md_hmac_update(&sha_ctx, ciphertext, BLOCK_SIZE);

			// Copy ciphertext to data
			memcpy(data, ciphertext, BLOCK_SIZE);
		}

		uint8_t bw = 0;
		if ((bw = usb->sendArray(data, remaining)) != remaining)
		{
			if (usingKey)
			{
				mbedtls_aes_free(&aes_ctx);
				mbedtls_md_free(&sha_ctx);
			}

			return ERROR_UART_BLOCK_SIZE_INVALID;
		}

		bytes += bw;

		// Wait for OK
		waitOK();
	}

	// Send HMAC
	if (usingKey)
	{
		// Finally write the HMAC.
		mbedtls_md_hmac_finish(&sha_ctx, HMAC);

		// Send two blocks of 16B
		if ((usb->sendArray(HMAC, BLOCK_SIZE)) != BLOCK_SIZE)
		{
			mbedtls_aes_free(&aes_ctx);
			mbedtls_md_free(&sha_ctx);

			return ERROR_UART_BLOCK_SIZE_INVALID;
		}
		// Wait for OK
		waitOK();
		if ((usb->sendArray(HMAC+ BLOCK_SIZE, BLOCK_SIZE)) != BLOCK_SIZE)
		{
			mbedtls_aes_free(&aes_ctx);
			mbedtls_md_free(&sha_ctx);

			return ERROR_UART_BLOCK_SIZE_INVALID;
		}
		// Wait for OK
		waitOK();

		mbedtls_aes_free(&aes_ctx);
		mbedtls_md_free(&sha_ctx);
	}

	return plainBytesSent;
}

int UART::receive(uint8_t *location, uint32_t locsize)
{
	// Decapsulate data
	uint8_t * data = (uint8_t*)malloc(sizeof(uint8_t)*(locsize + BLOCK_SIZE)); // timestamp goes in the last 4B but since we may need 16B for encryption, let's add 16B
	if (data == NULL)
		return ERROR_UART_MEMORY;
	memcpy(data, location, locsize);

	// Get timestamp
	time_t t = time(NULL);

	int r = receive_e(data, locsize + BLOCK_SIZE);
	if (r <= 0)
	{
		free(data);
		return r;
	}

	// Get the last 4B
	uint32_t rec_timestamp = (0x000000FF & data[r-4])
		| ((0x000000FF & data[r-3]) << 8)
		| ((0x000000FF & data[r-2]) << 16)
		| ((0x000000FF & data[r-1]) << 24);

	// Difference > 10s?
	if (usingTime)
	{
		if (abs(rec_timestamp - t) > 10)
		{
			free(data);
			return ERROR_UART_TIMER;
		}
	}

	r -= 4;

	memset(location, 0, locsize);
	memcpy(location, data, r); // copy r bytes from data to location

	free(data);

	return r;
}

int UART::receive_e(uint8_t *location, uint32_t locsize)
{
	mbedtls_aes_context aes_ctx;
	mbedtls_md_context_t sha_ctx;
	uint8_t HMAC[32] = { 0 };
	uint8_t IV[16];

	uint32_t plainBytesReceived = 0;

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
			mbedtls_aes_free(&aes_ctx);
			
			return ERROR_UART_HMAC_SETUP;
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
	uint32_t size = (0x000000FF & dataArray[0]) | ((0x000000FF & dataArray[1]) << 8) | ((0x000000FF & dataArray[2]) << 16) | ((0x000000FF & dataArray[3]) << 24);
	uint32_t blocks = (0x000000FF & dataArray[4]) | ((0x000000FF & dataArray[5]) << 8) | ((0x000000FF & dataArray[6]) << 16) | ((0x000000FF & dataArray[7]) << 24);

	// Now get the actual command
	memset(location, 0, locsize);

	// Truncate command size
	if (size > locsize)
		size = locsize;

	if (usingKey)
	{
		if (blocks*BLOCK_SIZE > locsize)
			return ERROR_UART_INVALID_BUFFER;
	}

	// Calculate total chunks
	//uint32_t totalChunks = size / BLOCK_SIZE;
	uint32_t totalChunks = blocks;
	// TODO: If the client knows the size, we don't need an extra padding block (this can only be done if attacker knowing the size is not a problem)
	/*if(size % BLOCK_SIZE == 0) // Block boundary -> add another extra block of 0x10
		totalChunks++;*/
	/*if (totalChunks != blocks) // not equal?
	{
		if (usingKey)
		{
			mbedtls_aes_free( &aes_ctx );
			mbedtls_md_free( &sha_ctx );
		}

		return 0;
	}*/

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

			// TODO: if we add the final full padding block, we must remove this if
			// Because right now we're checking if we overlapped the size specified by the client
			// We remove padding, otherwise we assume it's a non-final block
			memset(data, 0, sizeof(data));
			if (plainBytesReceived + BLOCK_SIZE > size)
			{
				// Remove padding from message
				size_t l = 0;
				int r = get_pkcs_padding(plaintext, BLOCK_SIZE, &l);
				if (r == 0)
				{
					plainBytesReceived += l;

					// l contains the actual length of this block
					memcpy(data, plaintext, l);
				}
				else
				{
					plainBytesReceived += BLOCK_SIZE;

					// assume whole block
					memcpy(data, plaintext, BLOCK_SIZE);
				}
			}
			else
			{
				// Non-final block so we copy the plaintext to data
				memcpy(data, plaintext, BLOCK_SIZE);
				plainBytesReceived += BLOCK_SIZE;
			}
		}
		else
			plainBytesReceived += BLOCK_SIZE;
		
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
			mbedtls_aes_free(&aes_ctx);
			mbedtls_md_free(&sha_ctx);

			return ERROR_UART_HMAC_MISMATCH;
		}

		mbedtls_aes_free(&aes_ctx);
		mbedtls_md_free(&sha_ctx);
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

			plainBytesReceived += remaining;

			bytes += remaining;

			// Send OK
			sendOK();
		}
	}

	return plainBytesReceived;
}

bool UART::sendOK()
{
	//if (send((uint8_t *)"01", 2) != 2)
	if (usb->sendArray((uint8_t *)"01", 2) != 2)
		return false;

	return true;
}

bool UART::waitOK()
{
	uint32_t count = 0u;
	
	uint8_t ok[2] = { 0 };
	
	// receive(&ok[0], 2u);
	get(&ok[0], 2u);
	if (ok[0] != '0' || ok[1] != '1')
	{
		printf("NOT OK! ");
		return false;
	}

	return true;
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

	fwrite("\n", sizeof(char), 1, fpIn);
	fwrite(rx_buff, sizeof(char), rx_size, fpIn);

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


void UART::add_pkcs_padding(unsigned char *output, size_t output_len,
	size_t data_len)
{
	size_t padding_len = output_len - data_len;
	unsigned char i;

	for (i = 0; i < padding_len; i++)
		output[data_len + i] = (unsigned char)padding_len;
}

int UART::get_pkcs_padding(unsigned char *input, size_t input_len, size_t *data_len)
{
	size_t i, pad_idx;
	unsigned char padding_len, bad = 0;

	if (NULL == input || NULL == data_len)
		return -1;

	padding_len = input[input_len - 1];
	*data_len = input_len - padding_len;

	/* Avoid logical || since it results in a branch */
	bad |= padding_len > input_len;
	bad |= padding_len == 0;

	/* The number of bytes checked must be independent of padding_len,
	* so pick input_len, which is usually 8 or 16 (one block) */
	pad_idx = input_len - padding_len;
	for (i = 0; i < input_len; i++)
		bad |= (input[i] ^ padding_len) * (i >= pad_idx);

	return(-2 * (bad != 0));
}
