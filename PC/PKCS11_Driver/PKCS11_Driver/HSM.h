#pragma once

#include <cstdio>
#include <cstdlib>
#include <stdbool.h>

#include "pkcs11_common.h"
#include "Device.h"
#include "UART.h"

class HSM : public Device
{
	public:
		HSM();
		~HSM();

		uint8_t getTotalServices();

		bool init();
		bool isConnected();
		void addSlot(p11_slot * s, int i);
		int startSession();
		bool endSession();
		bool sessionLimit();
		bool sendTime();
		int login(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_USER_TYPE userType);
		int logout();
		bool signData(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen);
		bool verifySignature(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG pulSignatureLen);
		bool generateKeyPair(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE_PTR privateKey, CK_OBJECT_HANDLE_PTR publicKey);
		bool getCertificate(CK_BYTE uid, CK_UTF8CHAR_PTR* certificate, CK_ULONG_PTR bufSize);
		bool genCertificate(CK_ATTRIBUTE_PTR publicKeyTemplate, CK_ULONG ulCount, CK_UTF8CHAR_PTR publicKey, CK_UTF8CHAR_PTR certificate, CK_ULONG_PTR bufSize);
		bool addUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_BYTE_PTR uID);
		bool modifyUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen);
		bool deleteUser(CK_BYTE uID);
		bool logsAdd(CK_UTF8CHAR_PTR pMessage, CK_ULONG lMessage);
		bool logsGet(CK_ULONG lNumber, CK_UTF8CHAR_PTR pLog, CK_ULONG_PTR logSize);
		bool logsGetHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize);
		bool logsGetDayHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize);
		bool logsGetMonthHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize);
		bool logsVerifyDay(CK_ULONG lNumber);
		bool logsVerify(CK_ULONG lNumber);
		bool logsVerifyDayHash(CK_ULONG lNumber);
		bool logsVerifyMonthHash(CK_ULONG lNumber);
		bool logsGetCounter(CK_ULONG_PTR lNumber1, CK_ULONG_PTR lNumber2);
		bool checkDevice();
		bool sendData(CK_BYTE_PTR pData, CK_ULONG ulDataLen);

		void startTimer();
		void endTimer();

	private:
		UART* comm;
		uint8_t authID;

		// Timer
		LARGE_INTEGER frequency;        // ticks per second
		LARGE_INTEGER t1, t2;           // ticks
		double elapsedTime;
};

