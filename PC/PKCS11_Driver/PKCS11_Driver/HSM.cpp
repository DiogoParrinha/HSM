#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <stdbool.h>
#include <stdint.h>

#include <windows.h>
#include <string>
#include <vector>
#include <iostream>
#include <fstream>

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

#include "HSM.h"
#include "UART.h"

#include <fstream>

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

HSM::HSM()
{
	comm = new UART();

	loggedIn = false;
	isAdmin = false;
	
	maxSessions = HSM_MAX_SESSIONS;
	openSessions = 0;
	connected = false;

	memset(serialNumber, 0, 128);
	memcpy(serialNumber, HSM_SERIAL_NUMBER, strlen(HSM_SERIAL_NUMBER));
}

HSM::~HSM()
{
	comm->disconnect();
}

void HSM::startTimer()
{
	/*
#ifdef _WIN32
	elapsedTime = 0.0f;
	frequency.HighPart = 0;
	frequency.LowPart = 0;
	t1.HighPart = 0;
	t1.LowPart = 0;
	t2.HighPart = 0;
	t2.LowPart = 0;

	// get ticks per second
	QueryPerformanceFrequency(&frequency);
	// start timer
	QueryPerformanceCounter(&t1);
#endif
	*/
}

void HSM::endTimer()
{
	/*
#ifdef _WIN32
	// stop timer
	QueryPerformanceCounter(&t2);
	// compute and print the elapsed time in millisec
	elapsedTime = (t2.QuadPart - t1.QuadPart) * 1000.0 / frequency.QuadPart;
	if(VERBOSE == 1)
		printf("%lf ms.\n", elapsedTime);
#endif
	*/
}

bool HSM::checkDevice()
{
	return comm->checkDevice();
}

