#pragma once

#include <cstdio>
#include <cstdlib>
#include <stdbool.h>

#include "pkcs11_common.h"

class Device
{
	public:
		Device();
		~Device();
		virtual bool init();
		virtual bool isConnected();
		virtual void addSlot(p11_slot * s, int i);
		virtual int startSession();
		virtual bool endSession();
		virtual bool sessionLimit();
		virtual int initDevice(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen);
		virtual int login(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_USER_TYPE userType);
		virtual int logout();
		virtual bool signData(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen);
		virtual bool verifySignature(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG pulSignatureLen);
		virtual bool generateKeyPair(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE_PTR privateKey, CK_OBJECT_HANDLE_PTR publicKey);
		virtual bool getCertificate(CK_BYTE uid, CK_UTF8CHAR_PTR* certificate, CK_ULONG_PTR bufSize);
		virtual bool genCertificate(CK_ATTRIBUTE_PTR publicKeyTemplate, CK_ULONG ulCount, CK_UTF8CHAR_PTR publicKey, CK_UTF8CHAR_PTR certificate, CK_ULONG_PTR bufSize);
		virtual bool addUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_BYTE_PTR uID);
		virtual bool modifyUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen);
		virtual bool deleteUser(CK_BYTE uID);
		virtual bool logsAdd(CK_UTF8CHAR_PTR pMessage, CK_ULONG lMessage);
		virtual bool logsGet(CK_ULONG lNumber, CK_UTF8CHAR_PTR pLog, CK_ULONG_PTR logSize);
		virtual bool logsGetHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize);
		virtual bool logsGetDayHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize);
		virtual bool logsGetMonthHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize);
		virtual bool logsVerifyDay(CK_ULONG lNumber);
		virtual bool logsVerify(CK_ULONG lNumber);
		virtual bool logsVerifyDayHash(CK_ULONG lNumber);
		virtual bool logsVerifyMonthHash(CK_ULONG lNumber);
		virtual bool logsGetCounter(CK_ULONG_PTR lNumber1, CK_ULONG_PTR lNumber2);
		virtual bool sendData(CK_BYTE_PTR pData, CK_ULONG ulDataLen);

		void strcpy_bp(void * destination, const char * source, size_t dest_size);

		int maxSlots;

	protected:
		bool isAdmin;
		bool loggedIn;
		char serialNumber[128];
		int maxSessions; // per device
		int openSessions;
		bool connected;
		p11_token token;
};

