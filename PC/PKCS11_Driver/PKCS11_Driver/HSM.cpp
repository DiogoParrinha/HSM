#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <stdbool.h>
#include <stdint.h>
#include <algorithm>

#include <windows.h>
#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>

#include <dirent.h>
#include <direct.h>
#include "mbedtls/config.h"

#if defined(MBEDTLS_PLATFORM_C)
#include "mbedtls/platform.h"
#else
#include <stdio.h>
#define mbedtls_printf     printf
#endif

#include "mbedtls/entropy.h"
#include "mbedtls/ctr_drbg.h"
#include "mbedtls/ecdh.h"
#include "mbedtls/aes.h"
#include "mbedtls/sha256.h"
#include "mbedtls/md.h"
#include "mbedtls/pk.h"
#include "mbedtls/x509_crt.h"
#include "mbedtls/md5.h"
#include "mbedtls/base64.h"
#include "mbedtls/pkcs5.h"

#include "HSM.h"
#include "UART.h"

#include <fstream>
#include <ctime>
#include <locale>
#include <iomanip>

#define VERBOSE 1

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

#define HSM_SERIAL_NUMBER "123456789"
#define HSM_MAX_SESSIONS 1 // per slot

uint8_t buffer[4096];

mbedtls_x509_crt *logs_cert;

int STS_requestTime(uint8_t nonce[64], uint8_t * response); // receive 512-bit nonce
uint32_t STS_getTime();

HSM::HSM()
{
	comm = new UART();

	srand((unsigned int)time(NULL));

	loggedIn = false;
	isAdmin = false;
	
	maxSessions = HSM_MAX_SESSIONS;
	openSessions = 0;
	connected = false;

	memset(serialNumber, 0, 128);
	memcpy(serialNumber, HSM_SERIAL_NUMBER, strlen(HSM_SERIAL_NUMBER));

	logs_cert = NULL;
	delayed = true;
}

HSM::~HSM()
{
	if(logs_cert != NULL)
		free(logs_cert);

	comm->disconnect();
}

bool HSM::sendData(CK_BYTE_PTR pData, CK_ULONG ulDataLen)
{
	comm->reqCommand();

	// Exec command 
	if (!execCmd("DVC_TEST"))
		return false;

	// Now it expects:
	// 32B_HASH
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	int r = comm->send(pData, ulDataLen);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}
	if (VERBOSE == 1)
		printf("OK\n");

	if (!processResult())
		return false;

	return true;
}

void HSM::randomArray(CK_BYTE_PTR pData, CK_ULONG ulDataLen)
{
	if (pData == NULL)
		return;

	for (uint32_t i = 0; i < ulDataLen; i++)
	{
		pData[i] = rand();
	}
}

bool HSM::init()
{
	if(VERBOSE == 1)
		printf("Linking...");
	// Initialize comm
	if (!comm->init())
	{
		return CK_FALSE;
	}
	if (VERBOSE == 1)
		printf("OK.\n");

	// Get info
	if (!checkDevice())
	{
		return CK_FALSE;
	}

	strcpy_bp(token.tokenInfo.manufacturerID, "INESC-ID", sizeof(token.tokenInfo.manufacturerID));
	strcpy_bp(token.tokenInfo.model, "PKCS#11", sizeof(token.tokenInfo.model));
	strcpy_bp(token.tokenInfo.label, "HSM", sizeof(token.tokenInfo.label));
	strcpy_bp(token.tokenInfo.serialNumber, HSM_SERIAL_NUMBER, sizeof(token.tokenInfo.serialNumber));
	token.tokenInfo.flags = 0;
	token.tokenInfo.flags |= CKF_RNG;
	token.tokenInfo.flags |= CKF_LOGIN_REQUIRED;
	token.tokenInfo.flags |= CKF_CLOCK_ON_TOKEN;
	token.tokenInfo.ulMaxSessionCount = maxSessions;
	token.tokenInfo.ulSessionCount = 0;
	token.tokenInfo.ulMaxRwSessionCount = maxSessions;
	token.tokenInfo.ulRwSessionCount = 0;
	token.tokenInfo.ulMaxPinLen = 32;
	token.tokenInfo.ulMinPinLen = 32;
	token.tokenInfo.ulTotalPublicMemory = 0; // N/A
	token.tokenInfo.ulTotalPrivateMemory = 0; // N/A
	token.tokenInfo.ulFreePublicMemory = 0; // N/A
	token.tokenInfo.ulFreePrivateMemory = 0; // N/A
	token.tokenInfo.hardwareVersion.major = 1;
	token.tokenInfo.hardwareVersion.minor = 0;
	token.tokenInfo.firmwareVersion.major = 1;
	token.tokenInfo.firmwareVersion.minor = 0;
	strcpy_bp(token.tokenInfo.utcTime, "", sizeof(token.tokenInfo.utcTime));

	connected = true;

	return true;
}

uint8_t HSM::getTotalServices()
{
	/*
		The HSM supports the following services:
		1) Generate key pair (Admin PIN)
		2) Generate certificates (Admin PIN)
		3) Manage users (Admin PIN)
		4) Digital Signatures (User PIN)
		5) Log Management (Log PIN)
		6) Get Certificates
	*/

	return 6;
}

bool HSM::isConnected()
{
	return connected;
}

void HSM::addSlot(p11_slot * s, int i)
{
	// Create slot information
	s->slotInfo.firmwareVersion.major = 1;
	s->slotInfo.firmwareVersion.minor = 0;
	s->slotInfo.flags |= CKF_REMOVABLE_DEVICE;
	s->slotInfo.flags |= CKF_HW_SLOT;
	s->slotInfo.hardwareVersion.major = 1;
	s->slotInfo.hardwareVersion.minor = 0;
	strcpy_bp(s->slotInfo.manufacturerID, "INESC-ID", sizeof(s->slotInfo.manufacturerID));
	strcpy_bp(s->slotInfo.slotDescription, "Empty USB COM Slot", sizeof(s->slotInfo.slotDescription));
	
	// Check if we have a token
	if (isConnected())
	{
		// Associate token
		s->token = &token;
		s->slotInfo.flags |= CKF_TOKEN_PRESENT;

		strcpy_bp(s->slotInfo.slotDescription, "INESC-ID HSM USB COM Slot", sizeof(s->slotInfo.slotDescription));
	}
}

