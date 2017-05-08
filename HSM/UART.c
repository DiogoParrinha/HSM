
#include <math.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include "UART.h"

/*==============================================================================
  Global Variables.
 */
#ifdef SECURITY_DEVICE
mss_uart_instance_t * gp_my_uart = &g_mss_uart1;
#else
mss_uart_instance_t * gp_my_uart = &g_mss_uart0;
#endif

void UART_init()
{
	//MSS_UART_init(gp_my_uart, MSS_UART_57600_BAUD, MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);
	MSS_UART_init(gp_my_uart, MSS_UART_115200_BAUD, MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);
}

void UART_connect()
{
	// Not using session key for now
	UART_usingKey = FALSE;
}

BOOL UART_recTime()
{
	uint8_t data[64];

	/*** SETUP CONNECTION ***/
	MSS_RTC_start();

	int ret = 0;
	if((ret = UART_receive(&data[0], 64)) <= 0)
	{
		__printf("\nError: not Connected.");
		return FALSE;
	}

	if(data[0] != 'T' || data[1] != 'I' || data[2] != 'M' || data[3] != 'E' || data[4] != '_' || data[5] != 'S' || data[6] != 'E' || data[7] != 'N' || data[8] != 'D')
	{
		__printf("\nError: not Connected.");
		return FALSE;
	}

	COMMAND_process(data); // Process TIME_SEND

	return TRUE;
}

void UART_disconnect()
{
	memset(UART_sessionKey, 0, 32);
	UART_usingKey = FALSE;
}

void UART_setKey(uint8_t * key)
{
	memcpy(UART_sessionKey, key, 32);
	UART_usingKey = TRUE;
}

uint8_t UART_get
(
	uint8_t* location,
	uint8_t size
)
{
    uint8_t count = 0u;

    /* Clear the memory location. */
    UART_clear_variable(location, size);

#ifdef DEBUG_MODE
    /* Read the 16 bytes of input data from UART terminal. */
    //count = UART_getDataUART(location, size);

    /* Convert ASCII key to Hex format */
    //UART_convert_ascii_to_hex(location, size);

    UART_Polled_Rx(gp_my_uart, location, size);
#else
    UART_Polled_Rx(gp_my_uart, location, size);
#endif

    // Reply back the contents
    //__printf(location);

    return count;
}

int UART_send(uint8_t *buffer, uint32_t len)
{
	// Encapsulate data
	uint8_t * data = malloc(sizeof(uint8_t)*(len+4)); // timestamp goes in the last 4B
	if(data == NULL)
		return ERROR_UART_MEMORY;

	memcpy(data, buffer, len);

	// Get timestamp
	mss_rtc_calendar_t calendar_count;
	MSS_RTC_get_calendar_count(&calendar_count);

	uint32_t t = convertDateToUnixTime(&calendar_count);

	// Place the size into an array
	data[len] = t & 0x000000FF;
	data[len+1] = (t & 0x0000FF00) >> 8;
	data[len+2] = (t & 0x00FF0000) >> 16;
	data[len+3] = (t & 0xFF000000) >> 24;

	int r = UART_send_e(data, len+4);
	free(data);

	if(r > 0)
		r -= 4;

	return r;
}

