// HSMApp.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <windows.h>
#include <stdint.h>
#include <assert.h>

#include "PKCS11/cryptoki.h"
#include <string.h>
#include <stdbool.h>


#include <direct.h>  
#include <stdlib.h>  
#include <stdio.h>

#include <iostream>
#include <sstream>
#include <fstream>

#include "mbedtls/config.h"
#include "mbedtls/sha256.h"

const uint8_t g_separator[] =
"------------------------------------------------------------------------------\r\n";

// Timer
LARGE_INTEGER frequency;        // ticks per second
LARGE_INTEGER t1, t2;           // ticks
double elapsedTime;

void startTimer();
void endTimer();

int main()
{
	printf("%s", g_separator);
	printf("\t\tHSM Application\r\n");
	printf("\tPress ENTER to initiate communication.\r\n");
	printf("%s", g_separator);

	/*uint8_t text0[64] = {
		0x00, 0x00, 0x00, 0x01,
		0x00, 0x00, 0x00, 0x02,
		0x00, 0x00, 0x00, 0x03,
		0x00, 0x00, 0x00, 0x04,
		0x00, 0x00, 0x00, 0x05,
		0x00, 0x00, 0x00, 0x06,
		0x00, 0x00, 0x00, 0x07,
		0x00, 0x00, 0x00, 0x08,
		0x00, 0x00, 0x00, 0x09,
		0x00, 0x00, 0x00, 0x0A,
		0x00, 0x00, 0x00, 0x0B,
		0x00, 0x00, 0x00, 0x0C,
		0x00, 0x00, 0x00, 0x0D,
		0x00, 0x00, 0x00, 0x0E,
		0x00, 0x00, 0x00, 0x0F,
		0x00, 0x00, 0x00, 0x01,
	};

	uint8_t hash[32] = { 0 };
	uint8_t text_incomp0[256] = { 0 };
	memcpy(text_incomp0, text0, 32);
	memset(hash, 0, 32);
	mbedtls_sha256(text_incomp0, 32, &hash[0], 0);*/

	getchar();
	
	CK_ULONG r = 0;
	double average = 0.0f;
	int times = 0;
	unsigned char data[128];

	// Initialize
	r = C_Initialize(NULL);
	if (r != CKR_OK)
	{
		printf("C_Initialize Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Get total slots
	CK_ULONG slotCount;

	r = C_GetSlotList(CK_FALSE, NULL_PTR, &slotCount);
	if (r != CKR_OK)
	{
		printf("C_GetSlotList Failed: %d\n", r);
		getchar();
		return 1;
	}

	// All slots with token
	r = C_GetSlotList(CK_TRUE, NULL_PTR, &slotCount);
	if (r != CKR_OK)
	{
		printf("C_GetSlotList Failed: %d\n", r);
		getchar();
		return 1;
	}

	CK_SLOT_ID_PTR slotList = (CK_SLOT_ID_PTR)malloc(sizeof(CK_SLOT_ID)*slotCount);
	r = C_GetSlotList(CK_TRUE, slotList, &slotCount);
	if (r != CKR_OK)
	{
		printf("C_GetSlotList Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Slot Info
	CK_SLOT_INFO pInfo;
	r = C_GetSlotInfo(0, &pInfo);
	if (r != CKR_OK)
	{
		printf("C_GetSlotInfo Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Init Token
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900000"); // admin
	r = C_InitToken(0, data, 32, NULL_PTR);
	if (r != CKR_OK)
	{
		printf("C_InitToken Failed: %d\n", r);
		getchar();
		return 1;
	}

	//////// Get device certificates

	CK_UTF8CHAR certificate0[4096];
	CK_ULONG bufSize0 = 4096;
	r = HSM_C_CertDevice(0, -1, certificate0, &bufSize0);
	if (r != CKR_OK)
	{
		printf("HSM_C_CertDevice Failed: %d\n", r);
		getchar();
		return 1;
	}

	r = HSM_C_CertDevice(0, -2, certificate0, &bufSize0);
	if (r != CKR_OK)
	{
		printf("HSM_C_CertDevice Failed: %d\n", r);
		getchar();
		return 1;
	}

	r = HSM_C_CertDevice(0, -3, certificate0, &bufSize0);
	if (r != CKR_OK)
	{
		printf("HSM_C_CertDevice Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Execute test
	/*average = 0.0f;
	printf("\nTesting 4096B * 32 of plain text data...");
	startTimer();
	for (int a = 0; a<32; a++)
		HSM_C_SendPlain();
	endTimer();
	printf("OK.\n");
	times = 4096*32; // amount of blocks sent
	average += elapsedTime;
	average /= times;
	printf("Average block transfer: %lfms | %lfms\n", elapsedTime, average);*/

	// Open Session
	printf("\nOpening session...\n");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	if (r != CKR_OK)
	{
		printf("C_OpenSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("OK.\n");

	/*average = 0.0f;
	times = 0;
	printf("\nOpening sessions...");
	for (int i = 0; i < 100; i++)
	{
		startTimer();
		r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
		assert(r == CKR_OK);
		endTimer();
		average += elapsedTime;
		times++;

		// close session
		r = C_CloseSession(phSession);
		assert(r == CKR_OK);
	}
	average /= times;
	printf("OK.\n");
	printf("Average session start: %lfms\n", average);*/

	// Execute test
	/*average = 0.0f;
	printf("\nTesting 4096B * 32 of secure data...");
	startTimer();
	for(int a=0;a<32;a++)
		HSM_C_SendSecure(phSession);
	printf("OK.\n");
	endTimer();
	times = 4096 * 32; // amount of blocks sent
	average += elapsedTime;
	average /= times;
	printf("Average block transfer: %lfms | %lfms\n", elapsedTime, average);*/

	///// ADD 7 USERS

	// Login
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		getchar();
		return 1;
	}

	CK_BYTE userID = 0;
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		getchar();
		return 1;
	}

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900002"); // user 2
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		getchar();
		return 1;
	}

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900003"); // user 3
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		getchar();
		return 1;
	}

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900004"); // user 4
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		getchar();
		return 1;
	}

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900005"); // user 5
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		getchar();
		return 1;
	}

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900006"); // user 6
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		getchar();
		return 1;
	}

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900007"); // user 7
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Logout Admin
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		getchar();
		return 1;
	}*/

	/////// Delete User 1 and Add Back

	// Login admin
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		getchar();
		return 1;
	}

	r = HSM_C_UserDelete(phSession, 1);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserDelete Failed: %d\n", r);
		getchar();
		return 1;
	}

	CK_BYTE userID = 0;
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Logout Admin
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		getchar();
		return 1;
	}*/

	/////// Login with user 1 and modify pin; Logout user 1 and login again with new PIN; Modify PIN and Logout

	// Login user 1
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		getchar();
		return 1;
	}

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555100"); // user 1
	r = HSM_C_UserModify(phSession, &data[0], 32);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserModify Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Logout user 1
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Login user 1
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "11111122222233333344444455555100"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		getchar();
		return 1;
	}

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	r = HSM_C_UserModify(phSession, &data[0], 32);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserModify Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Logout user 1
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		getchar();
		return 1;
	}*/

	///// Sign and Verify

	// Login User
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		getchar();
		return 1;
	}

	average = 0.0f;
	printf("\nSigning data...\n");
	startTimer();
	int i = 0;
	for (i = 0; i<30; i++)
	{
		// Sign Data
		CK_MECHANISM sign_mechanism = {
			CKM_ECDSA, NULL_PTR, 0
		};
		r = C_SignInit(phSession, &sign_mechanism, NULL_PTR);
		if (r != CKR_OK)
		{
			printf("C_SignInit Failed: %d\n", r);
			getchar();
			return 1;
		}

		uint8_t msg[7] = { '1','2','3','4','5','6', '\0' };
		CK_BYTE signature1[512] = { 0 };
		CK_ULONG sig1_len = 512;
		r = C_Sign(phSession, msg, sizeof(msg), &signature1[0], &sig1_len);
		if (r != CKR_OK)
		{
			printf("C_Sign Failed: %d\n", r);
			getchar();
			return 1;
		}

		r = C_SignInit(phSession, &sign_mechanism, NULL_PTR);
		if (r != CKR_OK)
		{
			printf("C_SignInit Failed: %d\n", r);
			getchar();
			return 1;
		}

		r = C_SignUpdate(phSession, msg, sizeof(msg));
		if (r != CKR_OK)
		{
			printf("C_SignUpdate Failed: %d\n", r);
			getchar();
			return 1;
		}

		r = C_SignUpdate(phSession, msg, sizeof(msg));
		if (r != CKR_OK)
		{
			printf("C_SignUpdate Failed: %d\n", r);
			getchar();
			return 1;
		}

		CK_BYTE signature2[512] = { 0 };
		CK_ULONG sig2_len = 512;
		r = C_SignFinal(phSession, &signature2[0], &sig2_len);
		if (r != CKR_OK)
		{
			printf("C_SignFinal Failed: %d\n", r);
			getchar();
			return 1;
		}

		// Verify signatures
		r = C_VerifyInit(phSession, &sign_mechanism, NULL_PTR);
		if (r != CKR_OK)
		{
			printf("C_VerifyInit Failed: %d\n", r);
			getchar();
			return 1;
		}

		r = C_Verify(phSession, msg, sizeof(msg), &signature1[0], sig1_len);
		if (r != CKR_OK)
		{
			printf("C_Verify Failed: %d\n", r);
			getchar();
			return 1;
		}

		r = C_VerifyInit(phSession, &sign_mechanism, NULL_PTR);
		if (r != CKR_OK)
		{
			printf("C_VerifyInit Failed: %d\n", r);
			getchar();
			return 1;
		}

		r = C_VerifyUpdate(phSession, msg, sizeof(msg));
		if (r != CKR_OK)
		{
			printf("C_VerifyUpdate Failed: %d\n", r);
			getchar();
			return 1;
		}

		r = C_VerifyUpdate(phSession, msg, sizeof(msg));
		if (r != CKR_OK)
		{
			printf("C_VerifyUpdate Failed: %d\n", r);
			getchar();
			return 1;
		}

		r = C_VerifyFinal(phSession, &signature2[0], sig2_len);
		if (r != CKR_OK)
		{
			printf("C_VerifyFinal Failed: %d\n", r);
			getchar();
			return 1;
		}

		times++;
	}
	endTimer();
	average += elapsedTime;
	average /= times;
	printf("Average signature: %lfms\n", average);

	// Logout User
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		getchar();
		return 1;
	}*/

	///// Login user and generate key pair | Get certificate of user 1 | Logout | Login admin | Generate certificate for generated public key

	// Login user
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		getchar();
		return 1;
	}

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

	average = 0.0f;
	times = 0;
	printf("\nGenerating keys...");
	startTimer();
	for(int i=0;i<1;i++)
	{
		r = C_GenerateKeyPair(phSession, &genkey_mechanism, pubKeyTemplate, 3, priKeyTemplate, 3, &pub, &pri);
		if (r != CKR_OK)
		{
			printf("C_GenerateKeyPair Failed: %d\n", r);
			getchar();
			return 1;
		}
		times++;
	}
	endTimer();
	average += elapsedTime;
	average /= times;
	printf("\nAverage key generation: %lf\n", average);

	memset(pubBuffer, 0, 512);
	memset(priBuffer, 0, 512);
	r = C_GetAttributeValue(phSession, pub, pubKeyTemplate, 3);
	if (r != CKR_OK)
	{
		printf("C_GetAttributeValue Failed: %d\n", r);
		getchar();
		return 1;
	}

	r = C_GetAttributeValue(phSession, pri, priKeyTemplate, 3);
	if (r != CKR_OK)
	{
		printf("C_GetAttributeValue Failed: %d\n", r);
		getchar();
		return 1;
	}

	// We use our own functions
	CK_UTF8CHAR certificate[4096];
	CK_ULONG bufSize = 4096;
	r = HSM_C_CertGet(phSession, 1, certificate, &bufSize);
	if (r != CKR_OK)
	{
		printf("HSM_C_CertGet Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Logout user 1
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Login admin
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		getchar();
		return 1;
	}

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
	if (r != CKR_OK)
	{
		printf("HSM_C_CertGen Failed: %d\n", r);
		getchar();
		return 1;
	}
	
	// Logout Admin
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		getchar();
		return 1;
	}*/

	///// Login admin to create log-chain root

	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Create log-chain root
	uint8_t hash[32] = { 0x6f, 0x4e, 0xce, 0x48, 0xaf, 0x1d, 0x8d, 0x1f, 0xff, 0xce, 0x45, 0x65, 0x2b, 0x19, 0x02, 0xb4, 0x05, 0x06, 0x04, 0xe6, 0x67, 0xa0, 0xa3, 0xf3, 0x98, 0x56, 0x96, 0x80, 0x3a, 0xfe, 0xf1, 0x56 };
	uint8_t rootmsg[] = "Log-Chain 1 Root";
	r = HSM_C_LogInit(phSession, rootmsg, strlen((char*)rootmsg)+1, hash, 32);

	// Logout Log User
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		getchar();
		return 1;
	}*/

	///// Login user 1, read file and send each line to the HSM

	// Login user 1
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		getchar();
		return 1;
	}

	std::ifstream infile("messages.txt");
	std::string line;

	average = 0.0f;
	times = 0;
	printf("\nLogging messages...\n");
	/*while (std::getline(infile, line))
	{
		const char *pMessage = line.c_str();

		startTimer();
		r = HSM_C_LogAdd(phSession, (CK_UTF8CHAR_PTR)pMessage, line.length(), CK_TRUE);
		endTimer();
		average += elapsedTime;
		times++;

		if (r != CKR_OK)
		{
			printf("HSM_C_LogAdd Failed: %d\n", r);
			getchar();
			return 1;
		}
	}*/
	line = std::string("This is a test command | test command : test");
	startTimer();
	for (int a = 0; a < 10; a++)
	{
		r = HSM_C_LogAdd(phSession, (CK_UTF8CHAR_PTR)line.c_str(), line.length(), CK_TRUE);
		if (r != CKR_OK)
		{
			printf("HSM_C_LogAdd Failed: %d\n", r);
			getchar();
			return 1;
		}
		times++;
	}
	endTimer();
	average += elapsedTime;
	average /= times;
	printf("\nAverage log signing: %lf | %lf\n", elapsedTime, average);

	// Logout Log User
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		getchar();
		return 1;
	}

	///// Get log-chain counters

	CK_ULONG lNumber1, lNumber2;
	r = HSM_C_LogCounter(phSession, &lNumber1, &lNumber2);
	if (r != CKR_OK)
	{
		printf("HSM_C_LogCounter Failed: %d\n", r);
		getchar();
		return 1;
	}

	// close session
	r = C_CloseSession(phSession);
	if (r != CKR_OK)
	{
		printf("C_CloseSession Failed: %d\n", r);
		getchar();
		return 1;
	}

	///// Run verifications

	/*printf("\nVerify day...\n");

	average = 0.0f;
	times = 0;
	startTimer();
	r = HSM_C_LogVerifyDay(phSession, 15, 5, 2017);
	//assert(r == CKR_OK);
	endTimer();
	average += elapsedTime;
	times++;

	average /= times;
	printf("\nOK\n");

	printf("\nVerify month...\n");

	average = 0.0f;
	times = 0;
	startTimer();
	r = HSM_C_LogVerifyMonth(phSession, 5, 2017);
	//assert(r == CKR_OK);
	endTimer();
	average += elapsedTime;
	times++;

	average /= times;
	printf("\nOK\n");
	
	printf("\nVerify year...\n");

	average = 0.0f;
	times = 0;
	startTimer();
	r = HSM_C_LogVerifyYear(phSession, 2016);
	//assert(r == CKR_OK);
	endTimer();
	average += elapsedTime;
	times++;

	average /= times;
	printf("\nOK\n");*/

	/*printf("\nVerify chain...\n");

	uint8_t hash_v[32] = { 0x6f, 0x4e, 0xce, 0x48, 0xaf, 0x1d, 0x8d, 0x1f, 0xff, 0xce, 0x45, 0x65, 0x2b, 0x19, 0x02, 0xb4, 0x05, 0x06, 0x04, 0xe6, 0x67, 0xa0, 0xa3, 0xf3, 0x98, 0x56, 0x96, 0x80, 0x3a, 0xfe, 0xf1, 0x56 };
	average = 0.0f;
	times = 0;
	startTimer();
	r = HSM_C_LogVerifyChain(0, lNumber1, lNumber2, hash_v);
	//assert(r == CKR_OK);
	endTimer();
	average += elapsedTime;
	times++;

	average /= times;
	printf("\nOK\n");
	
	// Finalize
	r = C_Finalize(NULL);
	if (r != CKR_OK)
	{
		printf("C_Finalize Failed: %d\n", r);
		getchar();
		return 1;
	}*/

	printf("\nPress ENTER to continue.\n");

	getchar();

    return 0;
}

void startTimer()
{
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
}

void endTimer()
{
#ifdef _WIN32
	// stop timer
	QueryPerformanceCounter(&t2);
	// compute and print the elapsed time in millisec
	elapsedTime = (t2.QuadPart - t1.QuadPart) * 1000.0 / frequency.QuadPart;
#endif
}