int HSM::startSession()
{
	// How many open sessions? If >= than HSM_MAX_SESSIONS return 1
	if (sessionLimit())
		return 1;

	// Exec command 
	if (!execCmd("SESS_START"))
		return false;

	if (SECURE_SESSION == 1)
	{
		// Initiate secure comm
		int ret;
		mbedtls_ecdh_context ctx_cli;
		mbedtls_entropy_context entropy;
		mbedtls_ctr_drbg_context ctr_drbg;
		unsigned char cli_pub_x[48], cli_pub_y[48];
		const char pers[] = "ecdh";

		mbedtls_ecdh_init(&ctx_cli);
		mbedtls_ctr_drbg_init(&ctr_drbg);

		//Initialize random number generation
		mbedtls_entropy_init(&entropy);
		if ((ret = mbedtls_ctr_drbg_seed(&ctr_drbg, mbedtls_entropy_func, &entropy,
			(const unsigned char *)pers,
			sizeof pers)) != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);

			if (VERBOSE == 1)
				printf(" failed\n  ! mbedtls_ctr_drbg_seed returned %d\n", ret);
			return 2;
		}

		//Client: inialize context and generate keypair
		ret = mbedtls_ecp_group_load(&ctx_cli.grp, MBEDTLS_ECP_DP_SECP384R1);
		//ret = mbedtls_ecp_group_load(&ctx_cli.grp, MBEDTLS_ECP_DP_SECP192R1);
		if (ret != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);

			if (VERBOSE == 1)
				printf(" failed\n  ! mbedtls_ecp_group_load returned %d\n", ret);
			return 3;
		}

		ret = mbedtls_ecdh_gen_public(&ctx_cli.grp, &ctx_cli.d, &ctx_cli.Q, mbedtls_ctr_drbg_random, &ctr_drbg);
		if (ret != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);

			if (VERBOSE == 1)
				printf(" failed\n  ! mbedtls_ecdh_gen_public returned %d\n", ret);
			return 4;
		}

		ret = mbedtls_mpi_write_binary(&ctx_cli.Q.X, cli_pub_x, 48);
		if (ret != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);

			if (VERBOSE == 1)
				printf(" failed\n  ! mbedtls_mpi_write_binary returned %d\n", ret);
			return 5;
		}

		ret = mbedtls_mpi_write_binary(&ctx_cli.Q.Y, cli_pub_y, 48);
		if (ret != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);

			if (VERBOSE == 1)
				printf(" failed\n  ! mbedtls_mpi_write_binary returned %d\n", ret);
			return 6;
		}

		///////// Read public key certificate file ./certs/session.crt
		mbedtls_x509_crt *session_cert = (mbedtls_x509_crt*)malloc(sizeof(mbedtls_x509_crt));
		if (session_cert == NULL)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);

			if (VERBOSE == 1)
				printf("Not enough memory for session.cert\n");
			return 7;
		}

		mbedtls_x509_crt_init(session_cert);
		mbedtls_pk_init(&session_cert->pk);

		ret = mbedtls_x509_crt_parse_file(session_cert, "././certs/session.crt");
		if (ret != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);
			mbedtls_x509_crt_free(session_cert);

			// certificate is missing, can't validate chain
			if (VERBOSE == 1)
				printf("Error parsing public key certificate.\n");

			return 8;
		}

		mbedtls_ecp_keypair * temp_pair = mbedtls_pk_ec(session_cert->pk);
		mbedtls_ecp_point oldQ = ctx_cli.Qp;
		ctx_cli.Qp = temp_pair->Q;

		// Client: read peer's key and generate shared secret
		ret = mbedtls_mpi_lset(&ctx_cli.Qp.Z, 1);
		if (ret != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);
			mbedtls_x509_crt_free(session_cert);

			if (VERBOSE == 1)
				printf(" failed\n  ! mbedtls_mpi_lset returned %d\n", ret);
			return 9;
		}

		size_t len = 0;
		unsigned char shared_secret[128] = { 0 };

		if ((ret = mbedtls_ecdh_calc_secret(&ctx_cli,
			&len,
			shared_secret,
			128,
			mbedtls_ctr_drbg_random, &ctr_drbg)) != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);
			mbedtls_x509_crt_free(session_cert);

			if (VERBOSE == 1)
				printf(" failed\n  ! mbedtls_ecdh_calc_secret returned %d\n", ret);
			return 10;
		}

		mbedtls_x509_crt_free(session_cert);
		ctx_cli.Qp = oldQ;

		/////// PKCS#5 Key derivation to obtain sessionKey and HMAC Key

		// Generate random 16B IV/Salt
		uint8_t salt_IV[16] = { 0 };
		randomArray(salt_IV, 16);

		const mbedtls_md_info_t *md_info;
		mbedtls_md_type_t md_type = MBEDTLS_MD_SHA256;
		mbedtls_md_context_t md_ctx;
		mbedtls_md_init(&md_ctx);
		uint8_t expandedKey[64] = { 0 };

		md_info = mbedtls_md_info_from_type(md_type);
		if (md_info == NULL)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);
			mbedtls_md_free(&md_ctx);

			return 11;
		}

		if ((ret = mbedtls_md_setup(&md_ctx, md_info, 1)) != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);
			mbedtls_md_free(&md_ctx);

			return 12;
		}

		ret = mbedtls_pkcs5_pbkdf2_hmac(&md_ctx, shared_secret, len, salt_IV, 16, 1, 64, expandedKey);
		if (ret != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);
			mbedtls_md_free(&md_ctx);

			return 13;
		}
		mbedtls_md_free(&md_ctx);

		uint8_t UART_sessionKey[32] = { 0 }, UART_hmacKey[32] = { 0 };
		memcpy(&UART_sessionKey[0], expandedKey, 32);
		memcpy(&UART_hmacKey[0], &expandedKey[32], 32);

		/////// Time to send CIPHERTEXT | IV | PUBLIC_KEY/cli_pub_x,cli_pub_y | HMAC(C|IV|P)

		mbedtls_md_context_t sha_ctx;
		uint8_t HMAC[32] = { 0 };
		mbedtls_md_init(&sha_ctx);

		ret = mbedtls_md_setup(&sha_ctx, mbedtls_md_info_from_type(MBEDTLS_MD_SHA256), 1);
		if (ret != 0)
		{
			mbedtls_ecdh_free(&ctx_cli);
			mbedtls_ctr_drbg_free(&ctr_drbg);
			mbedtls_entropy_free(&entropy);
			mbedtls_md_free(&sha_ctx);

			return 14;
		}

		mbedtls_md_hmac_starts(&sha_ctx, UART_hmacKey, 32);

		// Generate nonce (256-bit)
		uint8_t nonce1[32] = { 0 };
		randomArray(nonce1, 32);

		// Encrypt nonce
		mbedtls_aes_context aes_ctx;
		mbedtls_aes_init(&aes_ctx);
		mbedtls_aes_setkey_enc(&aes_ctx, UART_sessionKey, 256);
		uint8_t ciphertext[32];
		memset(ciphertext, 0, 32);
		uint8_t IV_copy[16] = { 0 };
		memcpy(IV_copy, salt_IV, 16);
		mbedtls_aes_crypt_cbc(&aes_ctx, MBEDTLS_AES_ENCRYPT, 32, IV_copy, nonce1, &ciphertext[0]);
		mbedtls_aes_free(&aes_ctx);

		// Compute HMAC of C|IV|P
		mbedtls_md_hmac_update(&sha_ctx, ciphertext, 32); // ciphertext
		mbedtls_md_hmac_update(&sha_ctx, salt_IV, 16); // salt / IV
		mbedtls_md_hmac_update(&sha_ctx, cli_pub_x, 48); // public key X
		mbedtls_md_hmac_update(&sha_ctx, cli_pub_y, 48); // public key Y
		mbedtls_md_hmac_finish(&sha_ctx, HMAC);
		mbedtls_md_free(&sha_ctx);

		// wait for "OK" to proceed only when the device chooses to
		comm->waitOK();

		// send ciphertext
		int r = comm->send(ciphertext, 32);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		// send IV
		r = comm->send(salt_IV, 16);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		// send 48B public key X
		r = comm->send(cli_pub_x, 48);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		// send 48B public key Y
		r = comm->send(cli_pub_y, 48);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		// send HMAC
		r = comm->send(HMAC, 32);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		mbedtls_aes_free(&aes_ctx);

		/////// Wait for modified nonce through secure session now

		// Set AES key
		comm->setKey(UART_sessionKey, UART_hmacKey, true);

		// Receive modified nonce N1'
		uint8_t rec_mod_nonce1[32] = { 0 };
		ret = comm->receive(rec_mod_nonce1, 32);
		if (ret <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", ret);
			return false;
		}

		// Receive nonce N2
		uint8_t rec_nonce2[32] = { 0 };
		ret = comm->receive(rec_nonce2, 32);
		if (ret <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", ret);
			return false;
		}

		uint8_t mod_nonce1[32];
		for (int a = 0; a < 32; a++)
		{
			mod_nonce1[a] = nonce1[a] % 6; // nonce1[a] mod 6 for now...
		}

		for (int a = 0; a < 32; a++)
		{
			if (rec_mod_nonce1[a] != mod_nonce1[a])
			{
				mbedtls_ecdh_free(&ctx_cli);
				mbedtls_ctr_drbg_free(&ctr_drbg);
				mbedtls_entropy_free(&entropy);

				if (VERBOSE == 1)
					printf("Received nonce does not match modified nonce.\n");
				return 15;
			}
		}

		///// Send modified nonce N2' encrypted with session key

		uint8_t mod_nonce2[32];
		for (int a = 0; a < 32; a++)
		{
			mod_nonce2[a] = rec_nonce2[a] % 16; // rec_nonce2[a] mod 16 for now...
		}

		r = comm->send(mod_nonce2, 32);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		mbedtls_ecdh_free(&ctx_cli);
		mbedtls_ctr_drbg_free(&ctr_drbg);
		mbedtls_entropy_free(&entropy);
	}

	///// Wait for SUCCESS
	if (!processResult())
	{
		if (VERBOSE == 1)
			printf("Not SUCCESS at sess start.\n");

		return 16;
	}
	
	// increase open sessions
	openSessions++;

	if (VERBOSE == 1)
		printf("OK.\n");
	
	return 0;
}

bool HSM::endSession()
{
	comm->reqCommand();

	// Exec command 
	if (!execCmd("SESS_END"))
		return false;

	uint8_t data[32] = { 0 };
	comm->setKey(data, data, false);

	openSessions--;

	return true;
}

bool HSM::sessionLimit()
{
	// How many open sessions? If >= than HSM_MAX_SESSIONS return true
	if (openSessions >= maxSessions)
		return true;

	return false;
}

bool HSM::sendTime()
{
	comm->reqCommand();

	// Exec command 
	if (!execCmd("TIME_SEND"))
		return false;

	// Expect 512-bit nonce
	uint8_t nonce[64] = { 0 };
	int r = comm->receive(nonce, 64);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	// Request timestamp + signature
	uint8_t result[512] = { 0 };
	int len = STS_requestTime(nonce, result);
	if (len < 0)
		return false;

	// Now it expects a timestamp
	if (VERBOSE == 1)
		printf("\n\t\tSending DATA...");
	r = comm->send(result, len);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}
	if (VERBOSE == 1)
		printf("OK.\n");

	if (!processResult())
		return false;

	if (VERBOSE == 1)
		printf("OK.\n");

	// TODO should be uncommented in production (i.e. when we want to really get real timestamps from TSA)
	if(CHECK_TIME_PACKETS)
		comm->useTime(true);

	return true;
}

bool HSM::checkDevice()
{
	// Exec command 
	if (!execCmd("DVC_CHECK"))
		return false;

	// Wait for 'SUCCESS'
	if (!processResult())
		return false;

	// Expect HSM_SERIAL_NUMBER
	uint8_t data[128] = { 0 };
	int r = comm->receive(&data[0], 128);
	if (r != strlen(HSM_SERIAL_NUMBER))
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	data[strlen(HSM_SERIAL_NUMBER)] = '\0';
	if (strcmp((char*)data, HSM_SERIAL_NUMBER) != 0)
	{
		if (VERBOSE == 1)
			printf("INVALID SERIAL NUMBER\n");
		return false;
	}

	if (VERBOSE == 1)
		printf("OK.\n");
	
	return true;
}

int HSM::initDevice(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen)
{
	if (ulPinLen != 32) // 32B for PIN
	{
		return 1;
	}

	// Exec command 
	if (!execCmd("DVC_INIT"))
		return false;

	// Now it expects:
	// PIN
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy(buffer, pPin, 32);
	int r = comm->send(buffer, 32);
	if (r <= 0)
	{
		printf("UART ERROR: 0x%02X\n", r);
		return false;
	}
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS' (different from processResult)
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	r = comm->receive(&buffer[0], 512);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0 && strcmp((char*)buffer, "ALREADY_INIT") != 0)
	{
		if (VERBOSE == 1)
			printf("\nError initing in: %s\n", buffer);
		return 2;
	}

	if (VERBOSE == 1)
		printf("OK.\n");

	return 0;
}

int HSM::login(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_USER_TYPE userType)
{
	// According to the standard, an application only needs to login once for the same token
	// Because all sessions with a token share the same login state
	if (loggedIn)
	{
		return 1;
	}

	if (ulPinLen != 33) // 32B for PIN + 1B for user ID
	{
		return 2;
	}

	if (userType == CKU_SO && pPin[32] != 0) // incorrect admin pin?
	{
		return 2;
	}
	
	comm->reqCommand();

	// Exec command 
	if (!execCmd("SESS_LOGIN"))
		return false;

	// Now it expects:
	// PIN | ID
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy(buffer, pPin, 32);
	buffer[32] = pPin[32]; // ID
	int r = comm->send(buffer, 33);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return 3;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (!processResult())
		return 4;

	isAdmin = false;
	if (userType == CKU_SO)
		isAdmin = true;

	authID = pPin[32];
	loggedIn = true;

	return 0;
}

int HSM::logout()
{
	// Not logged in?
	if (!loggedIn)
	{
		return 1;
	}

	// Exec command 
	if (!execCmd("SESS_LOGOUT"))
		return 2;

	// Wait for 'SUCCESS'
	if (!processResult())
		return 3;

	if (VERBOSE == 1)
		printf("OK.\n");

	authID = 0;
	isAdmin = false;
	loggedIn = false;
	
	return 0;
}

