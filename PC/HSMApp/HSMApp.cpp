// HSMApp.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <windows.h>
#include <stdint.h>
#include "UART.h"
#include "mbedtls/config.h"

#if defined(MBEDTLS_PLATFORM_C)
#include "mbedtls/platform.h"
#else
#include <stdio.h>
#define mbedtls_printf     printf
#endif

#define VERBOSE 0

#if !defined(MBEDTLS_ECDH_C) || \
    !defined(MBEDTLS_ECP_DP_CURVE25519_ENABLED) || \
    !defined(MBEDTLS_ENTROPY_C) || !defined(MBEDTLS_CTR_DRBG_C)
int main(void)
{
	mbedtls_printf("MBEDTLS_ECDH_C and/or "
		"MBEDTLS_ECP_DP_CURVE25519_ENABLED and/or "
		"MBEDTLS_ENTROPY_C and/or MBEDTLS_CTR_DRBG_C "
		"not defined\n");
	return(0);
}
#else

#include "mbedtls/entropy.h"
#include "mbedtls/ctr_drbg.h"
#include "mbedtls/ecdh.h"
#include "mbedtls/aes.h"
#include "mbedtls/sha256.h"
#include "mbedtls/md.h"

#include <string.h>

/*==============================================================================
Macro
*/
#define   VALID                   0U
#define   INVALID                 1U
#define   AES_KEY_REGEN_CNT       10u
#define   KEY_LENGTH_128          32u
#define   KEY_LENGTH_256          64u
#define   KEY_HMAC                6u
#define   INIT_VECTOR_VALUE       8u
#define   AES_DECRYPT             1u
#define   AES_ENCRYPT             2u
#define   ENTER                   13u
#define   DUMMY_DATA              0u
#define   ASCII_32_CHARACTERS     32u
#define   ASCII_64_CHARACTERS     (ASCII_32_CHARACTERS * 2)
#define   ASCII_128_CHARACTERS    (ASCII_32_CHARACTERS * 4)
#define   DATA_LENGTH_128_BITS    ASCII_32_CHARACTERS
#define   DATA_LENGTH_256_BITS    ASCII_64_CHARACTERS
#define   DATA_LENGTH_512_BITS    ASCII_128_CHARACTERS
#define   DATA_LENGTH_16_BYTES    (ASCII_32_CHARACTERS / 2)
#define   DATA_LENGTH_32_BYTES    (ASCII_64_CHARACTERS / 2)
#define   DATA_LENGTH_64_BYTES    (ASCII_128_CHARACTERS / 2)
#define   BUFSIZE         1024

const uint8_t g_separator[] =
"------------------------------------------------------------------------------\r\n";

uint8_t buffer[4096];
uint32_t len;

UART * comm;

void NEW_USER();
void EXPORT_USERS();
void TIME_SEND();
void GEN_KEYS();
void DATA_SIGN();
void DATA_VERIFY();

int main()
{
	printf("%s", g_separator);
	printf("\t\tHSM Application\r\n");
	printf("\tPress ENTER to initiate communication.\r\n");
	printf("%s", g_separator);

	getchar();

	// Initiate UART communication
	comm = new UART();
	comm->connect();

	// Send command request
	comm->reqCommand();

	TIME_SEND();

	/*comm->reqCommand();

	NEW_USER();*/

	comm->reqCommand();

	DATA_SIGN();

	// 'buffer' contains the signature (25B length as of time of writing)
	// Run DATA_VERIFY
	comm->reqCommand();

	DATA_VERIFY();

	/*comm->reqCommand();

	GEN_KEYS();*/

	printf("\nPress ENTER to continue.\n");

	getchar();

    return 0;
}