bool HSM::sendData(CK_BYTE_PTR pData, CK_ULONG ulDataLen)
{
	startTimer();

	if (VERBOSE == 1)
		printf("DVC_TEST...");

	comm->reqCommand();
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "DVC_TEST");
	comm->send(buffer, strlen((char*)buffer));

	// Now it expects:
	// 32B_HASH
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	comm->send(pData, ulDataLen);
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 512);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		printf("\nError logging in: %s\n", buffer);
		return false;
	}

	endTimer();

	return true;
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
	startTimer();
	if (VERBOSE == 1)
		printf("DVC_CHECK...");
	if (!checkDevice())
	{
		return CK_FALSE;
	}
	if (VERBOSE == 1)
		printf("OK\n");
	endTimer();

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

	startTimer();

	comm->reqCommand();

	if (VERBOSE == 1)
		printf("SESS_START...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "SESS_START");
	comm->send(buffer, strlen((char*)buffer));
	
	// Initiate secure comm
	int ret;
	mbedtls_ecdh_context ctx_cli;
	mbedtls_entropy_context entropy;
	mbedtls_ctr_drbg_context ctr_drbg;
	unsigned char cli_to_srv[48], srv_to_cli[48];
	const char pers[] = "ecdh";

	mbedtls_aes_context aes_ctx;
	mbedtls_md_context_t sha_ctx;

	mbedtls_aes_init(&aes_ctx);
	mbedtls_md_init(&sha_ctx);

	unsigned char aes_output[128];
	memset(aes_output, 0, 128);

	mbedtls_ecdh_init(&ctx_cli);
	mbedtls_ctr_drbg_init(&ctr_drbg);

	//Initialize random number generation
	mbedtls_entropy_init(&entropy);
	if ((ret = mbedtls_ctr_drbg_seed(&ctr_drbg, mbedtls_entropy_func, &entropy,
		(const unsigned char *)pers,
		sizeof pers)) != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_ctr_drbg_seed returned %d\n", ret);
		return 2;
	}

	//Client: inialize context and generate keypair
	ret = mbedtls_ecp_group_load(&ctx_cli.grp, MBEDTLS_ECP_DP_SECP384R1);
	//ret = mbedtls_ecp_group_load(&ctx_cli.grp, MBEDTLS_ECP_DP_SECP192R1);
	if (ret != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_ecp_group_load returned %d\n", ret);
		return 3;
	}

	ret = mbedtls_ecdh_gen_public(&ctx_cli.grp, &ctx_cli.d, &ctx_cli.Q, mbedtls_ctr_drbg_random, &ctr_drbg);
	if (ret != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_ecdh_gen_public returned %d\n", ret);
		return 4;
	}

	ret = mbedtls_mpi_write_binary(&ctx_cli.Q.X, cli_to_srv, 48);
	if (ret != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_mpi_write_binary returned %d\n", ret);
		return 5;
	}

	// wait for "OK" because the device takes longer to do this than the computer
	comm->waitOK();

	// send 48B public key
	comm->send(cli_to_srv, 48);

	// get 48B public key
	comm->receive(&srv_to_cli[0], 48);

	ret = mbedtls_mpi_read_binary(&ctx_cli.Qp.X, srv_to_cli, 48);
	if (ret != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_mpi_read_binary returned %d\n", ret);
		return 7;
	}

	ret = mbedtls_mpi_write_binary(&ctx_cli.Q.Y, cli_to_srv, 48);
	if (ret != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_mpi_write_binary returned %d\n", ret);
		return 5;
	}

	// wait for "OK" because the device takes longer to do this than the computer
	comm->waitOK();

	// send 48B public key
	comm->send(cli_to_srv, 48);

	// get 48B public key
	comm->receive(&srv_to_cli[0], 48);

	ret = mbedtls_mpi_read_binary(&ctx_cli.Qp.Y, srv_to_cli, 48);
	if (ret != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_mpi_read_binary returned %d\n", ret);
		return 7;
	}

	// Client: read peer's key and generate shared secret
	ret = mbedtls_mpi_lset(&ctx_cli.Qp.Z, 1);
	if (ret != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_mpi_lset returned %d\n", ret);
		return 6;
	}

	size_t len = 0;
	unsigned char buffer[BUFSIZE];

	if ((ret = mbedtls_ecdh_calc_secret(&ctx_cli,
		&len,
		buffer,
		BUFSIZE,
		mbedtls_ctr_drbg_random, &ctr_drbg)) != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_ecdh_calc_secret returned %d\n", ret);
		return 8;
	}

	unsigned char key[32] = { 0 };
	mbedtls_sha256(buffer, len, key, 0);
	
	// Set AES key
	comm->setKey(key, true);

	// Receive challenge
	uint8_t challenge[16] = { 0 };
	comm->receive(challenge, 16);

	///// Send modified challenge encrypted with session key

	uint8_t mod_challenge[16];
	for (int a = 0; a < 16; a++)
	{
		mod_challenge[a] = challenge[a] % 6; // plaintext[a] mod 6 for now...
	}

	comm->send(mod_challenge, 16);

	mbedtls_ecdh_free(&ctx_cli);
	mbedtls_ctr_drbg_free(&ctr_drbg);
	mbedtls_entropy_free(&entropy);

	// Send TIME_SEND and time
	sendTime();

	comm->useTime(false);

	// increase open sessions
	openSessions++;

	if (VERBOSE == 1)
		printf("OK.\n");

	endTimer();

	return 0;
}

