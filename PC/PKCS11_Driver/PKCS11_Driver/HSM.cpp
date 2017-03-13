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

#include "HSM.h"
#include "UART.h"

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
#define HSM_MAX_SESSIONS 1
#define HSM_MAX_SLOTS 6

uint8_t buffer[4096];

HSM::HSM()
{
	comm = new UART();

	loggedIn = false;
	isAdmin = false;

	maxSlots = HSM_MAX_SLOTS;
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

bool HSM::init()
{
	// Initialize comm
	if (!comm->init())
	{
		return CK_FALSE;
	}

	// Get info
	if (!comm->checkDevice())
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
	if (i >= maxSlots) // i starts at 0
		return;

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

		strcpy_bp(s->slotInfo.slotDescription, "HSM USB COM Slot", sizeof(s->slotInfo.slotDescription));
	}
}

int HSM::startSession()
{
	// How many open sessions? If >= than HSM_MAX_SESSIONS return 1
	if (sessionLimit())
		return 1;

	comm->reqCommand();

	printf("Sending SESS_START command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "SESS_START");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	// Send CONNECTED
	comm->connect();

	// Send TIME_SEND and time
	sendTime();

	// Initiate secure comm

	int ret;
	mbedtls_ecdh_context ctx_cli, ctx_srv;
	mbedtls_entropy_context entropy;
	mbedtls_ctr_drbg_context ctr_drbg;
	unsigned char cli_to_srv[32], srv_to_cli[32];
	const char pers[] = "ecdh";

	mbedtls_aes_context aes_ctx;
	mbedtls_md_context_t sha_ctx;

	mbedtls_aes_init(&aes_ctx);
	mbedtls_md_init(&sha_ctx);

	unsigned char aes_output[128];
	memset(aes_output, 0, 128);

	mbedtls_ecdh_init(&ctx_cli);
	mbedtls_ecdh_init(&ctx_srv);
	mbedtls_ctr_drbg_init(&ctr_drbg);

	/*
	* Initialize random number generation
	*/
	mbedtls_entropy_init(&entropy);
	if ((ret = mbedtls_ctr_drbg_seed(&ctr_drbg, mbedtls_entropy_func, &entropy,
		(const unsigned char *)pers,
		sizeof pers)) != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_ctr_drbg_seed returned %d\n", ret);
		return 2;
	}

	/*
	* Client: inialize context and generate keypair
	*/
	ret = mbedtls_ecp_group_load(&ctx_cli.grp, MBEDTLS_ECP_DP_CURVE25519);
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

	ret = mbedtls_mpi_write_binary(&ctx_cli.Q.X, cli_to_srv, 32);
	if (ret != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_mpi_write_binary returned %d\n", ret);
		return 5;
	}

	// wait for "OK" because the device takes longer to do this than the computer
	comm->waitOK();

	// send 256-bits (32B) public key
	comm->send(cli_to_srv, 32);

	// get 256-bits (32B) public key
	comm->receive(&srv_to_cli[0], 32);

	/*
	* Client: read peer's key and generate shared secret
	*/
	ret = mbedtls_mpi_lset(&ctx_cli.Qp.Z, 1);
	if (ret != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_mpi_lset returned %d\n", ret);
		return 6;
	}

	ret = mbedtls_mpi_read_binary(&ctx_cli.Qp.X, srv_to_cli, 32);
	if (ret != 0)
	{
		mbedtls_printf(" failed\n  ! mbedtls_mpi_read_binary returned %d\n", ret);
		return 7;
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

	/*printf("\n");
	mbedtls_printf("\nsecret: ");
	for (size_t i = 0; i < len; i++) {
		printf("%02x", buffer[i]);
	}*/

	unsigned char key[32] = { 0 };
	mbedtls_sha256(buffer, len, key, 0);

	/*printf("\n");
	mbedtls_printf("\nkey: ");
	for (int i = 0; i < 32; i++) {
		printf("%02x", key[i]);
	}
	printf("\n");*/

	// Set AES key
	comm->setKey(key, true);

	// Receive challenge
	uint8_t challenge[16];
	comm->receive(challenge, 16);

	/*printf("\n");
	mbedtls_printf("\nchallenge: ");
	for (int i = 0; i < 16; i++) {
		printf("%02x", challenge[i]);
	}

	printf("\n");*/

	///// Send modified challenge encrypted with session key

	uint8_t mod_challenge[16];
	for (int a = 0; a < 16; a++)
	{
		mod_challenge[a] = challenge[a] % 6; // plaintext[a] mod 6 for now...
	}

	comm->send(mod_challenge, 16);

	mbedtls_ecdh_free(&ctx_srv);
	mbedtls_ecdh_free(&ctx_cli);
	mbedtls_ctr_drbg_free(&ctr_drbg);
	mbedtls_entropy_free(&entropy);

	// increase open sessions
	openSessions++;

	return 0;
}

bool HSM::endSession()
{
	comm->reqCommand();

	printf("Sending SESS_END command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "SESS_END");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	uint8_t data[32] = { 0 };
	comm->setKey(data, false);

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

	return true;
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

	printf("Sending SESS_LOGIN command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "SESS_LOGIN");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	// Now it expects:
	// PIN | ID
	printf("Sending DATA...");
	memset(buffer, 0, sizeof(buffer));
	memcpy(buffer, pPin, 32);
	buffer[32] = pPin[32]; // ID
	comm->send(buffer, 33);
	printf("OK\n");

	// Wait for 'SUCCESS'
	printf("Receiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 512);
	printf("OK: %s\n", buffer);
	if(strcmp((char*)buffer, "SUCCESS") != 0)
	{
		printf("\nError logging in: %s\n", buffer);
		return 3;
	}

	isAdmin = false;
	if (userType == CKU_SO)
		isAdmin = true;

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

	comm->reqCommand();

	printf("Sending SESS_LOGOUT command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "SESS_LOGOUT");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	// Wait for 'SUCCESS'
	printf("Receiving SUCCESS...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 512);
	printf("OK: %s\n", buffer);
	if (strcmp((char*)buffer, "SUCCESS") != 0)
	{
		printf("\nError logging out: %s\n", buffer);
		return 3;
	}

	isAdmin = false;
	loggedIn = false;

	return 0;
}

bool HSM::signData(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen)
{
	// Calculate SHA-256 of pData
	unsigned char digest[32] = { 0 };
	mbedtls_sha256(pData, ulDataLen, &digest[0], 0);

	comm->reqCommand();
	printf("Sending DTSN_SIGN command...");
	memset(buffer, 0, sizeof(buffer));
	sprintf_s((char*)buffer, sizeof(buffer), "DTSN_SIGN");
	comm->send(buffer, strlen((char*)buffer));
	printf("OK.\n");

	// Now it expects:
	// 32B_HASH
	printf("Sending DATA...");
	comm->send(digest, 32);
	printf("OK\n");

	// Wait for 'SIGNATURE'
	printf("Receiving SIGNATURE...");
	memset(buffer, 0, sizeof(buffer));
	comm->receive(&buffer[0], 512);
	if (strcmp((char*)buffer, "SIGNATURE") != 0)
	{
		printf("\nError: %s\n", buffer);
		return false;
	}
	printf("OK: %s\n", buffer);

	// Wait for actual signature
	printf("Receiving actual signature...");
	memset(pSignature, 0, *pulSignatureLen);
	*pulSignatureLen = comm->receive(pSignature, *pulSignatureLen);
	printf("OK: %d\n", *pulSignatureLen);

	return true;
}