// Send new user request
void TIME_SEND()
{
	printf("Sending SEND_TIME command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "TIME_SEND");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	// Now it expects a timestamp
	printf("Sending DATA...");
	memset(buffer, 0, sizeof(buffer));
	uint32_t t = time(NULL);

	// Place the size into an array
	unsigned char timestamp[4];
	timestamp[0] = t & 0x000000FF;
	timestamp[1] = (t & 0x0000FF00) >> 8;
	timestamp[2] = (t & 0x00FF0000) >> 16;
	timestamp[3] = (t & 0xFF000000) >> 24;
	comm->send(timestamp, 4);
	printf("OK\n");
}

// Send new user request
void NEW_USER()
{
	printf("Sending USER_NEW command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "USER_NEW");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	// Now it expects:
	// ADMIN_PIN | USER_PIN
	printf("Sending DATA...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "12345678912345678912345678912345");
	sprintf_s((char*)buffer, sizeof(buffer), "%s12345678912345678912345678912341", buffer);
	comm->send(buffer, strlen((char*)buffer));
	printf("OK\n");

	// Wait for 'SUCCESS_ID'
	printf("Receiving SUCCESS_ID...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	printf("OK: %s\n", buffer);

	// Wait for ID (1B)
	printf("Receiving ID...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	printf("OK: %d\n", buffer[0]);
}

// works for len < 256
uint8_t get_len(uint8_t * buffer)
{
	uint8_t i = 0;
	while (1)
	{
		if (buffer[i] == 0)
			break;

		i++;
	}

	return i;
}

// Send new user request
void GEN_KEYS()
{
	printf("Sending USER_GENKEYS command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "USER_GENKEYS");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	// Now it expects:
	// ADMIN_PIN | USER_ID
	printf("Sending DATA...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "12345678912345678912345678912345");
	sprintf_s((char*)buffer, sizeof(buffer), "%s", buffer);
	int l = strlen((char*)buffer)+1;
	buffer[strlen((char*)buffer)] = 1; // ID
	comm->send(buffer, l);
	printf("OK\n");

	// Wait for 'SUCCESS_CERT'
	printf("Receiving CERTIFICATE...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	printf("OK: %s\n", buffer);
}

// Send hash to be signed
void DATA_SIGN()
{
	// Calculate SHA-256 of "123456"
	uint8_t msg[6] = { '1','2','3','4','5','6'};
	unsigned char digest[32] = { 0 };
	mbedtls_sha256(msg, 6, digest, 0);

	printf("Sending DTSN_SIGN command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "DTSN_SIGN");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	// Now it expects:
	// USER_PIN | USER_ID | 32B_HASH
	printf("Sending DATA...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "12345678912345678912345678912341"); // user pin
	buffer[32] = 1; // ID
	memcpy(&buffer[33], digest, 32);
	comm->send(buffer, 32+1+32);
	printf("OK\n");

	// Wait for 'SIGNATURE'
	printf("Receiving SIGNATURE...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	printf("OK: %s\n", buffer);

	// Wait for actual signature
	printf("Receiving actual signature...");
	memset(buffer, 0, sizeof(buffer));
	len = comm->receive(&buffer[0], 4096);
	printf("OK: %s\n", buffer);
}

// Send hash along with signature to be verified
// must be executed after DATA_SIGN because buffer must contain the signature
void DATA_VERIFY()
{
	// 'buffer' should contain the signature
	uint8_t signature[100] = { 0 };
	uint8_t sig_len = len;
	memcpy(signature, buffer, sig_len);

	// Calculate SHA-256 of "123456"
	uint8_t msg[6] = { '1','2','3','4','5','6' };
	unsigned char digest[32] = { 0 };
	mbedtls_sha256(msg, 6, digest, 0);

	printf("Sending DTSN_VERIFY command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "DTSN_VERIFY");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	// Now it expects:
	// USER_PIN | USER_ID | 32B_HASH | 1B SIGNATURE SIZE
	printf("Sending DATA...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "12345678912345678912345678912341"); // user pin
	buffer[32] = 1; // ID
	memcpy(&buffer[33], digest, 32);
	buffer[65] = sig_len;
	comm->send(buffer, 32 + 1 + 32 + 1);
	printf("OK\n");

	// Send signature
	printf("Sending SIGNATURE...");
	memset(buffer, 0, sizeof(buffer));
	memcpy(&buffer[0], signature, sig_len);
	comm->send(buffer, sig_len);
	printf("OK\n");
	

	// Wait for response
	printf("Receiving response...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	printf("OK: %s\n", buffer);
}

void EXPORT_USERS()
{
	printf("Sending USER_EXPORT command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "USER_EXPORT");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	// Expect data back
	printf("Receiving data...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 10000);
	printf("OK.\n");
}


#endif