bool HSM::signData(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen)
{
	// Not logged in?
	if (!loggedIn)
	{
		return false;
	}

	// Exec command 
	if (!execCmd("DTSN_SIGN"))
		return false;

	// Calculate SHA-256 of pData
	unsigned char digest[32] = { 0 };
	mbedtls_sha256(pData, ulDataLen, &digest[0], 0);

	// Now it expects:
	// 32B_HASH
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	int r = comm->send(digest, 32);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (!processResult())
		return false;

	// Wait for actual signature
	uint8_t tempSignature[256];
	if (VERBOSE == 1)
		printf("\n\tReceiving actual signature...");
	memset(pSignature, 0, 256);
	*pulSignatureLen = comm->receive(tempSignature, 256);
	if (*pulSignatureLen <= 0)
	{
		printf("UART ERROR: 0x%02X\n", *pulSignatureLen);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK: %d\n", *pulSignatureLen);

	// the function calling this one should make sure the buffer has space for 256B so we don't worry about that here
	memset(pSignature, 0, *pulSignatureLen);
	memcpy(pSignature, tempSignature, *pulSignatureLen);

	if (VERBOSE == 1)
		printf("OK.\n");

	return true;
}

bool HSM::verifySignature(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG pulSignatureLen)
{
	// this shouldn't happen! (unless the points of the curve are huge, e,g. > 1000 bits)
	if (pulSignatureLen > 255)
		return false; 

	// if not logged in, signature verification must provide an ID (author of the signature)
	if (!loggedIn && ulDataLen != 33)
		return false;

	// admin couldn't sign so we can't request a signature to verified for his ID
	if (loggedIn && authID == 0)
		return false;
	
	// Calculate SHA-256 of data
	unsigned char digest[32] = { 0 };
	if (loggedIn)
		mbedtls_sha256(pData, ulDataLen, digest, 0); // message = everything
	else
		mbedtls_sha256(&pData[1], ulDataLen, digest, 0); // message starts at index 1

	// Get user certificate

	// Verify signature here

	// Exec command 
	/*if (!execCmd("DTSN_VERIFY"))
		return false;

	// Now it expects:
	// 1B ID | 32B_HASH | 1B SIGNATURE SIZE
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));

	if (loggedIn)
		buffer[0] = authID;
	else
		buffer[0] = pData[0]; // ID

	memcpy(&buffer[1], digest, 32);
	buffer[33] = (uint8_t)pulSignatureLen; // won't be bigger than 255 because we check at the beginning
	int r = comm->send(buffer, 32+1);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	// Send signature
	if (VERBOSE == 1)
		printf("\n\tSending SIGNATURE...");
	r = comm->send(pSignature, pulSignatureLen);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");*/

	// Wait for 'SUCCESS'
	if (!processResult())
		return false;

	return true;
}

bool HSM::generateKeyPair(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE_PTR privateKey, CK_OBJECT_HANDLE_PTR publicKey)
{
	// Not logged in? admin? (only users can generate and extract a key pair)
	if (!loggedIn || authID == 0)
	{
		return false;
	}

	if (!execCmd("USER_GENKEYS"))
		return false;

	// Wait for 'SUCCESS'
	if (!processResult())
		return false;

	// Wait for both keys
	uint8_t pubBuffer[512] = { 0 };
	int r = 0;
	if ((r = comm->receive(&pubBuffer[0], 512)) <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	uint8_t priBuffer[512] = { 0 };
	if ((r = comm->receive(&priBuffer[0], 512)) <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	// Parse keys
	mbedtls_pk_context ctx_pri, ctx_pub;
	mbedtls_pk_init(&ctx_pri);
	mbedtls_pk_init(&ctx_pub);

	int ret = 0;
	ret = mbedtls_pk_parse_key(&ctx_pri, priBuffer, strlen((char*)priBuffer) + 1, NULL, 0);
	if (ret != 0)
		return false;

	ret = mbedtls_pk_parse_public_key(&ctx_pub, pubBuffer, strlen((char*)pubBuffer) + 1);
	if (ret != 0)
		return false;

	// Validate that they are ECC keys
	ret = mbedtls_pk_can_do(&ctx_pri, MBEDTLS_PK_ECKEY);
	if (ret != 1)
		return false;

	ret = mbedtls_pk_can_do(&ctx_pub, MBEDTLS_PK_ECKEY);
	if (ret != 1)
		return false;

	size_t l1 = mbedtls_pk_get_bitlen(&ctx_pri);
	size_t l2 = mbedtls_pk_get_bitlen(&ctx_pub);

	CK_OBJECT_CLASS keyClass1 = CKO_PUBLIC_KEY;
	CK_OBJECT_CLASS keyClass2 = CKO_PRIVATE_KEY;
	CK_KEY_TYPE keyType = CKK_EC;
	CK_BBOOL MFALSE = CK_FALSE;
	CK_ATTRIBUTE pubTemplate[] = {
		{ CKA_CLASS, &keyClass1, sizeof(keyClass1) },
		{ CKA_KEY_TYPE, &keyType, sizeof(keyType) },
		{ CKA_TOKEN, &MFALSE, sizeof(MFALSE) }, // session object
		//{ CKA_EC_PARAMS, ecParams, sizeof(ecParams) },
		{ CKA_EC_POINT, pubBuffer, l2 } // This should be "DER-encoding of ANSI X9.62 ECPoint value Q"
		
	};
	CK_ATTRIBUTE priTemplate[] = {
		{ CKA_CLASS, &keyClass2, sizeof(keyClass2) },
		{ CKA_KEY_TYPE, &keyType, sizeof(keyType) },
		{ CKA_TOKEN, &MFALSE, sizeof(MFALSE) }, // session object
		//{ CKA_EC_PARAMS, ecParams, sizeof(ecParams) },
		{ CKA_VALUE, priBuffer, l1 } // This should be "ANSI X9.62 private value d"
	};

	// We got both keys, create the objects
	CK_OBJECT_HANDLE hPrivate;
	CK_OBJECT_HANDLE hPublic;
	r = C_CreateObject(hSession, priTemplate, 4, &hPrivate);
	if (r != CKR_OK)
		return false;

	r = C_CreateObject(hSession, pubTemplate, 4, &hPublic);
	if (r != CKR_OK)
	{
		C_DestroyObject(hSession, hPrivate);
		return false;
	}

	*privateKey = hPrivate;
	*publicKey = hPublic;

	if (VERBOSE == 1)
		printf("OK.\n");

	return true;
}

bool HSM::getCertificate(CK_LONG uid, CK_UTF8CHAR_PTR* certificate, CK_ULONG_PTR bufSize)
{
	if (uid == 0)
		return false;

	if (uid > 0)
	{
		if (!execCmd("USER_CERT"))
			return false;

		// Now it expects:
		// 1B ID
		if (VERBOSE == 1)
			printf("\n\tSending DATA...");
		memset(buffer, 0, sizeof(buffer));
		buffer[0] = (CK_BYTE)uid;
		int r = comm->send(buffer, 1);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		if (VERBOSE == 1)
			printf("OK\n");

		// Wait for 'SUCCESS'
		if (!processResult())
			return false;

		// Wait for actual certificate
		if (VERBOSE == 1)
			printf("\n\tReceiving certificate content...");
		memset(buffer, 0, sizeof(buffer));
		r = comm->receive(&buffer[0], 4096);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}
		if (VERBOSE == 1)
			printf("OK.\n");

		mbedtls_x509_crt crt;
		mbedtls_x509_crt_init(&crt);
		r = mbedtls_x509_crt_parse(&crt, buffer, strlen((char*)buffer) + 1);
		if (r != 0)
			return false;

		if (*bufSize < strlen((char*)buffer) + 1 || certificate == NULL)
		{
			*bufSize = strlen((char*)buffer) + 1;
			return false;
		}

		memcpy(certificate, buffer, strlen((char*)buffer) + 1);

		if (VERBOSE == 1)
			printf("OK.\n");
	}
	else if (uid == -1)
	{
		// Logs Certificate

		if (!execCmd("CRT_GET_LOGS"))
			return false;

		// Wait for 'SUCCESS'
		if (!processResult())
			return false;

		// Wait for actual certificate
		if (VERBOSE == 1)
			printf("\n\tReceiving certificate content...");
		memset(buffer, 0, sizeof(buffer));
		int r = comm->receive(&buffer[0], 4096);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}
		if (VERBOSE == 1)
			printf("OK.\n");

		mbedtls_x509_crt crt;
		mbedtls_x509_crt_init(&crt);
		r = mbedtls_x509_crt_parse(&crt, buffer, strlen((char*)buffer) + 1);
		if (r != 0)
			return false;

		if (*bufSize < strlen((char*)buffer) + 1 || certificate == NULL)
		{
			*bufSize = strlen((char*)buffer) + 1;
			return false;
		}

		DIR *dir;
		if ((dir = opendir("./certs")) == NULL)
		{
			if (_mkdir("./certs") == 0)
			{
				if (VERBOSE == 1)
					printf("Directory './certs' was successfully created\n");
			}
			else {
				if (VERBOSE == 1)
					printf("Problem creating directory './certs'\n");
				return false;
			}
		}
		else
			closedir(dir);

		std::ofstream outfile;
		outfile.open("./certs/logs.crt", std::ofstream::out | std::ofstream::trunc);
		outfile.write((char*)buffer, strlen((char*)buffer) + 1);
		outfile.close();

		if (VERBOSE == 1)
			printf("OK.\n");
	}
	else if (uid == -2)
	{
		// Session Certificate

		if (!execCmd("CRT_GET_SESSION"))
			return false;

		// Wait for 'SUCCESS'
		if (!processResult())
			return false;

		// Wait for actual certificate
		if (VERBOSE == 1)
			printf("\n\tReceiving certificate content...");
		memset(buffer, 0, sizeof(buffer));
		int r = comm->receive(&buffer[0], 4096);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}
		if (VERBOSE == 1)
			printf("OK.\n");

		mbedtls_x509_crt crt;
		mbedtls_x509_crt_init(&crt);
		r = mbedtls_x509_crt_parse(&crt, buffer, strlen((char*)buffer) + 1);
		if (r != 0)
			return false;

		if (*bufSize < strlen((char*)buffer) + 1 || certificate == NULL)
		{
			*bufSize = strlen((char*)buffer) + 1;
			return false;
		}

		DIR *dir;
		if ((dir = opendir("./certs")) == NULL)
		{
			if (_mkdir("./certs") == 0)
			{
				if (VERBOSE == 1)
					printf("Directory './certs' was successfully created\n");
			}
			else {
				if (VERBOSE == 1)
					printf("Problem creating directory './certs'\n");
				return false;
			}
		}
		else
			closedir(dir);

		std::ofstream outfile;
		outfile.open("./certs/session.crt", std::ofstream::out | std::ofstream::trunc);
		outfile.write((char*)buffer, strlen((char*)buffer) + 1);
		outfile.close();

		if (VERBOSE == 1)
			printf("OK.\n");
	}
	else if (uid == -3)
	{
		// Issuer Certificate

		if (!execCmd("CRT_GET_ISSUER"))
			return false;

		// Wait for 'SUCCESS'
		if (!processResult())
			return false;

		// Wait for actual certificate
		if (VERBOSE == 1)
			printf("\n\tReceiving certificate content...");
		memset(buffer, 0, sizeof(buffer));
		int r = comm->receive(&buffer[0], 4096);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}
		if (VERBOSE == 1)
			printf("OK.\n");

		mbedtls_x509_crt crt;
		mbedtls_x509_crt_init(&crt);
		r = mbedtls_x509_crt_parse(&crt, buffer, strlen((char*)buffer) + 1);
		if (r != 0)
			return false;

		if (*bufSize < strlen((char*)buffer) + 1 || certificate == NULL)
		{
			*bufSize = strlen((char*)buffer) + 1;
			return false;
		}

		DIR *dir;
		if ((dir = opendir("./certs")) == NULL)
		{
			if (_mkdir("./certs") == 0)
			{
				if (VERBOSE == 1)
					printf("Directory './certs' was successfully created\n");
			}
			else {
				if (VERBOSE == 1)
					printf("Problem creating directory './certs'\n");
				return false;
			}
		}
		else
			closedir(dir);

		std::ofstream outfile;
		outfile.open("./certs/issuer.crt", std::ofstream::out | std::ofstream::trunc);
		outfile.write((char*)buffer, strlen((char*)buffer) + 1);
		outfile.close();

		if (VERBOSE == 1)
			printf("OK.\n");
	}
	else
		return false;

	return true;
}

