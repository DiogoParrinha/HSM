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
#include <vector>
#include <dirent.h>

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

int getCertificates();
int add3Users();
int login3Users();
int deleteUser3();
int signVerifyUser1();
int getUser1Certificate();
int genKeyPairUser1GetCertificate();
int createLogChainRootAdmin();
int addLogChainUser1();
int verifyLogChain();
int closeSession(CK_SESSION_HANDLE phSession);

void printOptions() {
	printf("\n\n");
	printf("%s", g_separator);
	printf("Options:\n");
	printf("0. Get System Certificates\n");
	printf("1. Add 3 Users\n");
	printf("2. Login with 3 Users\n");
	printf("3. Delete User 3\n");
	printf("4. Sign and Verify Data with User 1\n");
	printf("5. Generate key pair with user 1 and get certificate with admin\n");
	printf("6. Get user 1 public key certificate\n");
	printf("7. Create Log-Chain Root\n");
	printf("8. Add entries to Log-Chain\n");
	printf("9. Verify Log-Chain\n");
	printf("Q. QUIT\n");
	printf("%s", g_separator);
}

int main()
{
	printf("%s", g_separator);
	printf("\t\tHSM Application\r\n");
	printf("\tPress ENTER to initiate communication.\r\n");
	printf("%s", g_separator);

	CK_ULONG r = 0;
	unsigned char data[128];

	getchar();

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

	/*printf("\nSlot Count: %d\n", slotCount);
	if (slotCount == 0)
	{
		printf("Device is not connected.\n");
		getchar();
		return 1;
	}*/

	// Slot Info
	CK_SLOT_INFO pInfo;
	r = C_GetSlotInfo(0, &pInfo);
	if (r != CKR_OK)
	{
		printf("C_GetSlotInfo Failed: %d\n", r);
		getchar();
		return 1;
	}

	// Init Token (this will only take effect once, afterwards this will basically do nothing because the device will reject it)
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	r = C_InitToken(0, data, 32, NULL_PTR);
	if (r != CKR_OK)
	{
		printf("C_InitToken Failed: %d\n", r);
		getchar();
		return 1;
	}

	printOptions();

	bool exit = false;
	while (char c = getchar()) {
		switch (c)
		{
		case '0':
			//////// Get device certificates
			printf("\nGet system certificates...");
			if ((r = getCertificates()) != 0)
			{
				printf("\nERROR!");
				exit = true;
			}
			else
			{
				printf("\nDone!");
				printOptions();
			}
			break;
		case '1':
			///// Add 3 users
			printf("\nAdd 3 new users...");
			if ((r = add3Users()) != 0)
			{
				printf("\nERROR!");
				exit = true;
			}
			else
			{
				printf("\nDone!");
				printOptions();
			}
			break;
		case '2':
			///// Login and logout with each user
			printf("\nLogin with 3 new users...");
			if ((r = login3Users()) != 0)
			{
				printf("\nERROR!");
				exit = true;
			}
			else
			{
				printf("\nDone!");
				printOptions();
			}
			break;
		case '3':
			///// Delete user 3
			printf("\nDelete user 3...");
			if ((r = deleteUser3()) != 0)
			{
				printf("\nERROR!");
				exit = true;
			}
			else
			{
				printf("\nDone!");
				printOptions();
			}
			break;
		case '4':
			///// Sign and Verify
			printf("\nSign and verify data with user 1...");
			if ((r = signVerifyUser1()) != 0)
			{
				printf("\nERROR!");
				exit = true;
			}
			else
			{
				printf("\nDone!");
				printOptions();
			}
			break;
		case '5':
			///// Generate key pair with user 1 and get certificate with admin
			printf("\nGenerate and extract key pair with user 1 and then get certificate for public key with admin...");
			if ((r = genKeyPairUser1GetCertificate()) != 0)
			{
				printf("\nERROR!");
				exit = true;
			}
			else
			{
				printf("\nDone!");
				printOptions();
			}
			break;
		case '6':
			///// Get user 1 public key certificate
			printf("\nGet user 1 internal public key certificate...");
			if ((r = getUser1Certificate()) != 0)
			{
				printf("\nERROR!");
				exit = true;
			}
			else
			{
				printf("\nDone!");
				printOptions();
			}
			break;
		case '7':
			///// Login admin to create log-chain root
			printf("\nCreating Log-Chain root with admin...");
			if ((r = createLogChainRootAdmin()) != 0)
			{
				printf("\nERROR!");
				exit = true;
			}
			else
			{
				printf("\nDone!");
				printOptions();
			}
			break;
		case '8':
			///// Login user 1, read file and send each line to the HSM
			printf("\nReading log file with user1 and add to Log-Chain...");
			if ((r = addLogChainUser1()) != 0)
			{
				printf("\nERROR!");
				exit = true;
			}
			else
			{
				printf("\nDone!");
				printOptions();
			}
			break;
		case '9':
			///// Verify Log-Chain
			printf("\nVerify Log-Chain...");
			if ((r = verifyLogChain()) != 0)
			{
				printf("\nERROR!");
				exit = true;
			}
			else
			{
				printf("\nDone!");
				printOptions();
			}
			break;
		case 'Q':
			exit = true;
			break;
		}
		
		if (exit)
		{
			break;
		}
	}

	// Finalize
	r = C_Finalize(NULL);
	if (r != CKR_OK)
	{
		printf("C_Finalize Failed: %d\n", r);
		getchar();
		return 1;
	}

	printf("\nPress Q and then ENTER to continue.\n");
	while (char c = getchar()) {
		if (c == 'Q')
			break;
	}

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

int getCertificates()
{
	int r = 0;

	printf("\n\tGet Log-Chain Public Key Certificate...");
	CK_UTF8CHAR certificate0[4096];
	CK_ULONG bufSize0 = 4096;
	r = HSM_C_CertDevice(0, -1, certificate0, &bufSize0);
	if (r != CKR_OK)
	{
		printf("HSM_C_CertDevice Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tGet Session Public Key Certificate...");
	r = HSM_C_CertDevice(0, -2, certificate0, &bufSize0);
	if (r != CKR_OK)
	{
		printf("HSM_C_CertDevice Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tGet Issuer Public Key Certificate...");
	r = HSM_C_CertDevice(0, -3, certificate0, &bufSize0);
	if (r != CKR_OK)
	{
		printf("HSM_C_CertDevice Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	return 0;
}

int add3Users()
{
	CK_ULONG r = 0;
	unsigned char data[128];

	// Open Session
	printf("\n\tOpening session...");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	if (r != CKR_OK)
	{
		printf("C_OpenSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	// Login Admin
	printf("\n\tLogin admin...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tAdd User1...");
	CK_BYTE userID = 0;
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tAdd User2...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900002"); // user 2
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tAdd User3...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900003"); // user 3
	userID = 0;
	r = HSM_C_UserAdd(phSession, &data[0], 32, &userID);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserAdd Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	// Logout Admin
	printf("\n\tLogout admin...");
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	if (closeSession(phSession))
		return 1;
	
	return 0;
}

int login3Users()
{
	CK_ULONG r = 0;
	unsigned char data[128];

	// Open Session
	printf("\n\tOpening session...");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	if (r != CKR_OK)
	{
		printf("C_OpenSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	// Test each user login
	printf("\n\tUser1...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tUser2...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900002"); // user2
	data[32] = 2;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tUser3...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900003"); // user3
	data[32] = 3;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	if (closeSession(phSession))
		return 1;

	return 0;
}

int deleteUser3()
{
	CK_ULONG r = 0;
	unsigned char data[128];

	// Open Session
	printf("\n\tOpening session...");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	if (r != CKR_OK)
	{
		printf("C_OpenSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	// Login Admin
	printf("\n\tLogin admin...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tDeleting user 3...");
	r = HSM_C_UserDelete(phSession, 3);
	if (r != CKR_OK)
	{
		printf("HSM_C_UserDelete Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	// Logout Admin
	printf("\n\tLogout admin...");
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	if (closeSession(phSession))
		return 1;

	return 0;
}

int signVerifyUser1()
{
	CK_ULONG r = 0;
	unsigned char data[128];

	// Open Session
	printf("\n\tOpening session...");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	if (r != CKR_OK)
	{
		printf("C_OpenSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	// Login User
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}

	// Sign Data
	printf("\n\tSigning data...");
	CK_MECHANISM sign_mechanism = {
		CKM_ECDSA, NULL_PTR, 0
	};
	r = C_SignInit(phSession, &sign_mechanism, NULL_PTR);
	if (r != CKR_OK)
	{
		printf("C_SignInit Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
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
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	// Verify signatures
	printf("\n\tVerifying signature with User1 Public Key...");
	r = C_VerifyInit(phSession, &sign_mechanism, NULL_PTR);
	if (r != CKR_OK)
	{
		printf("C_VerifyInit Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}

	r = C_Verify(phSession, msg, sizeof(msg), &signature1[0], sig1_len);
	if (r != CKR_OK)
	{
		printf("C_Verify Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	// Logout User
	printf("\n\tLogout user...");
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	if (closeSession(phSession))
		return 1;

	return 0;
}

int genKeyPairUser1GetCertificate()
{
	CK_ULONG r = 0;
	unsigned char data[128];

	// Open Session
	printf("\n\tOpening session...");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	if (r != CKR_OK)
	{
		printf("C_OpenSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	// Login User
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}

	// Generate a key pair
	printf("\n\tGenerating and extracting key pair for User1...");
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
	
	for (int i = 0; i<1; i++)
	{
		r = C_GenerateKeyPair(phSession, &genkey_mechanism, pubKeyTemplate, 3, priKeyTemplate, 3, &pub, &pri);
		if (r != CKR_OK)
		{
			printf("C_GenerateKeyPair Failed: %d\n", r);
			HSM_C_DeleteSession(phSession);
			getchar();
			return 1;
		}
	}

	memset(pubBuffer, 0, 512);
	memset(priBuffer, 0, 512);
	r = C_GetAttributeValue(phSession, pub, pubKeyTemplate, 3);
	if (r != CKR_OK)
	{
		printf("C_GetAttributeValue Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}

	r = C_GetAttributeValue(phSession, pri, priKeyTemplate, 3);
	if (r != CKR_OK)
	{
		printf("C_GetAttributeValue Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	// Logout User
	printf("\n\tLogout user 1...");
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	// Login admin
	printf("\n\tLogin admin...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tGenerating public key certificate for extracted public key...");
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
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	// Logout Admin
	printf("\n\tLogout admin...");
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	if (closeSession(phSession))
		return 1;

	return 0;
}

int getUser1Certificate()
{
	CK_ULONG r = 0;
	unsigned char data[128];

	// Open Session
	printf("\n\tOpening session...");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	if (r != CKR_OK)
	{
		printf("C_OpenSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	// Login User
	printf("\n\tLogin user 1...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tExtracting public key certificate...");
	CK_UTF8CHAR certificate[4096];
	CK_ULONG bufSize = 4096;
	r = HSM_C_CertGet(phSession, 1, certificate, &bufSize);
	if (r != CKR_OK)
	{
		printf("HSM_C_CertGet Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	DIR *dir;
	if ((dir = opendir("./certs")) == NULL)
	{
		if (_mkdir("./certs") != 0)
		{
			printf("Problem creating directory './certs'\n");
		}
	}
	else
		closedir(dir);

	std::ofstream outfile;
	outfile.open("./certs/user1.crt", std::ofstream::out | std::ofstream::trunc);
	outfile.write((char*)certificate, strlen((char*)certificate) + 1);
	outfile.close();

	// Logout User
	printf("\n\tLogout user...");
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	if (closeSession(phSession))
		return 1;

	return 0;
}

int createLogChainRootAdmin()
{
	CK_ULONG r = 0;
	unsigned char data[128];

	// Open Session
	printf("\n\tOpening session...");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	if (r != CKR_OK)
	{
		printf("C_OpenSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	// Login User
	printf("\n\tLogin admin...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678912345"); // admin
	data[32] = 0;
	r = C_Login(phSession, CKU_SO, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	// Create log-chain root
	printf("\n\tCreating root...");
	uint8_t hash[32] = { 0x6f, 0x4e, 0xce, 0x48, 0xaf, 0x1d, 0x8d, 0x1f, 0xff, 0xce, 0x45, 0x65, 0x2b, 0x19, 0x02, 0xb4, 0x05, 0x06, 0x04, 0xe6, 0x67, 0xa0, 0xa3, 0xf3, 0x98, 0x56, 0x96, 0x80, 0x3a, 0xfe, 0xf1, 0x56 };
	uint8_t rootmsg[] = "Log-Chain 1 Root";
	r = HSM_C_LogInit(phSession, rootmsg, strlen((char*)rootmsg) + 1, hash, 32);
	printf("Done!");

	// Logout Admin
	printf("\n\tLogout admin...");
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	if (closeSession(phSession))
		return 1;

	return 0;
}

int addLogChainUser1()
{
	CK_ULONG r = 0;
	unsigned char data[128];

	// Open Session
	printf("\n\tOpening session...");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	if (r != CKR_OK)
	{
		printf("C_OpenSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	// Login Admin
	printf("\n\tLogin user 1...");
	memset(data, 0, 128);
	sprintf_s((char*)data, 128, "%s", "12345678912345678912345678900001"); // user 1
	data[32] = 1;
	r = C_Login(phSession, CKU_USER, data, 33);
	if (r != CKR_OK)
	{
		printf("C_Login Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	printf("\n\tAdding entries to Log-Chain...");
	std::ifstream infile("messages.txt");
	std::string line;

	while (std::getline(infile, line))
	{
		const char *pMessage = line.c_str();

		r = HSM_C_LogAdd(phSession, (CK_UTF8CHAR_PTR)pMessage, line.length(), CK_TRUE);

		if (r != CKR_OK)
		{
			printf("HSM_C_LogAdd Failed: %d\n", r);
			HSM_C_DeleteSession(phSession);
			getchar();
			return 1;
		}
	}
	printf("Done!");

	// Logout User
	printf("\n\tLogout user...");
	r = C_Logout(phSession);
	if (r != CKR_OK)
	{
		printf("C_Logout Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	if (closeSession(phSession))
		return 1;

	return 0;
}

int verifyLogChain()
{
	CK_ULONG r = 0;
	unsigned char data[128];

	// Open Session
	printf("\n\tOpening session...");
	CK_BYTE application = 1;
	CK_SESSION_HANDLE phSession;
	r = C_OpenSession(0, CKF_SERIAL_SESSION | CKF_RW_SESSION, (CK_VOID_PTR)&application, NULL_PTR, &phSession);
	if (r != CKR_OK)
	{
		printf("C_OpenSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");

	CK_ULONG lNumber1, lNumber2;
	r = HSM_C_LogCounter(phSession, &lNumber1, &lNumber2);
	if (r != CKR_OK)
	{
		printf("HSM_C_LogCounter Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}

	if (closeSession(phSession))
		return 1;

	printf("\n\tVerifying chain...");
	uint8_t hash_v[32] = { 0x6f, 0x4e, 0xce, 0x48, 0xaf, 0x1d, 0x8d, 0x1f, 0xff, 0xce, 0x45, 0x65, 0x2b, 0x19, 0x02, 0xb4, 0x05, 0x06, 0x04, 0xe6, 0x67, 0xa0, 0xa3, 0xf3, 0x98, 0x56, 0x96, 0x80, 0x3a, 0xfe, 0xf1, 0x56 };
	r = HSM_C_LogVerifyChain(0, lNumber1, lNumber2, hash_v);
	if(r != CKR_OK)
	{
		printf("HSM_C_LogVerifyChain Failed: %d\n", r);
		HSM_C_DeleteSession(phSession);
		getchar();
		return 1;
	}
	printf("Done!");

	return 0;
}

int closeSession(CK_SESSION_HANDLE phSession)
{
	// Close session
	printf("\n\tClosing session...");
	int r = C_CloseSession(phSession);
	if (r != CKR_OK)
	{
		printf("C_CloseSession Failed: %d\n", r);
		getchar();
		return 1;
	}
	printf("Done!");
	return 0;
}