bool HSM::endSession()
{
	startTimer();

	comm->reqCommand();

	if (VERBOSE == 1)
		printf("SESS_END command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "SESS_END");
	comm->send(buffer, strlen((char*)buffer));
	if (VERBOSE == 1)
		printf("OK.\n");

	uint8_t data[32] = { 0 };
	comm->setKey(data, false);
	comm->useTime(false);

	openSessions--;

	endTimer();

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
	if (VERBOSE == 1)
		printf("\n\tTIME_SEND...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "TIME_SEND");
	comm->send(buffer, strlen((char*)buffer));

	// Now it expects a timestamp
	if (VERBOSE == 1)
		printf("\n\t\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	uint32_t t = (uint32_t)time(NULL);
	if (VERBOSE == 1)
		printf("OK.\n");

	// Place the size into an array
	unsigned char timestamp[4];
	timestamp[0] = t & 0x000000FF;
	timestamp[1] = (t & 0x0000FF00) >> 8;
	timestamp[2] = (t & 0x00FF0000) >> 16;
	timestamp[3] = (t & 0xFF000000) >> 24;
	comm->send(timestamp, 4);

	if (VERBOSE == 1)
		printf("\tOK.\n");

	return true;
}

int HSM::initDevice(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen)
{
	startTimer();

	if (ulPinLen != 32) // 32B for PIN
	{
		return 1;
	}
	
	comm->reqCommand();

	if (VERBOSE == 1)
		printf("DVC_INIT...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "DVC_INIT");
	comm->send(buffer, strlen((char*)buffer));

	// Now it expects:
	// PIN
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy(buffer, pPin, 32);
	comm->send(buffer, 32);
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 512);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0 && strcmp((char*)buffer, "ALREADY_INIT") != 0)
	{
		printf("\nError initing in: %s\n", buffer);
		return 2;
	}

	if (VERBOSE == 1)
		printf("OK.\n");
	
	endTimer();

	return 0;
}

int HSM::login(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_USER_TYPE userType)
{
	startTimer();

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

	if (VERBOSE == 1)
		printf("SESS_LOGIN...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "SESS_LOGIN");
	comm->send(buffer, strlen((char*)buffer));

	// Now it expects:
	// PIN | ID
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy(buffer, pPin, 32);
	buffer[32] = pPin[32]; // ID
	comm->send(buffer, 33);
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 512);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if(strcmp((char*)buffer, "SUCCESS") != 0)
	{
		printf("\nError logging in: %s\n", buffer);
		return 3;
	}

	if (VERBOSE == 1)
		printf("OK.\n");

	isAdmin = false;
	if (userType == CKU_SO)
		isAdmin = true;

	authID = pPin[32];
	loggedIn = true;

	endTimer();

	return 0;
}

int HSM::logout()
{
	// Not logged in?
	if (!loggedIn)
	{
		return 1;
	}

	startTimer();

	comm->reqCommand();

	if (VERBOSE == 1)
		printf("SESS_LOGOUT...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "SESS_LOGOUT");
	comm->send(buffer, strlen((char*)buffer));

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 512);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		printf("\nError logging out: %s\n", buffer);
		return 3;
	}

	if (VERBOSE == 1)
		printf("OK.\n");

	authID = 0;
	isAdmin = false;
	loggedIn = false;

	endTimer();

	return 0;
}

bool HSM::signData(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen)
{
	// Not logged in?
	if (!loggedIn)
	{
		return false;
	}

	startTimer();

	if (VERBOSE == 1)
		printf("DTSN_SIGN...");

	// Calculate SHA-256 of pData
	unsigned char digest[32] = { 0 };
	mbedtls_sha256(pData, ulDataLen, &digest[0], 0);

	comm->reqCommand();
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "DTSN_SIGN");
	comm->send(buffer, strlen((char*)buffer));

	// Now it expects:
	// 32B_HASH
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	comm->send(digest, 32);
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SIGNATURE'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 512);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		printf("\nError: %s\n", buffer);
		return false;
	}

	// Wait for actual signature
	uint8_t tempSignature[256];
	if (VERBOSE == 1)
		printf("\n\tReceiving actual signature...");
	memset(pSignature, 0, 256);
	*pulSignatureLen = comm->receive(tempSignature, 256);
	if (VERBOSE == 1)
		printf("OK: %d\n", *pulSignatureLen);

	// the function calling this one should make sure the buffer has space for 256B so we don't worry about that here
	memset(pSignature, 0, *pulSignatureLen);
	memcpy(pSignature, tempSignature, *pulSignatureLen);

	if (VERBOSE == 1)
		printf("OK.\n");

	endTimer();

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
	
	startTimer();

	// Calculate SHA-256 of data
	unsigned char digest[32] = { 0 };
	if (loggedIn)
		mbedtls_sha256(pData, ulDataLen, digest, 0); // message = everything
	else
		mbedtls_sha256(&pData[1], ulDataLen, digest, 0); // message starts at index 1

	comm->reqCommand();
	if (VERBOSE == 1)
		printf("DTSN_VERIFY...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "DTSN_VERIFY");
	comm->send(buffer, strlen((char*)buffer));

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
	comm->send(buffer, 32+1);
	if (VERBOSE == 1)
		printf("OK\n");

	// Send signature
	if (VERBOSE == 1)
		printf("\n\tSending SIGNATURE...");
	comm->send(pSignature, pulSignatureLen);
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for response
	if (VERBOSE == 1)
		printf("\n\tReceiving response...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		return false;
	}

	if (VERBOSE == 1)
		printf("OK.\n");

	endTimer();

	return true;
}