bool HSM::genCertificate(CK_ATTRIBUTE_PTR publicKeyTemplate, CK_ULONG ulCount, CK_UTF8CHAR_PTR publicKey, CK_UTF8CHAR_PTR certificate, CK_ULONG_PTR bufSize)
{
	if (!loggedIn || !isAdmin)
		return false;

	// Parse Public Key (must be in PEM format)
	mbedtls_pk_context ctx_pub;
	mbedtls_pk_init(&ctx_pub);

	// check if it can be parsed (should be in PEM format)
	int ret = mbedtls_pk_parse_public_key(&ctx_pub, publicKey, strlen((char*)publicKey) + 1);
	if (ret != 0)
	{
		mbedtls_pk_free(&ctx_pub);
		return false;
	}

	if (strlen((char*)publicKey) + 1 > sizeof(buffer))
	{
		mbedtls_pk_free(&ctx_pub);
		return false;
	}

	// Check template
	CK_UTF8CHAR * subjectName;
	uint16_t keyUsage = 0;

	// Check template attribute
	// Subject name, Key usage
	// Check parameters (we only care about CKA_CLASS and CKA_KEY_TYPE...)
	uint32_t p = 0;
	for (p = 0; p < ulCount; p++)
	{
		if (publicKeyTemplate[p].type == CKA_SUBJECT)
		{
			subjectName = (CK_UTF8CHAR*)publicKeyTemplate[p].pValue;
			if (strlen((char*)subjectName) > 255) // HSM only supports 255 chars subject names
			{
				mbedtls_pk_free(&ctx_pub);
				return false;
			}
		}

		if (publicKeyTemplate[p].type == CKA_ENCRYPT)
			keyUsage |= MBEDTLS_X509_KU_DATA_ENCIPHERMENT;

		if (publicKeyTemplate[p].type == CKA_VERIFY)
		{
			keyUsage |= MBEDTLS_X509_KU_DIGITAL_SIGNATURE;
			keyUsage |= MBEDTLS_X509_KU_KEY_CERT_SIGN;
			keyUsage |= MBEDTLS_X509_KU_CRL_SIGN;
			keyUsage |= MBEDTLS_X509_KU_NON_REPUDIATION;
		}

		if (publicKeyTemplate[p].type == CKA_VERIFY_RECOVER)
		{
			keyUsage |= MBEDTLS_X509_KU_DIGITAL_SIGNATURE;
			keyUsage |= MBEDTLS_X509_KU_KEY_CERT_SIGN;
			keyUsage |= MBEDTLS_X509_KU_CRL_SIGN;
			keyUsage |= MBEDTLS_X509_KU_NON_REPUDIATION;
		}

		if (publicKeyTemplate[p].type == CKA_DERIVE)
			keyUsage |= MBEDTLS_X509_KU_KEY_AGREEMENT;

		if (publicKeyTemplate[p].type == CKA_WRAP)
			keyUsage |= MBEDTLS_X509_KU_KEY_ENCIPHERMENT;
	}

	// Place the keyUsage into an array
	unsigned char keyUsageArray[2];
	keyUsageArray[0] = keyUsage & 0x000000FF;
	keyUsageArray[1] = (keyUsage & 0x0000FF00) >> 8;

	if (!execCmd("CRT_REQUEST"))
		return false;

	// Now it expects:
	// subject name + \0 or 0 (should be the same thing) | 1B for key usage
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy(buffer, subjectName, strlen((char*)subjectName));
	buffer[strlen((char*)subjectName)] = '\0';
	buffer[strlen((char*)subjectName) + 1] = keyUsageArray[0];
	buffer[strlen((char*)subjectName) + 2] = keyUsageArray[1];
	int r = comm->send(buffer, strlen((char*)subjectName) + 1 + 2); // +1 because of \0 at the end of subject name and +2 because of key usage
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	// Send public key
	if (VERBOSE == 1)
		printf("\n\tSending public key...");
	memset(buffer, 0, sizeof(buffer));
	memcpy(buffer, publicKey, strlen((char*)publicKey)*sizeof(CK_UTF8CHAR));
	r = comm->send(buffer, strlen((char*)buffer)+1);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (!processResult())
	{
		mbedtls_pk_free(&ctx_pub);
		return false;
	}

	// Wait for actual certificate
	if (VERBOSE == 1)
		printf("\n\tReceiving certificate content...");
	memset(buffer, 0, sizeof(buffer));
	r = comm->receive(&buffer[0], 4096);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		mbedtls_pk_free(&ctx_pub);
		return false;
	}
	if (VERBOSE == 1)
		printf("OK.\n");

	if (VERBOSE == 1)
		printf("OK.\n");

	// copy certificate
	memcpy(certificate, buffer, strlen((char*)buffer) + 1);

	mbedtls_pk_free(&ctx_pub);

	return true;
}

bool HSM::addUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_BYTE_PTR uID)
{
	if (!loggedIn || !isAdmin)
		return false;

	if (ulPinLen != 32)
		return false;

	if (!execCmd("USER_NEW"))
		return false;

	// Now it expects:
	// USER_PIN
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy((char*)buffer, pPin, ulPinLen*sizeof(CK_UTF8CHAR));
	int r = comm->send(buffer, strlen((char*)buffer));
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (!processResult())
		return false;

	// Wait for ID (1B)
	if (VERBOSE == 1)
		printf("\n\tReceiving ID...");
	memset(buffer, 0, sizeof(buffer));
	r = comm->receive(&buffer[0], 4096);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}
	if (VERBOSE == 1)
		printf("OK: %d\n", buffer[0]);
	if (buffer[0] <= 0 || buffer[0] > 255)
		return false;

	if (VERBOSE == 1)
		printf("OK.\n");

	*uID = buffer[0];

	return true;
}

bool HSM::modifyUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen)
{
	if (!loggedIn || isAdmin) // admin cannot modify PINs
		return false;

	if (ulPinLen != 32)
		return false;

	if (!execCmd("USER_MODIFY"))
		return false;

	// Now it expects:
	// USER_PIN
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy((char*)buffer, pPin, ulPinLen * sizeof(CK_UTF8CHAR));
	int r = comm->send(buffer, strlen((char*)buffer));
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (!processResult())
		return false;

	return true;
}

bool HSM::deleteUser(CK_BYTE uID)
{
	if (!loggedIn || !isAdmin)
		return false;

	if (uID <= 0 || uID > 255)
		return false;

	if (!execCmd("USER_DELETE"))
		return false;

	// Now it expects:
	// USER_ID
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	buffer[0] = uID;
	int r = comm->send(buffer, 1);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (!processResult())
		return false;

	return true;
}

// Message must not only contain ASCII characters! 
bool HSM::logsInit(CK_UTF8CHAR_PTR pMessage, CK_ULONG lMessage, CK_UTF8CHAR_PTR lHash)
{
	// we only accept messages with a maximum of 512 bytes
	if (lMessage > 512)
		return false;

	// not a valid user (must be admin)
	if (!loggedIn || authID != 0)
		return false;

	uint8_t base64_2[512] = { 0 };
	uint32_t olen_2 = 0;

	// Depending on the date, choose which file to write to
	//time_t t = time(NULL);

	/* Code below is used for fake date/time testing */
	static time_t static_time, t;
	static int iteration;
	if (static_time == 0)
	{
		static_time = 1421331320;
		t = static_time;
	}

	if (iteration % 5 == 0)
	{
		t += 60 * 60 * 24 * 2;
	}
	iteration++;
	/* end of test code */

	struct tm now;
	localtime_s(&now, &t);


	// Run LOGS_INIT command

	if (!execCmd("LOGS_INIT"))
		return false;

	// Send message
	if (VERBOSE == 1)
		printf("\n\tSending message...");
	int r = comm->send(pMessage, lMessage);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	// Send init hash
	if (VERBOSE == 1)
		printf("\n\tSending init hash...");
	r = comm->send(lHash, 32);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for response
	if (VERBOSE == 1)
		printf("\n\tReceiving response...");
	memset(buffer, 0, sizeof(buffer));
	r = comm->receive(&buffer[0], 4096);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		return false;
	}

	// Wait for logged message
	if (VERBOSE == 1)
		printf("\n\tReceiving logged message...");
	memset(buffer, 0, sizeof(buffer));
	r = comm->receive(&buffer[0], 4096);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK.\n");

	// Wait for signature
	if (VERBOSE == 1)
		printf("\n\tReceiving log signature...");
	uint8_t signature[256];
	memset(signature, 0, sizeof(signature));
	uint32_t sig_len = comm->receive(&signature[0], 256);
	if (sig_len <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", sig_len);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK.\n");

	if (mbedtls_base64_encode(base64_2, 512, &olen_2, signature, sig_len) != 0)
	{
		return false;
	}

	// Base64 encode the log hash and signature
	// Base64 requires 4/3 of the original size so we simply double it to avoid dynamic allocation
	uint8_t hash[32] = { 0 };
	mbedtls_sha256(&buffer[0], strlen((char*)buffer), hash, 0);

	uint8_t base64_1[512];
	uint32_t olen_1 = 0;
	if (mbedtls_base64_encode(base64_1, 512, &olen_1, hash, 32) != 0)
	{
		return false;
	}

	// Do we have the year X and month Y folder inside logchain?
	DIR *dir;
	char path[256];
	sprintf_s(path, 256, "./logchain/%d", now.tm_year + 1900);
	if ((dir = opendir(path)) == NULL)
	{
		if (_mkdir(path) == 0)
		{
			if (VERBOSE == 1)
				printf("Directory '%s' was successfully created\n", path);
		}
		else {
			if (VERBOSE == 1)
				printf("Problem creating directory %s\n", path);
			return false;
		}
	}
	else
		closedir(dir);

	sprintf_s(path, 256, "%s/%d", path, now.tm_mon + 1);
	if ((dir = opendir(path)) == NULL)
	{
		if (_mkdir(path) == 0)
		{
			if (VERBOSE == 1)
				printf("Directory '%s' was successfully created\n", path);
		}
		else {
			if (VERBOSE == 1)
				printf("Problem creating directory %s\n", path);
			return false;
		}
	}
	else
		closedir(dir);

	// date,time:
	uint8_t datetime[30] = { 0 };
	int w = snprintf((char*)datetime, 30, "%d-%d-%03d,%02d:%02d:%02d",
		(int)now.tm_mday,
		(int)now.tm_mon + 1,
		(int)now.tm_year + 1900,
		(int)now.tm_hour,
		(int)now.tm_min,
		(int)now.tm_sec);

	// Append logged message + signature to file
	sprintf_s(path, 256, "%s/%d.txt", path, now.tm_mday);
	std::ofstream outfile;
	outfile.open(path, std::ios_base::app);
	outfile << datetime << ":";
	outfile << buffer << " [";
	outfile.write((char*)base64_1, olen_1);
	outfile << "]";
	outfile << " [";
	outfile.write((char*)base64_2, olen_2);
	outfile << "]" << std::endl;
	outfile.close();
	if (VERBOSE == 1)
		printf("OK.\n");

	return true;
}


