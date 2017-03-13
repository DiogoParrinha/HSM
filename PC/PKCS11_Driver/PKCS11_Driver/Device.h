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
		virtual int login(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_USER_TYPE userType);
		virtual int logout();
		virtual bool signData(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen);

		void strcpy_bp(void * destination, const char * source, size_t dest_size);

	protected:
		bool isAdmin;
		bool loggedIn;
		char serialNumber[128];
		int maxSlots;
		int maxSessions; // per device
		int openSessions;
		bool connected;
		p11_token token;
};