bool HSM::generateKeyPair(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE_PTR privateKey, CK_OBJECT_HANDLE_PTR publicKey)
{
	// Not logged in? admin? (only users can generate and extract a key pair)
	if (!loggedIn || authID == 0)
	{
		return false;
	}

	startTimer();

	comm->reqCommand();
	if (VERBOSE == 1)
		printf("USER_GENKEYS...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "USER_GENKEYS");
	comm->send(buffer, strlen((char*)buffer));

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		return false;
	}

	int r = 0;

	// Wait for both keys
	uint8_t pubBuffer[512] = { 0 };
	if ((r = comm->receive(&pubBuffer[0], 512)) <= 0)
		return false;
	uint8_t priBuffer[512] = { 0 };
	if ((r = comm->receive(&priBuffer[0], 512)) <= 0)
		return false;

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

	endTimer();

	return true;
}

bool HSM::getCertificate(CK_BYTE uid, CK_UTF8CHAR_PTR* certificate, CK_ULONG_PTR bufSize)
{
	if (uid <= 0)
		return false;

	startTimer();

	comm->reqCommand();
	if (VERBOSE == 1)
		printf("USER_CERT...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "USER_CERT");
	comm->send(buffer, strlen((char*)buffer));

	// Now it expects:
	// 1B ID
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	buffer[0] = uid;
	comm->send(buffer, 1);
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		return false;
	}

	// Wait for actual certificate
	if (VERBOSE == 1)
		printf("\n\tReceiving certificate content...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK.\n");

	mbedtls_x509_crt crt;
	mbedtls_x509_crt_init(&crt);
	int r = mbedtls_x509_crt_parse(&crt, buffer, strlen((char*)buffer)+1);
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

	endTimer();

	return true;
}

bool HSM::genCertificate(CK_ATTRIBUTE_PTR publicKeyTemplate, CK_ULONG ulCount, CK_UTF8CHAR_PTR publicKey, CK_UTF8CHAR_PTR certificate, CK_ULONG_PTR bufSize)
{
	if (!loggedIn || !isAdmin)
		return false;

	startTimer();

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

	comm->reqCommand();
	if (VERBOSE == 1)
		printf("CRT_REQUEST command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "CRT_REQUEST");
	comm->send(buffer, strlen((char*)buffer));

	// Now it expects:
	// subject name + \0 or 0 (should be the same thing) | 1B for key usage
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy(buffer, subjectName, strlen((char*)subjectName));
	buffer[strlen((char*)subjectName)] = '\0';
	buffer[strlen((char*)subjectName) + 1] = keyUsageArray[0];
	buffer[strlen((char*)subjectName) + 2] = keyUsageArray[1];
	comm->send(buffer, strlen((char*)subjectName) + 1 + 2); // +1 because of \0 at the end of subject name and +2 because of key usage
	if (VERBOSE == 1)
		printf("OK\n");

	// Send public key
	if (VERBOSE == 1)
		printf("\n\tSending public key...");
	memset(buffer, 0, sizeof(buffer));
	memcpy(buffer, publicKey, strlen((char*)publicKey)*sizeof(CK_UTF8CHAR));
	comm->send(buffer, strlen((char*)buffer)+1);
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		mbedtls_pk_free(&ctx_pub);
		return false;
	}

	// Wait for actual certificate
	if (VERBOSE == 1)
		printf("\n\tReceiving certificate content...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK.\n");

	if (VERBOSE == 1)
		printf("OK.\n");

	// copy certificate
	memcpy(certificate, buffer, strlen((char*)buffer) + 1);

	mbedtls_pk_free(&ctx_pub);

	endTimer();

	return true;
}

bool HSM::addUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_BYTE_PTR uID)
{
	if (!loggedIn || !isAdmin)
		return false;

	if (ulPinLen != 32)
		return false;

	startTimer();

	comm->reqCommand();
	if (VERBOSE == 1)
		printf("USER_NEW...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "USER_NEW");
	comm->send(buffer, strlen((char*)buffer));

	// Now it expects:
	// USER_PIN
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy((char*)buffer, pPin, ulPinLen*sizeof(CK_UTF8CHAR));
	comm->send(buffer, strlen((char*)buffer));
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		return false;
	}

	// Wait for ID (1B)
	if (VERBOSE == 1)
		printf("\n\tReceiving ID...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK: %d\n", buffer[0]);
	if (buffer[0] <= 0 || buffer[0] > 255)
		return false;

	if (VERBOSE == 1)
		printf("OK.\n");

	*uID = buffer[0];

	endTimer();

	return true;
}

