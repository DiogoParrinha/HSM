// HSMApp.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <windows.h>
#include <stdint.h>
#include <assert.h>

#include "PKCS11/cryptoki.h"
#include <string.h>
#include <stdbool.h>

#include <iostream>
#include <sstream>
#include <fstream>
#include <ctime>

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
	getchar();

	CK_ULONG r = 0;
	double average = 0.0f;
	int times = 0;
	unsigned char data[128];

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

	// Init Token
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900000"); // admin
	r = C_InitToken(0, data, 32, NULL_PTR);
	assert(r == CKR_OK);

	// Execute test
	/*average = 0.0f;
	printf("\nTesting 4096B of plain text data...");
	startTimer();
	HSM_C_SendPlain();
	assert(r == CKR_OK);
	endTimer();
	printf("OK.\n");
	times = 4096/16; // amount of blocks sent
	average += elapsedTime;
	average /= times;
	printf("Average block transfer: %lfms\n", average);*/

	// Open Session
	printf("\nOpening session...\n");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	assert(r == CKR_OK);
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
	printf("\nTesting 4096B of secure data...");
	startTimer();
	HSM_C_SendSecure(phSession);
	assert(r == CKR_OK);
	printf("OK.\n");
	endTimer();
	times = 4096 / 16; // amount of blocks sent
	average += elapsedTime;
	average /= times;
	printf("Average block transfer: %lfms\n", average);

	getchar();
	return 0;*/

	// Login User
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	assert(r == CKR_OK);

	average = 0.0f;
	printf("\nSigning data...\n");
	startTimer();
	int i = 0;
	for (i=0; i<50; i++)
	{
		// Sign Data
		CK_MECHANISM sign_mechanism = {
			CKM_ECDSA, NULL_PTR, 0
		};
		r = C_SignInit(phSession, &sign_mechanism, NULL_PTR);
		assert(r == CKR_OK);

		uint8_t msg[7] = { '1','2','3','4','5','6', '\0' };
		CK_BYTE signature1[512] = { 0 };
		CK_ULONG sig1_len = 512;
		r = C_Sign(phSession, msg, sizeof(msg), &signature1[0], &sig1_len);
		assert(r == CKR_OK);*/

		/*r = C_SignInit(phSession, &sign_mechanism, NULL_PTR);
		assert(r == CKR_OK);

		r = C_SignUpdate(phSession, msg, sizeof(msg));
		assert(r == CKR_OK);

		r = C_SignUpdate(phSession, msg, sizeof(msg));
		assert(r == CKR_OK);

		CK_BYTE signature2[512] = { 0 };
		CK_ULONG sig2_len = 512;
		r = C_SignFinal(phSession, &signature2[0], &sig2_len);
		assert(r == CKR_OK);*/

		// Verify signatures
		/*r = C_VerifyInit(phSession, &sign_mechanism, NULL_PTR);
		assert(r == CKR_OK);

		r = C_Verify(phSession, msg, sizeof(msg), &signature1[0], sig1_len);
		assert(r == CKR_OK);*/

		/*r = C_VerifyInit(phSession, &sign_mechanism, NULL_PTR);
		assert(r == CKR_OK);

		r = C_VerifyUpdate(phSession, msg, sizeof(msg));
		assert(r == CKR_OK);

		r = C_VerifyUpdate(phSession, msg, sizeof(msg));
		assert(r == CKR_OK);

		r = C_VerifyFinal(phSession, &signature2[0], sig2_len);
		assert(r == CKR_OK);*/

		/*times++;
	}
	endTimer();
	average += elapsedTime;
	average /= times;
	printf("Average signature: %lfms\n", average);

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
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900002"); // user 2
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900003"); // user 3
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900004"); // user 4
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900005"); // user 5
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900006"); // user 6
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900007"); // user 7
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
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	assert(r == CKR_OK);

	// Logout Admin
	r = C_Logout(phSession);
	assert(r == CKR_OK);

	/////// Login with user 1 and modify pin; Logout user 1 and login again with new PIN; Modify PIN and Logout

	// Login user 1
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
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
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	r = HSM_C_UserModify(phSession, &data[0], 32);
	assert(r == CKR_OK);

	// Logout user 1
	r = C_Logout(phSession);
	assert(r == CKR_OK);*/



	///// Login user and generate key pair | Get certificate of user 1 | Logout | Login admin | Generate certificate for generated public key

	// Login user
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
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

	average = 0.0f;
	times = 0;
	printf("\nGenerating keys...");
	startTimer();
	for(int i=0;i<10;i++)
	{
		r = C_GenerateKeyPair(phSession, &genkey_mechanism, pubKeyTemplate, 3, priKeyTemplate, 3, &pub, &pri);
		assert(r == CKR_OK);
		times++;
	}
	endTimer();
	average += elapsedTime;
	average /= times;
	printf("\nAverage key generation: %lf\n", average);

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

	// Logout user 1
	r = C_Logout(phSession);
	assert(r == CKR_OK);*/

	/*
	// Login admin
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
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
	/*memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	assert(r == CKR_OK);

	int i = 0;
	std::ifstream infile("messages.txt");
	std::string line;

	average = 0.0f;
	times = 0;
	printf("\nLogging messages...\n");
	while (std::getline(infile, line))
	{
		//printf("\ni = %d", i++);
		const char *pMessage = line.c_str();

		startTimer();
		HSM_C_LogAdd(phSession, (CK_UTF8CHAR_PTR)pMessage, line.length());
		endTimer();
		average += elapsedTime;
		times++;

		assert(r == CKR_OK);

		i++;
	}
	average /= times;
	printf("\nAverage log signing: %lf\n", average);

	// Logout Log User
	r = C_Logout(phSession);
	assert(r == CKR_OK);*/

	//////// Get device logs public key certificate

	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	assert(r == CKR_OK);

	CK_UTF8CHAR certificate[4096];
	CK_ULONG bufSize = 4096;
	r = HSM_C_CertGet(phSession, -1, certificate, &bufSize);
	assert(r == CKR_OK);

	r = HSM_C_CertGet(phSession, -2, certificate, &bufSize);
	assert(r == CKR_OK);

	r = HSM_C_CertGet(phSession, -3, certificate, &bufSize);
	assert(r == CKR_OK);

	// Logout user 1
	r = C_Logout(phSession);
	assert(r == CKR_OK);

	// close session
	r = C_CloseSession(phSession);
	assert(r == CKR_OK);

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
	printf("\nOK\n");*/
	
	/*printf("\nVerify year...\n");

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

	printf("\nVerify chain...\n");

	average = 0.0f;
	times = 0;
	startTimer();
	r = HSM_C_LogVerifyChain(0);
	//assert(r == CKR_OK);
	endTimer();
	average += elapsedTime;
	times++;

	average /= times;
	printf("\nOK\n");
	
	// Finalize
	r = C_Finalize(NULL);
	assert(r == CKR_OK);

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