bool HSM::logsAdd(CK_UTF8CHAR_PTR pMessage, CK_ULONG lMessage, CK_BBOOL sign)
{
	// we only accept messages with a maximum of 512 bytes
	if (lMessage > 512)
		return false;

	// not a valid user
	if (!loggedIn || authID == 0)
		return false;

	// Get all folders within /logchain
	// If any, browse the most recent (in terms of name: the name of each folder represents the year)
	// Then get the list of folders within the year folder and choose the most recent in terms of name: represents the month number
	// Finally, choose the most recent file (also in terms of name: it represents the day number)

	char readPath[256] = { 0 };

	DIR *dir;
	if ((dir = opendir("./logchain")) == NULL)
	{
		if (_mkdir("./logchain") == 0)
		{
			if (VERBOSE == 1)
				printf("Directory './logchain' was successfully created\n");
		}
		else {
			if (VERBOSE == 1)
				printf("Problem creating directory './logchain'\n");
			return false;
		}
	}
	else
		closedir(dir);

	if ((dir = opendir("./logchain")) != NULL)
	{
		closedir(dir);

		// Find most recent year
		std::vector<std::string> years_folders = read_directory("./logchain", true);
		if (!years_folders.empty())
		{
			std::string year_folder = years_folders.back();

			sprintf_s(readPath, 256, "./logchain/%s", year_folder.c_str());

			// Find most recent month
			std::vector<std::string> months_folders = read_directory(readPath, true);
			if (!months_folders.empty())
			{
				std::string month_folder = months_folders.back();

				sprintf_s(readPath, 256, "%s/%s", readPath, month_folder.c_str());

				// Find most recent day
				std::vector<std::string> days_files = read_directory(readPath, false);
				if (!days_files.empty())
				{
					std::string day_file = days_files.back();

					sprintf_s(readPath, 256, "%s/%s", readPath, day_file.c_str());
				}
				else
					memset(readPath, 0, 256);
			}
			else
				memset(readPath, 0, 256);
		}
	}
	else {
		/* could not open directory */
		perror("Could not open log-chain dir.");
		return EXIT_FAILURE;
	}

	bool hasRoot = false;
	uint8_t prevHash[32] = { 0 };

	// Read the file and get the last line
	// Extract the hash and use it as the previous hash
	if (memcmp(readPath, zero, 256) != 0)
	{
		std::ifstream file(readPath);
		if (file)
		{
			std::string line = getLastLine(file);
			file.close();
			//std::cout << line << '\n';

			// First find } and substring what's after + 3 chars (includes "} [")
			unsigned first = line.find('}');
			if (first != std::string::npos)
			{
				std::string last_part = line.substr(first + 3);

				// Then look for ] and retrieve data until that posistion (] is an illegal base64 char so it won't appear in the middle of the block)
				unsigned last = last_part.find(']');
				if (last != std::string::npos)
				{
					std::string base64_hash = last_part.substr(0, last);

					unsigned char buf[512] = { 0 };
					sprintf_s((char*)buf, 512, base64_hash.c_str());
					uint32_t olen = 0;
					if (mbedtls_base64_decode(prevHash, 32, &olen, buf, base64_hash.length()) != 0)
					{
						return false;
					}

					hasRoot = true;
				}
			}
		}
		else
			if (VERBOSE == 1)
				printf("Error opening file for reading.\n");
	}

	// If there are no existing hashes, use pMessage as the Chain-Root and therefore our hash = all 0s

	uint8_t base64_2[512] = { 0 };
	uint32_t olen_2 = 0;

	// Depending on the date, choose which file to write to
	time_t t = time(NULL);

	/* Code below is used for fake date/time testing */
	/*static time_t static_time, t;
	static int iteration;
	if (static_time == 0)
	{
		static_time = 1421331322;
		t = static_time;
	}

	if (iteration % 5 == 0)
	{
		t += 60 * 60 * 24 * 2;
	}
	iteration++;*/
	/* end of test code */

	struct tm now;
	localtime_s(&now, &t);

	if (sign == CK_TRUE)
	{
		if (!execCmd("LOGS_ADD"))
			return false;

		// Send message
		if (VERBOSE == 1)
			printf("\n\tSending message...");
		int r = comm->send(pMessage, lMessage);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		if (VERBOSE == 1)
			printf("OK\n");

		// Send previous hash
		if (VERBOSE == 1)
			printf("\n\tSending previous hash...");
		r = comm->send(prevHash, 32);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		if (VERBOSE == 1)
			printf("OK\n");

		// Wait for response
		if (VERBOSE == 1)
			printf("\n\tReceiving response...");
		memset(buffer, 0, sizeof(buffer));
		r = comm->receive(&buffer[0], 4096);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		if (VERBOSE == 1)
			printf("OK: %s\n", buffer);
		if (strcmp((char*)buffer, "SUCCESS") != 0)
		{
			return false;
		}

		// Wait for logged message
		if (VERBOSE == 1)
			printf("\n\tReceiving logged message...");
		memset(buffer, 0, sizeof(buffer));
		r = comm->receive(&buffer[0], 4096);
		if (r <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", r);
			return false;
		}

		if (VERBOSE == 1)
			printf("OK.\n");

		// Wait for hash
		/*uint8_t hash[32];
		if (VERBOSE == 1)
			printf("\n\tReceiving log hash...");
		memset(hash, 0, sizeof(hash));
		comm->receive(&hash[0], 32);
		if (VERBOSE == 1)
			printf("OK.\n");*/

			// Wait for signature
		if (VERBOSE == 1)
			printf("\n\tReceiving log signature...");
		uint8_t signature[256];
		memset(signature, 0, sizeof(signature));
		uint32_t sig_len = comm->receive(&signature[0], 256);
		if (sig_len <= 0)
		{
			if (VERBOSE == 1)
				printf("UART ERROR: 0x%02X\n", sig_len);
			return false;
		}

		if (VERBOSE == 1)
			printf("OK.\n");

		if (mbedtls_base64_encode(base64_2, 512, &olen_2, signature, sig_len) != 0)
		{
			return false;
		}
	}
	else
	{
		// base64 encode the message
		uint8_t base64_0[1024] = { 0 };
		size_t olen_0 = 0;
		if (mbedtls_base64_encode(base64_0, 1023, &olen_0, pMessage, lMessage) != 0) // 1023 because we want the last char to be \0
		{
			return false;
		}

		memset(buffer, 0, 4096);
		int w = snprintf((char*)buffer, 4096, "{%s|%d-%d-%03d,%02d:%02d:%02d|%d|-,-|",
			base64_0,
			(int)now.tm_mday,
			(int)now.tm_mon + 1,
			(int)now.tm_year + 1900,
			(int)now.tm_hour,
			(int)now.tm_min,
			(int)now.tm_sec,
			authID);

		// prev hash goes here (base64)
		int i = 0;
		for (i = 0; i < 32; i++)
			w += snprintf((char*)buffer + w, 4096 - w, "%02X", prevHash[i]);

		buffer[w] = '}';
	}

	// Base64 encode the log hash and signature
	// Base64 requires 4/3 of the original size so we simply double it to avoid dynamic allocation
	uint8_t hash[32] = { 0 };
	mbedtls_sha256(&buffer[0], strlen((char*)buffer), hash, 0);

	uint8_t base64_1[512];
	uint32_t olen_1 = 0;
	if (mbedtls_base64_encode(base64_1, 512, &olen_1, hash, 32) != 0)
	{
		return false;
	}

	// Do we have the year X and month Y folder inside logchain?
	char path[256];
	sprintf_s(path, 256, "./logchain/%d", now.tm_year + 1900);
	if ((dir = opendir(path)) == NULL)
	{
		if (_mkdir(path) == 0)
		{
			if (VERBOSE == 1)
				printf("Directory '%s' was successfully created\n", path);
		}
		else {
			if (VERBOSE == 1)
				printf("Problem creating directory %s\n", path);
			return false;
		}
	}
	else
		closedir(dir);

	sprintf_s(path, 256, "%s/%d", path, now.tm_mon + 1);
	if ((dir = opendir(path)) == NULL)
	{
		if (_mkdir(path) == 0)
		{
			if (VERBOSE == 1)
				printf("Directory '%s' was successfully created\n", path);
		}
		else {
			if (VERBOSE == 1)
				printf("Problem creating directory %s\n", path);
			return false;
		}
	}
	else
		closedir(dir);

	// date,time:
	uint8_t datetime[30] = { 0 };
	int w = snprintf((char*)datetime, 30, "%d-%d-%03d,%02d:%02d:%02d",
		(int)now.tm_mday,
		(int)now.tm_mon + 1,
		(int)now.tm_year + 1900,
		(int)now.tm_hour,
		(int)now.tm_min,
		(int)now.tm_sec);

	// Append logged message + signature to file
	sprintf_s(path, 256, "%s/%d.txt", path, now.tm_mday);
	std::ofstream outfile;
	outfile.open(path, std::ios_base::app);
	outfile << datetime << ":";
	outfile << buffer << " [";
	outfile.write((char*)base64_1, olen_1);
	outfile << "]";
	outfile << " [";
	outfile.write((char*)base64_2, olen_2);
	outfile << "]" << std::endl;
	outfile.close();
	if (VERBOSE == 1)
		printf("OK.\n");

	return true;
}

