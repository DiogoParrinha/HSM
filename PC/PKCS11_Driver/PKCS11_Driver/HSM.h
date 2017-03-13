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

	private:
		UART* comm;
};

