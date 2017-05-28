#pragma once

#include <cstdio>
#include <cstdlib>
#include <stdbool.h>

#include "pkcs11_common.h"
#include "UART.h"

#define CHECK_TIME_PACKETS 0
#define SECURE_SESSION 0

class HSM
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
		int initDevice(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen);
		int login(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_USER_TYPE userType);
		int logout();
		bool signData(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen);
		bool verifySignature(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG pulSignatureLen);
		bool generateKeyPair(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE_PTR privateKey, CK_OBJECT_HANDLE_PTR publicKey);
		bool getCertificate(CK_LONG uid, CK_UTF8CHAR_PTR* certificate, CK_ULONG_PTR bufSize);
		bool genCertificate(CK_ATTRIBUTE_PTR publicKeyTemplate, CK_ULONG ulCount, CK_UTF8CHAR_PTR publicKey, CK_UTF8CHAR_PTR certificate, CK_ULONG_PTR bufSize);
		bool addUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_BYTE_PTR uID);
		bool modifyUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen);
		bool deleteUser(CK_BYTE uID);
		bool logsAdd(CK_UTF8CHAR_PTR pMessage, CK_ULONG lMessage, CK_BBOOL sign);
		bool logsInit(CK_UTF8CHAR_PTR pMessage, CK_ULONG lMessage, CK_UTF8CHAR_PTR lHash);
		bool logsVerifyDay(CK_ULONG lDay, CK_ULONG lMonth, CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain);
		bool logsVerifyMonth(CK_ULONG lMonth, CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain);
		bool logsVerifyYear(CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain);
		bool logsVerifyChain(CK_ULONG counter1, CK_ULONG counter2, CK_UTF8CHAR_PTR hash_init);
		bool logsGetCounter(CK_ULONG_PTR lNumber1, CK_ULONG_PTR lNumber2);
		bool checkDevice();
		bool sendData(CK_BYTE_PTR pData, CK_ULONG ulDataLen);
		void randomArray(CK_BYTE_PTR pData, CK_ULONG ulDataLen);
		bool execCmd(char * pCmd);
		bool processResult();

	private:
		UART* comm;
		uint8_t authID;

		// Timer
		LARGE_INTEGER frequency;        // ticks per second
		LARGE_INTEGER t1, t2;           // ticks
		double elapsedEntries;

		// Log-Chain
		uint32_t elpased; // how many messages were logged since the last signature generation
		uint32_t max_elapsed;
		bool delayed;
		std::string lastMessage;

		uint8_t zero[512];

		bool isAdmin;
		bool loggedIn;
		char serialNumber[128];
		int maxSessions; // per device
		int openSessions;
		bool connected;
		p11_token token;

		void strcpy_bp(void * destination, const char * source, size_t dest_size);
		std::vector<std::string> read_directory(const std::string & path, bool folders);
		std::string getLastLine(std::ifstream & in);
		int char2int(char input);
		void hex2bin(const char * src, char * target, int len);
};