bool HSM::logsVerifyDay(CK_ULONG lDay, CK_ULONG lMonth, CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain)
{
	int ret = 0;
	char readPath[256] = { 0 };
	sprintf_s(readPath, 256, "./logchain/%d/%d", lYear, lMonth);

	// Get the selected file (if none, return false)
	DIR *dir;
	if ((dir = opendir(readPath)) == NULL)
	{
		if (VERBOSE == 1)
			printf("Directory '%s' does not exist.\n", readPath);
		return false;
	}
	else
		closedir(dir);

	sprintf_s(readPath, 256, "%s/%d.txt", readPath, lDay);

	// Check if file exists when opening it
	std::ifstream file(readPath);
	if (!file)
	{
		if (VERBOSE == 1)
			printf("File '%s' does not exist.\n", readPath);
		return false;
	}

	// Use device logs public key
	if (logs_cert == NULL)
	{
		// Read certificate file ./certs/logs.cert
		logs_cert = (mbedtls_x509_crt*)malloc(sizeof(mbedtls_x509_crt));
		if (logs_cert == NULL)
			return false;

		mbedtls_x509_crt_init(logs_cert);
		mbedtls_pk_init(&logs_cert->pk);

		ret = mbedtls_x509_crt_parse_file(logs_cert, "././certs/logs.crt");
		if (ret != 0)
		{
			// certificate is missing, can't validate chain
			if (VERBOSE == 1)
				printf("Error parsing public key certificate.\n");
			mbedtls_x509_crt_free(logs_cert);
			logs_cert = NULL;
			file.close();
			return false;
		}
	}

	// Start at the bottom of the file, verify the signature 
	std::string line;
	std::vector<std::string> v;

	uint8_t hash[32] = { 0 }; // hash of log entry (computed on the fly)
	uint8_t hash_v[32] = { 0 }; // base64 DECODED hash
	uint8_t hash_embedded[32] = { 0 }; // the hash within the log entry that is respective to the previous line
	uint8_t hash_prev[32] = { 0 }; // hash of the previous log entry (must match the current embedded hash)
	uint8_t signature[512];
	std::string message;

	// Copy prevHash to hash_prev
	if(prevHash != NULL_PTR)
		memcpy(hash_prev, prevHash, 32);

	int l = 1;
	while (getline(file, line))
	{
		// Extract message and compute hash
		// First find {
		unsigned first = line.find('{');
		if (first == std::string::npos)
		{
			if (VERBOSE == 1)
				printf("Invalid format 1_1 on root-line\n");
			file.close();
			return false;
		}

		// Then find } and retrieve the message
		unsigned second = line.find('}');
		if (second != std::string::npos)
		{
			message = line.substr(first, second + 1 - first);
		}
		else
		{
			if (VERBOSE == 1)
				printf("Invalid format 1_2 on root-line\n");
			file.close();
			return false;
		}

		memset(hash, 0, sizeof(hash));
		mbedtls_sha256((unsigned char*)message.c_str(), message.length(), hash, 0);

		// Extract previous hash
		std::string embedded_hash = message.substr(message.length() - 65, 64);
		char embedded_hash_char[64];
		memcpy(embedded_hash_char, embedded_hash.c_str(), 64);
		hex2bin(embedded_hash_char, (char*)hash_embedded, 64);

		// Extract hash and compare
		// Look for ] (] is an illegal base64 char so it won't appear in the middle of the hash block)
		std::string last_part = line.substr(second + 3);
		unsigned hash_separator = last_part.find(']');
		if (hash_separator != std::string::npos)
		{
			std::string base64_hash = last_part.substr(0, hash_separator); // from [ to ]

			unsigned char buf[512] = { 0 };
			sprintf_s((char*)buf, 512, base64_hash.c_str());
			uint32_t olen = 0;
			if (mbedtls_base64_decode(hash_v, 32, &olen, buf, base64_hash.length()) != 0)
			{
				printf("Base64 Decode of Hash on line %d\n", l);
				file.close();
				return false;
			}
		}
		else
		{
			if (VERBOSE == 1)
				printf("Invalid format 2 on line %d\n", l);
			file.close();
			return false;
		}

		// Compare both
		if (memcmp(hash, hash_v, 32) != 0)
		{
			if (VERBOSE == 1)
				printf("Hash mismatch on line %d\n", l);
			file.close();
			return false;
		}

		// Extract signature
		std::string signature_part = last_part.substr(hash_separator + 3);
		unsigned sig_separator = signature_part.find(']');
		if (sig_separator != std::string::npos)
		{
			std::string base64_sig = signature_part.substr(0, sig_separator); // from [ to ]

			// Only verify signature if we have one
			if (base64_sig.length() > 0)
			{
				unsigned char buf[512] = { 0 };
				sprintf_s((char*)buf, 512, base64_sig.c_str());
				uint32_t olen = 0;
				if (mbedtls_base64_decode(signature, 512, &olen, buf, base64_sig.length()) != 0)
				{
					if (VERBOSE == 1)
						printf("Base64 Decode of Signature on line %d\n", l);
					file.close();
					return false;
				}

				// Verify signature
				int ret = mbedtls_pk_verify(&logs_cert->pk, MBEDTLS_MD_SHA256, hash, 32, signature, olen);
				if (ret != 0)
				{
					if (VERBOSE == 1)
						printf("Signature mismatch on line %d\n", l);
					file.close();
					return false;
				}

				// Update lastMessage because we did a signature verification and this is the one that will be verified in the end of the chain verification
				lastMessage = message.c_str();
			}
			else
				if (VERBOSE == 1)
					printf("Skipping signature verification on line %d\n", l);
		}
		else
		{
			if (VERBOSE == 1)
				printf("Invalid format 3 on line %d\n", l);
			file.close();
			return false;
		}

		// Verify that the embedded hash matches the previous line hash
		// 1. Skip first because we consider it the root of the file and we're only verifying the day
		// 2. Or don't skip if we have a previous hash as an argument
		if (memcmp(hash_embedded, hash_prev, 32) != 0
			&& 
				(
					l != 1 // line != 1 so not a problem
					||
					(l == 1 && prevHash != NULL_PTR && fullChain == CK_TRUE) // we're doing a full-chain verification: ignore if prevHash == NULL but otherwise we will verify embedded hash against prevHash (should be 0000)
					||
					(l == 1 && memcmp(hash_prev, zero, 32) != 0 && fullChain == CK_FALSE) // we're not doing a full-chain verification: ignore if prevHash == 0000000
				)
			)
		{
			if (VERBOSE == 1)
				printf("Embedded hash mismatch on line %d\n", l);
			file.close();
			return false;
		}

		// Store current hash as previous hash
		memcpy(hash_prev, hash, 32);

		l++;
	}

	file.close();

	// Store hash_prev in prevHash (hash_prev will be the last hash when the loop finishes)
	if(prevHash != NULL_PTR)
		memcpy(prevHash, hash_prev, 32);

	if (VERBOSE)
		printf("Day %d verified successfully.\n", lDay);
	return true;
}

bool HSM::logsVerifyMonth(CK_ULONG lMonth, CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain)
{
	// Check if folder exists
	// Return false if not
	char readPath[256] = { 0 };
	sprintf_s(readPath, 256, "./logchain/%d/%d", lYear, lMonth);

	DIR *dir;
	if ((dir = opendir(readPath)) == NULL)
	{
		if (VERBOSE == 1)
			printf("Directory '%s' does not exist.\n", readPath);
		return false;
	}
	else
		closedir(dir);

	// Get max days of the month
	// If lMonth==current_month -> max days = current_day
	// Otherwise max days = 29

	time_t theTime = time(NULL);
	struct tm aTime;
	localtime_s(&aTime, &theTime);

	int max_days = 0;
	if (aTime.tm_mon+1 == lMonth && (aTime.tm_year + 1900) == lYear)
	{
		max_days = aTime.tm_mday;
	}
	else
	{
		int month = aTime.tm_mon + 1; // Month is 0-11 so we add 1
		int year = aTime.tm_year + 1900; // Years since 1900
		if (month == 4 || month == 6 || month == 9 || month == 11)
			max_days = 30;
		else if (month == 02)
		{
			bool leapyear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

			if (leapyear == 0)
				max_days = 29;
			else
				max_days = 28;
		}
		else
			max_days = 31;
	}

	// Previous hash = 0
	// For d=1 ; d<=max_days
	// 1. Check if file exists (skip if not)
	// 2. Compute logsVerifyDay for each day file
	// 3. Previous hash will now be equal to the last hash of the processed file
	uint8_t prev_hash[32] = {0};
	if (prevHash != NULL_PTR)
		memcpy(prev_hash, prevHash, 32); // use previous hash if any

	for (int d = 1; d <= max_days; d++)
	{
		struct stat s;
		sprintf_s(readPath, 256, "./logchain/%d/%d/%d.txt", lYear, lMonth, d);
		
		if ((stat(readPath, &s) != 0))
		{
			//printf("Skipping %s because it does not exist.\n", readPath);
			continue; // file doesn't exist
		}

		bool r = logsVerifyDay(d, lMonth, lYear, &prev_hash[0], fullChain);
		if (r == false)
		{
			if (VERBOSE == 1)
				printf("\nError verifying day %d\n", d);
			return false;
		}
	}

	// Store prev_hash in prevHash (prev_hash will be the last hash when the loop finishes)
	if (prevHash != NULL_PTR)
		memcpy(prevHash, prev_hash, 32);

	if (VERBOSE)
		printf("Month %d verified successfully.\n", lMonth);
	return true;
}

bool HSM::logsVerifyYear(CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain)
{
	// Check if folder exists
	// Return false if not
	char readPath[256] = { 0 };
	sprintf_s(readPath, 256, "./logchain/%d", lYear);

	DIR *dir;
	if ((dir = opendir(readPath)) == NULL)
	{
		if (VERBOSE == 1)
			printf("Directory '%s' does not exist.\n", readPath);
		return false;
	}
	else
		closedir(dir);

	// Get max months of the year
	// If lYear==current_year -> max months = current_month
	// Otherwise max months = 12
	time_t theTime = time(NULL);
	struct tm aTime;
	localtime_s(&aTime, &theTime);

	int max_months = 0;
	if (aTime.tm_year + 1900 == lYear)
	{
		max_months = aTime.tm_mon + 1;
	}
	else
		max_months = 12;

	// Previous hash = 0
	// For m=1 ; m<=max_months
	// 1. Check if folder exists (skip if not)
	// 2. Compute logsVerifyMonth for each month folder
	// 3. Previous hash will now be equal to the last hash of the processed month
	uint8_t prev_hash[32] = { 0 };
	if (prevHash != NULL_PTR)
		memcpy(prev_hash, prevHash, 32); // use previous hash if any

	for (int m = 1; m <= max_months; m++)
	{
		struct stat s;
		sprintf_s(readPath, 256, "./logchain/%d/%d", lYear, m);

		if ((stat(readPath, &s) != 0) || !(s.st_mode & S_IFDIR))
		{
			//printf("Skipping %s because it does not exist.\n", readPath);
			continue; // file doesn't exist
		}

		bool r = logsVerifyMonth(m, lYear, &prev_hash[0], fullChain);
		if (r == false)
		{
			if (VERBOSE == 1)
				printf("\nError verifying month %d\n", m);
			return false;
		}
	}

	// Store prev_hash in prevHash (prev_hash will be the last hash when the loop finishes)
	if (prevHash != NULL_PTR)
		memcpy(prevHash, prev_hash, 32);

	if (VERBOSE)
		printf("Year %d verified successfully.\n", lYear);
	return true;
}