int UART_send_e(uint8_t *buffer, uint32_t len)
{
	// > ~4GB? fail (4*1024^3)
	if (len > 4294967295)
	{
		__printf("\nError: can't send data bigger than 4GiB.");
		return ERROR_UART_INVALID_SIZE;
	}

	int ret = 0;

	mbedtls_aes_context aes_ctx;
	mbedtls_md_context_t sha_ctx;
	uint8_t IV[16] = {0x72, 0x88, 0xd4, 0x11, 0x94, 0xea, 0xf7, 0x1c, 0x31, 0xac, 0xc3, 0x8c, 0xc7, 0xdc, 0x82, 0x4b};
	uint8_t HMAC[32] = {0};
	unsigned char data[BLOCK_SIZE];

	uint32_t plainBytesSent = 0;

	if(UART_usingKey)
	{
		mbedtls_aes_init(&aes_ctx);
		mbedtls_md_init(&sha_ctx);

		// Set AES key
		mbedtls_aes_setkey_enc(&aes_ctx, UART_sessionKey, 256);

		// Generate IV
		#ifdef SECURITY_DEVICE
			// Generate 128-bit IV
			/* Generate random bits */
			uint8_t status = MSS_SYS_nrbg_generate(&IV[0],    // p_requested_data
				0,              // p_additional_input
				16,				// requested_length
				0,              // additional_input_length
				0,              // pr_req
				drbg_handle);   // drbg_handle
			if(status != MSS_SYS_SUCCESS)
			{
				return ERROR_UART_IV_GENERATE; // error
			}
		#endif

		// Send IV
		MSS_UART_polled_tx(gp_my_uart, (const uint8_t * )IV, BLOCK_SIZE);
		// Wait for OK
		UART_waitOK();

		// Setup HMAC
		ret = mbedtls_md_setup(&sha_ctx, mbedtls_md_info_from_type(MBEDTLS_MD_SHA256), 1);
		if(ret != 0)
		{
			mbedtls_aes_free( &aes_ctx );

			char error[10];
			sprintf(error, "E: %d", ret);
			__printf(error);
			return ERROR_UART_HMAC_SETUP;
		}

		mbedtls_md_hmac_starts(&sha_ctx, UART_sessionKey, 32);
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
	if (UART_usingKey)
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
	memcpy(dataInfo+4, total_blocks, 4);
	MSS_UART_polled_tx(gp_my_uart, (const uint8_t * )dataInfo, 8);
	// Wait for OK
	UART_waitOK();

	// Add dataInfo to HMAC
	if(UART_usingKey)
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

		if(UART_usingKey)
		{
			// Encrypt block
			memset(ciphertext, 0, sizeof(data));
			mbedtls_aes_crypt_cbc(&aes_ctx, MBEDTLS_AES_ENCRYPT, BLOCK_SIZE, IV, data, &ciphertext[0]);

			// Update HMAC
			mbedtls_md_hmac_update(&sha_ctx, ciphertext, BLOCK_SIZE);

			// Copy ciphertext to data
			memcpy(data, ciphertext, BLOCK_SIZE);
		}

		plainBytesSent += BLOCK_SIZE;
		bytes += BLOCK_SIZE;
		MSS_UART_polled_tx(gp_my_uart, (const uint8_t * )data, BLOCK_SIZE);
		// Wait for OK
		UART_waitOK();
	}

	// Anything left to send? (last block may not be 16B)
	if (bytes < len)
	{
		uint32_t remaining = len - bytes;
		if (remaining > BLOCK_SIZE)
		{
			if(UART_usingKey)
			{
				mbedtls_aes_free( &aes_ctx );
				mbedtls_md_free( &sha_ctx );
			}

			__printf("\nError: remaining amount bigger than block size.");
			return ERROR_UART_BLOCK_SIZE_INVALID;
		}

		memset(data, 0, sizeof(data));
		memcpy(data, buffer + chunk * BLOCK_SIZE, remaining);

		plainBytesSent += remaining;

		if(UART_usingKey)
		{
			// Apply PKCS#7 padding
			// Set the padded bytes to the padded length value
			// TODO: (maybe) Send another block with all bytes set to the padded length value
			// (instead of sending the size of the plaintext before)
			add_pkcs_padding(data, BLOCK_SIZE, remaining);
			remaining = BLOCK_SIZE;

			// Encrypt block
			memset(ciphertext, 0, sizeof(ciphertext));
			mbedtls_aes_crypt_cbc(&aes_ctx, MBEDTLS_AES_ENCRYPT, BLOCK_SIZE, IV, data, &ciphertext[0]);

			// Update HMAC
			mbedtls_md_hmac_update(&sha_ctx, ciphertext, BLOCK_SIZE);

			// Copy ciphertext to data
			memcpy(data, ciphertext, BLOCK_SIZE);
		}

		bytes += remaining;
		MSS_UART_polled_tx(gp_my_uart, (const uint8_t * )data, remaining);
		// Wait for OK
		UART_waitOK();
	}

	// Send HMAC
	if(UART_usingKey)
	{
		// Finally write the HMAC.
		mbedtls_md_hmac_finish(&sha_ctx, HMAC);

		// Send two blocks of 16B
		MSS_UART_polled_tx(gp_my_uart, (const uint8_t * )HMAC, BLOCK_SIZE);
		// Wait for OK
		UART_waitOK();
		MSS_UART_polled_tx(gp_my_uart, (const uint8_t * )HMAC+BLOCK_SIZE, BLOCK_SIZE);
		// Wait for OK
		UART_waitOK();

		mbedtls_aes_free( &aes_ctx );
		mbedtls_md_free( &sha_ctx );
	}

	return plainBytesSent;
}

