// HSMApp.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <windows.h>
#include <stdint.h>
#include <assert.h>
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

#include "PKCS11/cryptoki.h"
#include <string.h>
#include <stdbool.h>

#include <iostream>
#include <sstream>
#include <fstream>

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
void GET_CERT();
void USER_CERT();
void START_SESSION();
void END_SESSION();
void LOG_ADD();

int main()
{
	printf("%s", g_separator);
	printf("\t\tHSM Application\r\n");
	printf("\tPress ENTER to initiate communication.\r\n");
	printf("%s", g_separator);
	getchar();

	CK_ULONG r = 0;

	// Initialize
	r = C_Initialize(NULL);
	assert(r == CKR_OK);

	// Get total slots
	CK_ULONG slotCount;

	r = C_GetSlotList(CK_FALSE, NULL_PTR, &slotCount);
	assert(r == CKR_OK);

	// All slots with token
	r = C_GetSlotList(CK_TRUE, NULL_PTR, &slotCount);
	assert(r == CKR_OK);

	CK_SLOT_ID_PTR slotList = (CK_SLOT_ID_PTR)malloc(sizeof(CK_SLOT_ID)*slotCount);
	r = C_GetSlotList(CK_TRUE, slotList, &slotCount);
	assert(r == CKR_OK);

	// Slot Info
	CK_SLOT_INFO pInfo;
	r = C_GetSlotInfo(0, &pInfo);
	assert(r == CKR_OK);

	// Open Session
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	assert(r == CKR_OK);

	unsigned char data[128];

	// Login User
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	assert(r == CKR_OK);

	// Sign Data
	CK_MECHANISM sign_mechanism = {
		CKM_ECDSA, NULL_PTR, 0
	};
	r = C_SignInit(phSession, &sign_mechanism, NULL_PTR);
	assert(r == CKR_OK);

	uint8_t msg[7] = { '1','2','3','4','5','6', '\0' };
	CK_BYTE signature1[512] = { 0 };
	CK_ULONG sig1_len = 0;
	r = C_Sign(phSession, msg, sizeof(msg), &signature1[0], &sig1_len);
	assert(r == CKR_OK);

	r = C_SignInit(phSession, &sign_mechanism, NULL_PTR);
	assert(r == CKR_OK);

	r = C_SignUpdate(phSession, msg, sizeof(msg));
	assert(r == CKR_OK);

	r = C_SignUpdate(phSession, msg, sizeof(msg));
	assert(r == CKR_OK);

	CK_BYTE signature2[512] = { 0 };
	CK_ULONG sig2_len = 0;
	r = C_SignFinal(phSession, &signature2[0], &sig2_len);
	assert(r == CKR_OK);

	// Verify signatures
	r = C_VerifyInit(phSession, &sign_mechanism, NULL_PTR);
	assert(r == CKR_OK);

	r = C_Verify(phSession, msg, sizeof(msg), &signature1[0], sig1_len);
	assert(r == CKR_OK);

	r = C_VerifyInit(phSession, &sign_mechanism, NULL_PTR);
	assert(r == CKR_OK);

	r = C_VerifyUpdate(phSession, msg, sizeof(msg));
	assert(r == CKR_OK);

	r = C_VerifyUpdate(phSession, msg, sizeof(msg));
	assert(r == CKR_OK);

	r = C_VerifyFinal(phSession, &signature2[0], sig2_len);
	assert(r == CKR_OK);

	// Logout User
	r = C_Logout(phSession);
	assert(r == CKR_OK);*/

	///// ADD 7 USERS

	// Login
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	assert(r == CKR_OK);

	CK_BYTE userID = 0;
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555001"); // user 1
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555002"); // user 2
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555003"); // user 3
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555004"); // user 4
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555005"); // user 5
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555006"); // user 6
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555007"); // user 7
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	// Logout Admin
	r = C_Logout(phSession);
	assert(r == CKR_OK);*/

	/////// Delete User 1 and Add Back

	// Login admin
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	assert(r == CKR_OK);

	r = HSM_C_UserDelete(phSession, 1);
	assert(r == CKR_OK);

	CK_BYTE userID = 0;
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555001"); // user 1
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	// Logout Admin
	r = C_Logout(phSession);
	assert(r == CKR_OK);

	/////// Login with user 1 and modify pin; Logout user 1 and login again with new PIN; Modify PIN and Logout

	// Login user 1
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555100"); // user 1
	r = HSM_C_UserModify(phSession, &data[0], 32);
	assert(r == CKR_OK);

	// Logout user 1
	r = C_Logout(phSession);
	assert(r == CKR_OK);


	// Login user 1
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555100"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555001"); // user 1
	r = HSM_C_UserModify(phSession, &data[0], 32);
	assert(r == CKR_OK);

	// Logout user 1
	r = C_Logout(phSession);
	assert(r == CKR_OK);*/



	///// Login admin and generate key pair | Get certificate of user 1 | Generate certificate for generated public key

	// Login admin
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	assert(r == CKR_OK);

	// Generate a key pair 
	CK_MECHANISM genkey_mechanism = {
		CKM_EC_KEY_PAIR_GEN, NULL_PTR, 0
	};

	CK_OBJECT_HANDLE pri, pub;
	CK_OBJECT_CLASS keyClass1 = CKO_PUBLIC_KEY;
	CK_OBJECT_CLASS keyClass2 = CKO_PRIVATE_KEY;
	CK_KEY_TYPE keyType = CKK_EC;

	uint8_t pubBuffer[512] = { 0 };
	CK_ATTRIBUTE pubKeyTemplate[] = {
		{ CKA_CLASS, &keyClass1, sizeof(keyClass1) },
		{ CKA_KEY_TYPE, &keyType, sizeof(keyType) },
		{ CKA_EC_POINT, pubBuffer, sizeof(pubBuffer) }
	};

	uint8_t priBuffer[512] = { 0 };
	CK_ATTRIBUTE priKeyTemplate[] = {
		{ CKA_CLASS, &keyClass2, sizeof(keyClass2) },
		{ CKA_KEY_TYPE, &keyType, sizeof(keyType) },
		{ CKA_VALUE, priBuffer, sizeof(priBuffer) }
	};

	r = C_GenerateKeyPair(phSession, &genkey_mechanism, pubKeyTemplate, 3, priKeyTemplate, 3, &pub, &pri);
	assert(r == CKR_OK);

	memset(pubBuffer, 0, 512);
	memset(priBuffer, 0, 512);
	r = C_GetAttributeValue(phSession, pub, pubKeyTemplate, 3);
	assert(r == CKR_OK);

	r = C_GetAttributeValue(phSession, pri, priKeyTemplate, 3);
	assert(r == CKR_OK);

	// We use our own functions
	CK_UTF8CHAR certificate[4096];
	CK_ULONG bufSize = 4096;
	r = HSM_C_CertGet(phSession, 1, certificate, &bufSize);
	assert(r == CKR_OK);

	CK_BBOOL MTRUE = CK_TRUE;
	CK_UTF8CHAR subject[] = "CN=Diogo Parrinha, O=INESC-ID, C=PT";
	CK_ATTRIBUTE pubTemplateCert[] = {
		{ CKA_CLASS, &keyClass1, sizeof(keyClass1) },
		{ CKA_SUBJECT, subject, sizeof(subject) },
		{ CKA_VERIFY, &MTRUE, sizeof(MTRUE) },
		{ CKA_ENCRYPT, &MTRUE, sizeof(MTRUE) },
		{ CKA_DERIVE, &MTRUE, sizeof(MTRUE) }
	};
	CK_UTF8CHAR certificate2[4096];
	CK_ULONG certSize = 4096;
	r = HSM_C_CertGen(phSession, pubTemplateCert, 5, pubBuffer, certificate2, &certSize);
	assert(r == CKR_OK);
	
	// Logout Admin
	r = C_Logout(phSession);
	assert(r == CKR_OK);*/



	///// Login user 1, read file and send each line to the HSM

	// Login user 1
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	assert(r == CKR_OK);

	int i = 0;
	std::ifstream infile("messages.txt");
	std::string line;
	while (std::getline(infile, line))
	{
		printf("\ni = %d", i++);
		const char *pMessage = line.c_str();
		HSM_C_LogAdd(phSession, (CK_UTF8CHAR_PTR)pMessage, line.length());
		assert(r == CKR_OK);
	}

	// Logout Log User
	r = C_Logout(phSession);
	assert(r == CKR_OK);


	// close session
	r = C_CloseSession(phSession);
	assert(r == CKR_OK);

	// Finalize
	r = C_Finalize(NULL);
	assert(r == CKR_OK);

	printf("\nPress ENTER to continue.\n");

	getchar();

    return 0;
}

#endif