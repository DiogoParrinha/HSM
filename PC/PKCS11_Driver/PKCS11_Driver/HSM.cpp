#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <stdbool.h>
#include <stdint.h>

#include <windows.h>
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
	// Not logged in? Not admin? (only the admin can generate a key pair)
	if (!loggedIn || authID != 0)
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
	/*sprintf_s((char*)buffer, sizeof(buffer), "rm -rf inc/data/test/lol.txt");
	comm->send(buffer, strlen((char*)buffer));*/
	comm->send(pMessage, lMessage);
	if (VERBOSE == 1)
		printf("OK\n");

	// TODO: send current day hash + signature

	// TODO: send current month hash + signature

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

	// TODO: Wait for current day hash + signature

	// TODO: Wait for current month hash + signature

	// Base64 encode the log signature
	// Base64 requires 4/3 of the original size so we simply double it to avoid dynamic allocation
	uint8_t base64[512];
	uint32_t olen = 0;
	if (mbedtls_base64_encode(base64, 512, &olen, signature, sig_len) != 0)
	{
		return false;
	}

	// Append logged message + signature to file
	std::ofstream outfile;
	outfile.open("log.txt", std::ios_base::app);
	outfile << buffer << " [";
	outfile.write((char*)base64, olen);
	outfile << "]" << std::endl;
	outfile.close();
	if (VERBOSE == 1)
		printf("OK.\n");

	// TODO: replace current day hash + signature

	// TODO: replace current month hash + signature

	endTimer();

	return true;
}

bool HSM::logsGet(CK_ULONG lNumber, CK_UTF8CHAR_PTR pLog, CK_ULONG_PTR logSize)
{
	return true;
}

bool HSM::logsGetHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize)
{
	return true;
}

bool HSM::logsGetDayHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize)
{
	return true;
}

bool HSM::logsGetMonthHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize)
{
	return true;
}

bool HSM::logsVerifyDay(CK_ULONG lNumber)
{
	return true;
}

bool HSM::logsVerify(CK_ULONG lNumber)
{
	return true;
}

bool HSM::logsVerifyDayHash(CK_ULONG lNumber)
{
	return true;
}

bool HSM::logsVerifyMonthHash(CK_ULONG lNumber)
{
	return true;
}

bool HSM::logsGetCounter(CK_ULONG_PTR lNumber1, CK_ULONG_PTR lNumber2)
{
	return true;
}