int UART_receive(char *location, uint32_t locsize)
{
	// Decapsulate data
	uint8_t * data = malloc(sizeof(uint8_t)*(locsize+BLOCK_SIZE)); // timestamp goes in the last 4B but since we may need 16B for encryption, let's add 16B
	if(data == NULL)
		return ERROR_UART_MEMORY;
	memcpy(data, location, locsize);

	// Get timestamp
	mss_rtc_calendar_t calendar_count;
	MSS_RTC_get_calendar_count(&calendar_count);

	// Get our timestamp
	uint32_t t = convertDateToUnixTime(&calendar_count);

	int r = UART_receive_e(data, locsize+BLOCK_SIZE);
	if(r <= 0)
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
	if((system_status & STATUS_CONNECTED))
	{
		if(abs(rec_timestamp-t) > 10)
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

int UART_receive_e(char *location, uint32_t locsize)
{
	mbedtls_aes_context aes_ctx;
	mbedtls_md_context_t sha_ctx;
	uint8_t HMAC[32] = { 0 };
	uint8_t IV[16];

	uint32_t plainBytesReceived = 0;

	if(UART_usingKey)
	{
		mbedtls_aes_init(&aes_ctx);
		mbedtls_md_init(&sha_ctx);

		// Set AES key
		mbedtls_aes_setkey_dec(&aes_ctx, UART_sessionKey, 256);

		// Expect IV (16B)
		UART_get(&IV[0], 16u);
		UART_sendOK();

		// Setup HMAC
		int ret = mbedtls_md_setup(&sha_ctx, mbedtls_md_info_from_type(MBEDTLS_MD_SHA256), 1);
		if (ret != 0)
		{
			mbedtls_aes_free( &aes_ctx );

			char error[10];
			sprintf(error, "E: %d", ret);
			__printf(error);
			return ERROR_UART_HMAC_SETUP;
		}

		mbedtls_md_hmac_starts(&sha_ctx, UART_sessionKey, 32);
		mbedtls_md_hmac_update(&sha_ctx, IV, BLOCK_SIZE);
	}

	// Expect data size (bytes) first
	// We are supposed to receive 4B
	// Size is split among 4B (up to ~4GB (4*1024^3))
	uint8_t dataArray[8];
	UART_get(&dataArray[0], 8u);
	// Send OK
	UART_sendOK();

	// Add dataInfo to HMAC
	if (UART_usingKey)
	{
		mbedtls_md_hmac_update(&sha_ctx, dataArray, 8);
	}

	// Put back the size together into a 32 bit integer
	uint32_t size = (0x000000FF & dataArray[0]) | ((0x000000FF & dataArray[1]) << 8) | ((0x000000FF & dataArray[2]) << 16) | ((0x000000FF & dataArray[3]) << 24);
	uint32_t blocks = (0x000000FF & dataArray[4]) | ((0x000000FF & dataArray[5]) << 8) | ((0x000000FF & dataArray[6]) << 16) | ((0x000000FF & dataArray[7]) << 24);

	// Now get the actual command
	memset(location, 0, locsize);

	// Truncate data size
	if(size > locsize)
		size = locsize;

	if (UART_usingKey)
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
		return ERROR_UART_CHUNKS_MISMATCH;
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
		UART_get(data, BLOCK_SIZE);

		if(UART_usingKey)
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
			if(plainBytesReceived + BLOCK_SIZE > size)
			{
				// Remove padding from message
				size_t l = 0;
				int r = get_pkcs_padding(plaintext, BLOCK_SIZE, &l);
				if(r == 0)
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
		UART_sendOK();
	}

	if(UART_usingKey)
	{
		// Finally write the HMAC.
		mbedtls_md_hmac_finish(&sha_ctx, HMAC);

		// The last two 16B blocks make up the HMAC
		// HMAC(IV || dataInfo || C)
		// Compare HMACs
		uint8_t recHMAC[32];
		UART_get(&recHMAC[0], 16u);
		// Send OK
		UART_sendOK();
		UART_get(&recHMAC[16], 16u);
		// Send OK
		UART_sendOK();

		// Compare HMACs
		unsigned char diff = 0;
		for (int i = 0; i < 32; i++)
			diff |= HMAC[i] ^ recHMAC[i]; // XOR = 1 if one is different from the other

		if (diff != 0)
		{
			mbedtls_aes_free( &aes_ctx );
			mbedtls_md_free( &sha_ctx );

			__printf("\nError: HMAC differs");
			return ERROR_UART_HMAC_MISMATCH;
		}

		mbedtls_aes_free( &aes_ctx );
		mbedtls_md_free( &sha_ctx );
	}
	else
	{
		// Anything left to receive? (last block may not be 16B)
		// Only happens when not in a secure communication (otherwise the last block is padded so it matches 16B)
		if (bytes < size)
		{
			uint32_t remaining = size - bytes;
			if (remaining > BLOCK_SIZE)
			{
				__printf("\nError: remaining amount bigger than block size.");
				return ERROR_UART_BLOCK_SIZE_INVALID;
			}
			memset(data, 0, sizeof(data));

			// Read remaining data
			UART_get(data, remaining);

			memcpy(location + chunk * BLOCK_SIZE, data, remaining);

			plainBytesReceived += remaining;

			bytes += remaining;

			// Send OK
			UART_sendOK();
		}
	}

	return plainBytesReceived;
}


BOOL UART_waitOK()
{
	uint16_t count = 0u;

	uint8_t ok[BLOCK_SIZE];
	memset(ok, 0, sizeof(ok));

	while(1)
	{
		//UART_receive(&ok[0], BLOCK_SIZE);
		UART_get(&ok[0], 2u);
		if(ok[0] != '0' || ok[1] != '1')
		{
			__printf("\nError: not OK.");
			return FALSE;
		}
		else
			break;
	}

	return TRUE;
}

BOOL UART_sendOK()
{
	MSS_UART_polled_tx(gp_my_uart, (const uint8_t * )"01", 2);
	/*uint8_t data[2] = {'0','1'};
	if(UART_send(data, 2) != 2)
	{
		return FALSE;
	}*/

	return TRUE;
}

void UART_waitCOMMAND()
{
	uint16_t count = 0u;

	uint8_t data[BLOCK_SIZE];
	memset(data, 0, sizeof(data));

	while(1)
	{
		count = UART_receive(&data[0], BLOCK_SIZE);

		// If not equal to COMMAND then we keep reading
		if(data[0] != 'C' || data[1] != 'O' || data[2] != 'M' || data[3] != 'M' || data[4] != 'A' || data[5] != 'N' || data[6] != 'D')
		{
			__printf("\nError: not OK.");
		}
		else
			break;
	}

	// Send OK
	UART_sendOK();
}


size_t UART_Polled_Rx
(
    mss_uart_instance_t * this_uart,
    uint8_t * rx_buff,
    size_t buff_size
)
{
    size_t rx_size = 0U;

    while( rx_size < buff_size )
    {
       while ( ((this_uart->hw_reg->LSR) & 0x1) != 0U  )
       {
           rx_buff[rx_size] = this_uart->hw_reg->RBR;
           ++rx_size;
       }
    }

    return rx_size;
}

void UART_clear_variable(uint8_t *p_var, uint16_t size)
{
	uint16_t inc;

	for (inc = 0; inc < size; inc++)
	{
		*p_var = 0x00;
		p_var++;
	}
}

uint8_t UART_getDataUART
(
	uint8_t* src_ptr,
	uint8_t size
)
{
    uint8_t complete = 0u;
    uint8_t rx_buff[1];
    uint8_t rx_size = 0u;
    uint8_t count = 0u;

    /* Read the key size sent by user and store it. */
    count = 0u;
    while(!complete)
    {
        rx_size = MSS_UART_get_rx (gp_my_uart, rx_buff, sizeof(rx_buff));
        if(rx_size > 0u)
        {
            /* Is it to terminate from the loop */
            if(ENTER == rx_buff[0])
            {
                complete = 1u;
            }
            /* Is entered key valid */
            else if(UART_validate_input(rx_buff[0]) != 1u)
            {
                MSS_UART_polled_tx(gp_my_uart, rx_buff, sizeof(rx_buff));
                MSS_UART_polled_tx_string(gp_my_uart, (uint8_t *)"\r\n Invalid input.");
                complete = 0u;
                count = 0u;
                UART_clear_variable(src_ptr, 4);
            }
            else
            {
                src_ptr[count] = rx_buff[0];

                /* Switching to next line after every 8 bytes */
                if(((count % 16u) == 0x00u) && (count > 0x00u) && (complete != 0x01u))
                {
                	MSS_UART_polled_tx_string(gp_my_uart, (uint8_t *)"\n\r");
                }

                if((count % 2u) == 0u)
                {
                	MSS_UART_polled_tx_string(gp_my_uart, (uint8_t *)" 0x");
                }
                MSS_UART_polled_tx_string(gp_my_uart, (uint8_t *)rx_buff);

                count++;
                if(size == count)
                {
                   complete = 1u;
                }
            }
        }
    }

    return count;
}

uint8_t UART_convert_ascii_to_hex(uint8_t* arr, uint32_t length)
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
			__printf("\r\n Invalid data.");
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
 
uint8_t UART_validate_input(uint8_t ascii_input)
{
    uint8_t valid_key = 0u;

    if(((ascii_input >= 'A') && (ascii_input <= 'F')) ||       \
       ((ascii_input >= 'a') && (ascii_input <= 'f')) ||       \
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
