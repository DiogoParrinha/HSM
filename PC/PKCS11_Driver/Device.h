/*
MIT License

Copyright (c) 2017 Diogo Parrinha

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
#pragma once

#include <cstdio>
#include <cstdlib>
#include <stdbool.h>

#include "pkcs11_common.h"

#include <algorithm>
#include <string>
#include <vector>
#include <sys/types.h>
#include <dirent.h>
#include <iostream>
#include <fstream>
#include <string>

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
		virtual bool getCertificate(CK_LONG uid, CK_UTF8CHAR_PTR* certificate, CK_ULONG_PTR bufSize);
		virtual bool genCertificate(CK_ATTRIBUTE_PTR publicKeyTemplate, CK_ULONG ulCount, CK_UTF8CHAR_PTR publicKey, CK_UTF8CHAR_PTR certificate, CK_ULONG_PTR bufSize);
		virtual bool addUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_BYTE_PTR uID);
		virtual bool modifyUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen);
		virtual bool deleteUser(CK_BYTE uID);
		virtual bool logsAdd(CK_UTF8CHAR_PTR pMessage, CK_ULONG lMessage);
		virtual bool logsVerifyDay(CK_ULONG lDay, CK_ULONG lMonth, CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain);
		virtual bool logsVerifyMonth(CK_ULONG lMonth, CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain);
		virtual bool logsVerifyYear(CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain);
		virtual bool logsVerifyChain(CK_ULONG lNumber1, CK_ULONG lNumber2);
		virtual bool logsGetCounter(CK_ULONG_PTR lNumber1, CK_ULONG_PTR lNumber2);
		virtual bool sendData(CK_BYTE_PTR pData, CK_ULONG ulDataLen);

		void strcpy_bp(void * destination, const char * source, size_t dest_size);

		std::vector<std::string> read_directory(const std::string & path, bool folders);

		std::string getLastLine(std::ifstream & in);

		int char2int(char input);

		void hex2bin(const char * src, char * target, int len);

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

std::string getLastLine(std::ifstream & in);