bool HSM::logsVerifyChain(CK_ULONG counter1, CK_ULONG counter2, CK_UTF8CHAR_PTR hash_init)
{
	// Get the oldest year, month and day
	// Check the first line (must be the root)
	// Return false if embedded hash != 0 OR hash doesn't match log entry OR signature cannot be verified
	char readPath[256] = { 0 };
	int start_year = 0;
	int ret = 0;
	std::vector<std::string> years_folders = read_directory("./logchain", true);
	if (!years_folders.empty())
	{
		std::string year_folder = years_folders.front();

		sprintf_s(readPath, 256, "./logchain/%s", year_folder.c_str());
		start_year = atoi(year_folder.c_str());

		// Find most recent month
		std::vector<std::string> months_folders = read_directory(readPath, true);
		if (!months_folders.empty())
		{
			std::string month_folder = months_folders.front();

			sprintf_s(readPath, 256, "%s/%s", readPath, month_folder.c_str());

			// Find most recent day
			std::vector<std::string> days_files = read_directory(readPath, false);
			if (!days_files.empty())
			{
				std::string day_file = days_files.front();

				sprintf_s(readPath, 256, "%s/%s", readPath, day_file.c_str());
			}
			else
				memset(readPath, 0, 256);
		}
		else
			memset(readPath, 0, 256);
	}

	if (VERBOSE == 1)
		printf("\nRoot file: %s\n", readPath);

	if (memcmp(readPath, zero, 256) == 0)
	{
		if (VERBOSE == 1)
			printf("There is no chain to verify.");
		return false;
	}

	// Use device logs public key
	if (logs_cert == NULL)
	{
		// Read certificate file ./certs/logs.cert
		logs_cert = (mbedtls_x509_crt*)malloc(sizeof(mbedtls_x509_crt));
		if (logs_cert == NULL)
			return false;

		mbedtls_x509_crt_init(logs_cert);
		mbedtls_pk_init(&logs_cert->pk);

		ret = mbedtls_x509_crt_parse_file(logs_cert, "./certs/logs.crt");
		if (ret != 0)
		{
			// certificate is missing, can't validate chain
			if (VERBOSE == 1)
				printf("Error parsing public key certificate.\n");
			free(logs_cert);
			logs_cert = NULL;
			return false;
		}
	}

	/// NOTE: Commented code below shouldn't be needed because we pass the prevHash as the chain-hash and the verifyDay will use it for the first file (root)
	// Read first line and extract hash
	// Validate signature
	/*std::ifstream file(readPath);
	if (file)
	{
		std::string line;
		getline(file, line);
		file.close();
		std::cout << "Root:" << line << '\n';

		std::string message;
		uint8_t hash[32];
		uint8_t hash_embedded[32];
		uint8_t hash_v[32];
		uint8_t signature[512];

		// Extract message and compute hash
		// First find {
		unsigned first = line.find('{');
		if (first == std::string::npos)
		{
			if (VERBOSE == 1)
				printf("Invalid format 1_1 on root-line\n");
			file.close();
			return false;
		}

		// Then find } and retrieve the message
		unsigned second = line.find('}');
		if (second != std::string::npos)
		{
			message = line.substr(first, second + 1 - first);
		}
		else
		{
			if (VERBOSE == 1)
				printf("Invalid format 1_2 on root-line\n");
			file.close();
			return false;
		}

		memset(hash, 0, sizeof(hash));
		mbedtls_sha256((unsigned char*)message.c_str(), message.length(), hash, 0);

		// Extract previous hash
		std::string embedded_hash = message.substr(message.length() - 65, 64);
		char embedded_hash_char[64];
		memcpy(embedded_hash_char, embedded_hash.c_str(), 64);
		hex2bin(embedded_hash_char, (char*)hash_embedded, 64);

		// Extract hash and compare
		// Look for ] (] is an illegal base64 char so it won't appear in the middle of the hash block)
		std::string last_part = line.substr(second + 3);
		unsigned hash_separator = last_part.find(']');
		if (hash_separator != std::string::npos)
		{
			std::string base64_hash = last_part.substr(0, hash_separator); // from [ to ]

			unsigned char buf[512] = { 0 };
			sprintf_s((char*)buf, 512, base64_hash.c_str());
			uint32_t olen = 0;
			if (mbedtls_base64_decode(hash_v, 32, &olen, buf, base64_hash.length()) != 0)
			{
				if (VERBOSE == 1)
					printf("Base64 Decode of Hash on root-line\n");
				file.close();
				return false;
			}
		}
		else
		{
			if (VERBOSE == 1)
				printf("Invalid format 2 on root-line\n");
			file.close();
			return false;
		}

		// Compare both
		if (memcmp(hash, hash_v, 32) != 0)
		{
			if (VERBOSE == 1)
				printf("Hash mismatch on root-line\n");
			file.close();
			return false;
		}

		// Extract signature
		std::string signature_part = last_part.substr(hash_separator + 3);
		unsigned sig_separator = signature_part.find(']');
		if (sig_separator != std::string::npos)
		{
			std::string base64_sig = signature_part.substr(0, sig_separator); // from [ to ]

			unsigned char buf[512] = { 0 };
			sprintf_s((char*)buf, 512, base64_sig.c_str());
			uint32_t olen = 0;
			if (mbedtls_base64_decode(signature, 512, &olen, buf, base64_sig.length()) != 0)
			{
				if (VERBOSE == 1)
					printf("Base64 Decode of Signature on root-line\n");
				file.close();
				return false;
			}

			ret = mbedtls_pk_verify(&logs_cert->pk, MBEDTLS_MD_SHA256, hash, 32, signature, olen);
			if (ret != 0)
			{
				if (VERBOSE == 1)
					printf("Signature mismatch on root-line\n");
				file.close();
				return false;
			}
		}
		else
		{
			if (VERBOSE == 1)
				printf("Invalid format 3 on root-line\n");
			file.close();
			return false;
		}
	}

	*/

	time_t theTime = time(NULL);
	struct tm aTime;
	localtime_s(&aTime, &theTime);

	// Previous hash = 0
	// For y=root_year ; d<=current_year
	// 1. Check if folder exists (skip if not)
	// 2. Compute logsVerifyYear for each year folder
	// 3. Previous hash will now be equal to the last hash of the processed year
	uint8_t prev_hash[32] = { 0 };
	memcpy(prev_hash, hash_init, 32);
	for (int y = start_year; y <= 1900+aTime.tm_year; y++)
	{
		struct stat s;
		sprintf_s(readPath, 256, "./logchain/%d", y);

		if ((stat(readPath, &s) != 0) || !(s.st_mode & S_IFDIR))
		{
			//printf("Skipping %s because it does not exist.\n", readPath);
			continue; // file doesn't exist
		}

		bool r = logsVerifyYear(y, &prev_hash[0], CK_TRUE);
		if (r == false)
		{
			if (VERBOSE == 1)
				printf("\nError verifying year %d\n", y);
			return false;
		}
	}

	// Verify that the last line counters match the internal counters (receive counters from parameters)
	// Remove }
	// Remove embedded hash
	// Remove |
	// Subtract 10+1+10
	// We've got the position where the counters start
	// Remove spaces and replace , with space
	// Use stringstream to take out the counters
	// Compare

	// Extract message and compute hash
	// First find } and retrieve the message
	std::string counters = lastMessage.substr(lastMessage.length()-1-64-1-21, 21);
	counters.erase(10, 1);

	std::stringstream s(counters);
	int c1, c2;
	s >> c1 >> c2;

	if (c1 != counter1 || c2 != counter2)
	{
		if (VERBOSE == 1)
			printf("Last counter does not match internal counter.\n");
		return false;
	}

	if (VERBOSE)
		printf("Chain verified successfully.\n");
	return true;
}

bool HSM::logsGetCounter(CK_ULONG_PTR lNumber1, CK_ULONG_PTR lNumber2)
{
	// Exec command 
	if (!execCmd("LOGS_COUNTERS"))
		return false;

	if (!processResult())
		return false;

	// Wait for counters
	if (VERBOSE == 1)
		printf("\n\tReceiving counters...");
	memset(buffer, 0, sizeof(buffer));
	int r = comm->receive(&buffer[0], 4096);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK.\n");

	// Counters come in format: %d %d so we can use a stringstream to do it
	std::stringstream s((char*)buffer);
	s >> *lNumber1 >> *lNumber2;

	return true;
}

bool HSM::execCmd(char * pCmd)
{
	if (strlen(pCmd) > 64)
	{
		if (VERBOSE == 1)
			printf("\nERROR: Command length > 64B\n");
		return false;
	}

	comm->reqCommand();
	if (VERBOSE == 1)
		printf("%s...", pCmd);
	int r = comm->send((uint8_t*)pCmd, strlen((char*)pCmd));
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	// Expect CONTINUE, otherwise we have an error
	uint8_t response[256] = { 0 };
	memset(response, 0, sizeof(response));
	r = comm->receive(&response[0], 256);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}
	
	if (strcmp((char*)response, "CONTINUE") != 0)
	{
		if (VERBOSE == 1)
			printf("\nDEVICE ERROR [1]: %s\n", response);

		if (strcmp((char*)response, "ERROR_NEW_TIME") == 0)
		{
			if (!sendTime())
			{
				if (VERBOSE == 1)
					printf("\nUPDATE TIME FAILED\n");
				return false;
			}

			comm->reqCommand();
			if (VERBOSE == 1)
				printf("%s...", pCmd);
			int r = comm->send((uint8_t*)pCmd, strlen((char*)pCmd));
			if (r <= 0)
			{
				if (VERBOSE == 1)
					printf("UART ERROR: 0x%02X\n", r);
				return false;
			}

			// Expect CONTINUE, otherwise we have an error
			memset(response, 0, sizeof(response));
			r = comm->receive(&response[0], 256);
			if (r <= 0)
			{
				if (VERBOSE == 1)
					printf("UART ERROR: 0x%02X\n", r);
				return false;
			}

			if (strcmp((char*)response, "CONTINUE") != 0)
			{
				// Fail completely
				if (VERBOSE == 1)
					printf("\nDEVICE ERROR [2]: %s\n", response);
				return false;
			}
		}
		else
		{
			// Tamper detection error most likely
			if (VERBOSE == 1)
				printf("\nDEVICE TAMPER ERROR [3]: %s\n", response);
			return false;
		}
	}

	return true;
}

