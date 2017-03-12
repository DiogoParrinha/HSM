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

		void strcpy_bp(void * destination, const char * source, size_t dest_size);

	protected:
		char serialNumber[128];
		int maxSlots;
		int maxSessions; // per device
		int openSessions;
		bool connected;
		p11_token token;
};