bool HSM::modifyUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen)
{
	if (!loggedIn || isAdmin) // admin cannot modify PINs
		return false;

	if (ulPinLen != 32)
		return false;

	startTimer();

	comm->reqCommand();
	if (VERBOSE == 1)
		printf("USER_MODIFY...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "USER_MODIFY");
	comm->send(buffer, strlen((char*)buffer));

	// Now it expects:
	// USER_PIN
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy((char*)buffer, pPin, ulPinLen * sizeof(CK_UTF8CHAR));
	comm->send(buffer, strlen((char*)buffer));
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		return false;
	}

	if (VERBOSE == 1)
		printf("OK.\n");

	endTimer();

	return true;
}

bool HSM::deleteUser(CK_BYTE uID)
{
	if (!loggedIn || !isAdmin)
		return false;

	if (uID <= 0 || uID > 255)
		return false;

	startTimer();

	comm->reqCommand();
	if (VERBOSE == 1)
		printf("USER_DELETE...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "USER_DELETE");
	comm->send(buffer, strlen((char*)buffer));

	// Now it expects:
	// USER_ID
	if (VERBOSE == 1)
		printf("\n\tSending DATA...");
	memset(buffer, 0, sizeof(buffer));
	buffer[0] = uID;
	comm->send(buffer, 1);
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for 'SUCCESS'
	if (VERBOSE == 1)
		printf("\n\tReceiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		return false;
	}

	if (VERBOSE == 1)
		printf("OK.\n");

	endTimer();

	return true;
}

bool HSM::logsAdd(CK_UTF8CHAR_PTR pMessage, CK_ULONG lMessage)
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
			printf("Directory './logchain' was successfully created\n");
		}
		else
			printf("Problem creating directory './logchain'\n");
	}
	else
		closedir(dir);

	if ((dir = opendir("./logchain")) != NULL)
	{
		closedir(dir);

		// Find most recent year
		std::vector<std::string> years_folders = Device::read_directory("./logchain", true);
		if (!years_folders.empty())
		{
			std::string year_folder = years_folders.back();

			sprintf_s(readPath, 256, "./logchain/%s", year_folder.c_str());

			// Find most recent month
			std::vector<std::string> months_folders = Device::read_directory(readPath, true);
			if (!months_folders.empty())
			{
				std::string month_folder = months_folders.back();

				sprintf_s(readPath, 256, "%s/%s", readPath, month_folder.c_str());

				// Find most recent day
				std::vector<std::string> days_files = Device::read_directory(readPath, false);
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
	uint8_t zero[256] = { 0 };
	if (memcmp(readPath, zero, 256) != 0)
	{
		std::ifstream file(readPath);
		if (file)
		{
			std::string line = getLastLine(file);
			std::cout << line << '\n';

			// TODO: We need to do some string manipulation here to retrieve the base64 encoded hash
			// Then decode it and finally we can send it!

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
			printf("Error opening file for reading.\n");
	}

	// If there are no existing hashes, use pMessage as the Chain-Root and therefore our hash = all 0s

	startTimer();

	comm->reqCommand();
	if (VERBOSE == 1)
		printf("LOGS_ADD...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "LOGS_ADD");
	comm->send(buffer, strlen((char*)buffer));
	
	// Send message
	if (VERBOSE == 1)
		printf("\n\tSending message...");
	comm->send(pMessage, lMessage);
	if (VERBOSE == 1)
		printf("OK\n");

	// Send previous hash
	if (VERBOSE == 1)
		printf("\n\tSending previous hash...");
	comm->send(prevHash, 32);
	if (VERBOSE == 1)
		printf("OK\n");

	// Wait for response
	if (VERBOSE == 1)
		printf("\n\tReceiving response...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 4096);
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
	comm->receive(&buffer[0], 4096);
	if (VERBOSE == 1)
		printf("OK.\n");

	// Wait for hash
	uint8_t hash[32];
	if (VERBOSE == 1)
		printf("\n\tReceiving log hash...");
	memset(hash, 0, sizeof(hash));
	comm->receive(&hash[0], 32);
	if (VERBOSE == 1)
		printf("OK.\n");

	// Wait for signature
	if (VERBOSE == 1)
		printf("\n\tReceiving log signature...");
	uint8_t signature[256];
	memset(signature, 0, sizeof(signature));
	uint32_t sig_len = comm->receive(&signature[0], 256);
	if(sig_len <= 0)
	{
		return false;
	}
	if (VERBOSE == 1)
		printf("OK.\n");
	
	// Base64 encode the log hash and signature
	// Base64 requires 4/3 of the original size so we simply double it to avoid dynamic allocation
	uint8_t base64_1[512];
	uint32_t olen_1 = 0;
	if (mbedtls_base64_encode(base64_1, 512, &olen_1, hash, 32) != 0)
	{
		return false;
	}

	uint8_t base64_2[512];
	uint32_t olen_2 = 0;
	if (mbedtls_base64_encode(base64_2, 512, &olen_2, signature, sig_len) != 0)
	{
		return false;
	}

	// Depending on the date, choose which file to write to
	time_t t = time(NULL);
	struct tm now;
	localtime_s(&now, &t);

	// Do we have the year X and month Y folder inside logchain?
	char path[256];
	sprintf_s(path, 256, "./logchain/%d", now.tm_year+1900);
	if ((dir = opendir(path)) == NULL)
	{
		if (_mkdir(path) == 0)
		{
			printf("Directory '%s' was successfully created\n", path);
		}
		else
			printf("Problem creating directory '%s'\n", path);
	}
	else
		closedir(dir);

	sprintf_s(path, 256, "%s/%d", path, now.tm_mon + 1);
	if ((dir = opendir(path)) == NULL)
	{
		if (_mkdir(path) == 0)
		{
			printf("Directory '%s' was successfully created\n", path);
		}
		else
			printf("Problem creating directory '%s'\n", path);
	}
	else
		closedir(dir);

	// Append logged message + signature to file
	sprintf_s(path, 256, "%s/%d.txt", path, now.tm_mday);
	std::ofstream outfile;
	outfile.open(path, std::ios_base::app);
	outfile << buffer << " [";
	outfile.write((char*)base64_1, olen_1);
	outfile << "]";
	outfile << " [";
	outfile.write((char*)base64_2, olen_2);
	outfile << "]" << std::endl;
	outfile.close();
	if (VERBOSE == 1)
		printf("OK.\n");
	
	endTimer();

	return true;
}

bool HSM::logsVerifyDay(CK_ULONG lDay, CK_ULONG lMonth, CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash)
{
	char readPath[256] = { 0 };
	sprintf_s(readPath, 256, "./logchain/%d/%d", lYear, lMonth);

	// Get the selected file (if none, return false)
	DIR *dir;
	if ((dir = opendir(readPath)) == NULL)
	{
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
		printf("File '%s' does not exist.\n", readPath);
		return false;
	}

	// TODO: Request device logs public key
	int ret = 0;
	mbedtls_pk_context ctx;
	mbedtls_pk_init(&ctx);

	// Parse public key
	unsigned char publicKey[512] = "-----BEGIN PUBLIC KEY-----\nMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAECvRzPeCDoxu4BIQcZ8YVkmAoCytwnxHA\nNpDcy2U0qsLk/Av+S9JcLXmvrgwKCNVaqzII87H5iFheRsOdxbl0lBJ4I/raM8t5\nG/95vfumMlDmQbyBkdyJe3YxR/fYVc7L-----END PUBLIC KEY-----";
	ret = mbedtls_pk_parse_public_key(&ctx, publicKey, strlen((char*)publicKey) + 1);
	if (ret != 0)
	{
		printf("Error parsing public key.\n");
		mbedtls_pk_free(&ctx);
		return false;
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

	int l = 1;
	while (getline(file, line))
	{
		// Extract message and compute hash
		// First find } and retrieve the message
		unsigned first = line.find('}');
		if (first != std::string::npos)
		{
			message = line.substr(0, first+1);
		}
		else
		{
			printf("Invalid format 1 on line %d\n", l);
			mbedtls_pk_free(&ctx);
			return false;
		}

		memset(hash, 0, sizeof(hash));
		mbedtls_sha256((unsigned char*)message.c_str(), first+1, hash, 0);

		// Extract previous hash
		std::string embedded_hash = message.substr(message.length()-65, 64);
		char embedded_hash_char[64];
		memcpy(embedded_hash_char, embedded_hash.c_str(), 64);
		hex2bin(embedded_hash_char, (char*)hash_embedded, 64);

		// Extract hash and compare
		// Look for ] (] is an illegal base64 char so it won't appear in the middle of the hash block)
		std::string last_part = line.substr(first + 3);
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
				mbedtls_pk_free(&ctx);
				return false;
			}
		}
		else
		{
			printf("Invalid format 2 on line %d\n", l);
			mbedtls_pk_free(&ctx);
			return false;
		}

		// Compare both
		if (memcmp(hash, hash_v, 32) != 0)
		{
			printf("Hash mismatch on line %d\n", l);
			mbedtls_pk_free(&ctx);
			return false;
		}

		// Extract signature
		std::string signature_part = last_part.substr(hash_separator+3);
		unsigned sig_separator = signature_part.find(']');
		if (sig_separator != std::string::npos)
		{
			std::string base64_hash = signature_part.substr(0, sig_separator); // from [ to ]

			unsigned char buf[512] = { 0 };
			sprintf_s((char*)buf, 512, base64_hash.c_str());
			uint32_t olen = 0;
			if (mbedtls_base64_decode(signature, 512, &olen, buf, base64_hash.length()) != 0)
			{
				printf("Base64 Decode of Signature on line %d\n", l);
				mbedtls_pk_free(&ctx);
				return false;
			}

			// Verify signature
			int ret = mbedtls_pk_verify(&ctx, MBEDTLS_MD_SHA256, hash, 32, signature, olen);
			if (ret != 0)
			{
				printf("Signature mismatch on line %d\n", l);
				mbedtls_pk_free(&ctx);
				return false;
			}
		}
		else
		{
			printf("Invalid format 3 on line %d\n", l);
			mbedtls_pk_free(&ctx);
			return false;
		}
		
		// Verify that the embedded hash matches the previous line hash (skip first because we consider it the root of the file and we're only verifying the day)
		if (memcmp(hash_embedded, hash_prev, 32) != 0 && l != 1)
		{
			printf("Embedded hash mismatch on line %d\n", l);
			mbedtls_pk_free(&ctx);
			return false;
		}

		// Store current hash as previous hash
		memcpy(hash_prev, hash, 32);

		l++;
	}

	mbedtls_pk_free(&ctx);

	// Store hash_prev in prevHash (hash_prev will be the last hash when the loop finishes)
	memcpy(prevHash, hash_prev, 32);

	if(VERBOSE)
		printf("File verified successfully.\n");
	return true;
}

bool HSM::logsVerifyMonth(CK_ULONG lMonth, CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash)
{
	// Check if folder exists
	// Return false if not

	// Get max days of the month
	// If lMonth==current_month -> max days = current_day
	// Otherwise max days = 30 or 31

	// Previous hash = 0
	// For d=1 ; d<=max_days
	// 1. Check if file exists (skip if not)
	// 2. Compute logsVerifyDay for each day file
	// 3. Previous hash will now be equal to the last hash of the processed file

	return true;
}

bool HSM::logsVerifyYear(CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash)
{
	// Check if folder exists
	// Return fales if not

	// Get max months of the year
	// If lYear==current_year -> max months = current_month
	// Otherwise max months = 12

	// Previous hash = 0
	// For m=1 ; d<=max_months
	// 1. Check if folder exists (skip if not)
	// 2. Compute logsVerifyMonth for each month folder
	// 3. Previous hash will now be equal to the last hash of the processed month

	return true;
}

bool HSM::logsVerifyChain()
{
	// Get the oldest year, month and day
	// Check the first line (must be the root)
	// Return false if embedded hash != 0 OR hash doesn't match log entry OR signature cannot be verified

	// We're here so we've validated the root

	// Previous hash = 0
	// For y=root_year ; d<=current_year
	// 1. Check if folder exists (skip if not)
	// 2. Compute logsVerifyYear for each year folder
	// 3. Previous hash will now be equal to the last hash of the processed year

	return true;
}

bool HSM::logsGetCounter(CK_ULONG_PTR lNumber1, CK_ULONG_PTR lNumber2)
{
	return true;
}