bool HSM::processResult()
{
	uint8_t res[4096] = { 0 };

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	int r = comm->receive(&res[0], 4096);
	if (r <= 0)
	{
		if (VERBOSE == 1)
			printf("UART ERROR: 0x%02X\n", r);
		return false;
	}

	if (VERBOSE == 1)
		printf("RES: %s\n", res);
	if (strcmp((char*)res, "SUCCESS") != 0)
	{
		// TODO: I need to modify all error messages in the device code so that we can properly process them here

		if (VERBOSE == 1)
			printf("\nERROR: %s\n", res);
		return false;
	}

	if (VERBOSE == 1)
		printf("OK\n");

	return true;
}


// The functions below are not mine and were retrieved from stack overflow

// read_directory()
//   Return an ASCII-sorted vector of filename entries in a given directory.
//   If no path is specified, the current working directory is used.
//
//   Always check the value of the global 'errno' variable after using this
//   function to see if anything went wrong. (It will be zero if all is well.)
//
std::vector<std::string> HSM::read_directory(const std::string& path = std::string(), bool folders = true)
{
	std::vector <std::string> result;
	dirent* de;
	DIR* dp;
	errno = 0;
	dp = opendir(path.empty() ? "." : path.c_str());
	if (dp)
	{
		while (true)
		{
			errno = 0;
			de = readdir(dp);
			if (de == NULL) break;

			char p[256] = { 0 };
			sprintf_s(p, 256, "%s/%s", path.c_str(), de->d_name);

			struct stat entrystat;
			int r = stat(p, &entrystat);
			if (r == 0 && strcmp(de->d_name, "..") != 0 && strcmp(de->d_name, ".") != 0)
			{
				// Folders only?
				if (folders == true && S_ISDIR(entrystat.st_mode))
				{
					result.push_back(std::string(de->d_name));
				}
				// Files only?
				else if (folders == false && S_ISREG(entrystat.st_mode))
				{
					result.push_back(std::string(de->d_name));
				}
			}
		}
		closedir(dp);

		// sort using a custom function object
		struct {
			bool operator()(std::string a, std::string b) const
			{
				int vA = atoi(a.c_str());
				int vB = atoi(b.c_str());

				return vA < vB;
			}
		} sortByNumber;

		std::sort(result.begin(), result.end(), sortByNumber);
	}
	return result;
}

std::string HSM::getLastLine(std::ifstream& in)
{
	std::string line;
	while (in >> std::ws && std::getline(in, line)) // skip empty lines
		;

	return line;
}

///// Source: https://stackoverflow.com/questions/17261798/converting-a-hex-string-to-a-byte-array
int HSM::char2int(char input)
{
	if (input >= '0' && input <= '9')
		return input - '0';
	if (input >= 'A' && input <= 'F')
		return input - 'A' + 10;
	if (input >= 'a' && input <= 'f')
		return input - 'a' + 10;
	throw std::invalid_argument("Invalid input string");
}

// This function assumes src to be a zero terminated sanitized string with
// an even number of [0-9a-f] characters, and target to be sufficiently large
// len -> len of source
void HSM::hex2bin(const char* src, char* target, int len)
{
	while (len > 0)
	{
		*(target++) = char2int(*src) * 16 + char2int(src[1]);
		src += 2;

		len -= 2;
	}
}

void HSM::strcpy_bp(void * destination, const char * source, size_t dest_size)
{
	int c = strlen(source) > dest_size ? dest_size : strlen(source);

	memcpy((char *)destination, source, c);
	dest_size -= c;
	memset((char *)destination + c, ' ', dest_size);
}


/***********************/
/**Simple Time Service**/
/***********************/
#define STS_PRIVATE_KEY "-----BEGIN EC PRIVATE KEY-----\nMIGlAgEBBDEA7NnOz61bZhEdNmeHO7DrJV+Z06B+2iIsboHKZgvf8GVDkgK1X/aR\nKvbXlNCtY+/ooAcGBSuBBAAioWQDYgAELROom/+aALEPQp6puthlq/D1x3MmW0An\nqU52N0qxwvjj0tU9F7bDNkwH7WbY7mvDlgK0pdZkx+IcIOIXyJYI0dZf5ZHyj9ei\nrwDY+JYXywh7bY7wdFXoakIooEeobVWy\n-----END EC PRIVATE KEY-----\n"
#define STS_PUBLIC_KEY "-----BEGIN PUBLIC KEY-----\nMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAELROom/+aALEPQp6puthlq/D1x3MmW0An\nqU52N0qxwvjj0tU9F7bDNkwH7WbY7mvDlgK0pdZkx+IcIOIXyJYI0dZf5ZHyj9ei\nrwDY+JYXywh7bY7wdFXoakIooEeobVWy\n-----END PUBLIC KEY-----\n"

int STS_requestTime(uint8_t nonce[64], uint8_t * response)
{
	uint32_t time = STS_getTime();

	uint8_t hash[32] = { 0 };
	uint8_t in[68]; // 64 nonce | 4B timestamp

	// nonce
	memcpy(in, nonce, 64);

	// timestamp
	in[64] = time & 0x000000FF;
	in[65] = (time & 0x0000FF00) >> 8;
	in[66] = (time & 0x00FF0000) >> 16;
	in[67] = (time & 0xFF000000) >> 24;

	// hash of concatenation
	mbedtls_sha256(in, 68, hash, 0);

	mbedtls_pk_context ctx;
	mbedtls_entropy_context entropy;
	mbedtls_ctr_drbg_context ctr_drbg;
	const char *pers = "ecdsa";

	mbedtls_pk_init(&ctx);
	mbedtls_ctr_drbg_init(&ctr_drbg);
	mbedtls_entropy_init(&entropy);

	int ret = 0;

	if ((ret = mbedtls_ctr_drbg_seed(&ctr_drbg, mbedtls_entropy_func, &entropy,
		(const unsigned char *)pers,
		strlen(pers))) != 0)
	{
		return -1;
	}

	// Parse private key
	ret = mbedtls_pk_parse_key(&ctx, (uint8_t*)STS_PRIVATE_KEY, strlen(STS_PRIVATE_KEY) + 1, NULL, 0);
	if (ret != 0)
	{
		mbedtls_pk_free(&ctx);
		mbedtls_ctr_drbg_free(&ctr_drbg);
		mbedtls_entropy_free(&entropy);
		return -2;
	}

	uint8_t signature[128] = { 0 };
	uint32_t signature_len = 0;
	if ((ret = mbedtls_pk_sign(&ctx, MBEDTLS_MD_SHA256, hash, 32, signature, &signature_len,
		mbedtls_ctr_drbg_random, &ctr_drbg)) != 0)
	{
		mbedtls_pk_free(&ctx);
		mbedtls_ctr_drbg_free(&ctr_drbg);
		mbedtls_entropy_free(&entropy);
		return -3;
	}

	/*mbedtls_pk_context ctxv;
	mbedtls_pk_init(&ctxv);

	// Parse public key
	ret = mbedtls_pk_parse_public_key(&ctxv, (uint8_t*)STS_PUBLIC_KEY, strlen(STS_PUBLIC_KEY) + 1);
	if (ret != 0)
	{
	mbedtls_pk_free(&ctx);
	mbedtls_pk_free(&ctxv);
	mbedtls_ctr_drbg_free(&ctr_drbg);
	mbedtls_entropy_free(&entropy);
	return -4;
	}

	//Verify signature
	ret = mbedtls_pk_verify(&ctxv, MBEDTLS_MD_SHA256, hash, 32, signature, signature_len);
	if (ret != 0)
	{
	mbedtls_pk_free(&ctx);
	mbedtls_pk_free(&ctxv);
	mbedtls_ctr_drbg_free(&ctr_drbg);
	mbedtls_entropy_free(&entropy);
	return -5;
	}
	mbedtls_pk_free(&ctxv);*/

	mbedtls_pk_free(&ctx);
	mbedtls_ctr_drbg_free(&ctr_drbg);
	mbedtls_entropy_free(&entropy);

	memcpy(response, in, 68);
	memcpy(&response[68], signature, signature_len);

	return 64 + 4 + signature_len; // nonce + timestamp + sig
}

uint32_t STS_getTime()
{
	// Execute sts.bat
	char buffer[256];

	// Get the current working directory:   
	if ((_getcwd(buffer, 256)) == NULL)
		return 0;

	if (strcat_s(buffer, 256, "\\sts.bat\"") != 0)
		return 0;

	STARTUPINFO si;
	PROCESS_INFORMATION pi;

	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);
	ZeroMemory(&pi, sizeof(pi));

	wchar_t cmdline[512] = L"cmd.exe /C \"";

	size_t origsize = strlen(buffer) + 1;
	size_t convertedChars = 0;
	wchar_t wcstring[1024];
	mbstowcs_s(&convertedChars, wcstring, origsize, buffer, _TRUNCATE);
	wcscat_s(wcstring, L" (wchar_t *)");

	wcscat_s(cmdline, wcstring);

	// Start the child process. 
	if (!CreateProcess(NULL,   // No module name (use command line)
		cmdline,        // Command line
		NULL,           // Process handle not inheritable
		NULL,           // Thread handle not inheritable
		FALSE,          // Set handle inheritance to FALSE
		0,              // No creation flags
		NULL,           // Use parent's environment block
		NULL,           // Use parent's starting directory 
		&si,            // Pointer to STARTUPINFO structure
		&pi)           // Pointer to PROCESS_INFORMATION structure
		)
	{
		printf("CreateProcess failed (%d).\n", GetLastError());
		return 0;
	}

	// Wait until child process exits.
	WaitForSingleObject(pi.hProcess, INFINITE);

	// Close process and thread handles. 
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);

	// Open ./verify.txt
	// Check if file exists when opening it
	std::ifstream file("./timestamp/verify.txt");
	if (!file)
	{
		printf("Simple Time Service: could not get timestamp [1].");
		return false;
	}

	// Read line by line until we find "Time stamp:"
	uint32_t time = 0;
	std::string line;
	std::string message_head;
	std::string message_content;
	while (getline(file, line))
	{
		unsigned sep = line.find(':');
		if (sep != std::string::npos)
		{
			message_head = line.substr(0, sep + 1);

			// Do we have 'Time stamp:' in the head?
			if (message_head.compare("Time stamp:") == 0)
			{
				// We've got ourselves the time stamp line
				message_content = line.substr(sep + 2, line.length() - (sep + 2));

				// Convert to UNIX timestamp
				std::tm t = {};
				std::istringstream ss(message_content);
				ss >> std::get_time(&t, "%b %d %H:%M:%S %Y");
				if (ss.fail()) {
					std::cout << "Parse failed\n";
				}
				else {
					std::cout << std::put_time(&t, "%c %Z") << '\n';
				}

				std::time_t result = std::mktime(&t) + 60*60; // TODO: maybe try to convert GMT to our timezone (which is +1 but could be anything else)
				std::cout << result << " seconds since the Epoch\n";

				time = (uint32_t)result;

				break;
			}
		}
		else
		{
			// Not our line for sure
		}
	}

	file.close();

	return time;
}

