#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <stdbool.h>
#include <stdint.h>

#include "Device.h"

Device::Device()
{
	connected = false;
	maxSlots = 0;
	maxSessions = 0;
	memset(serialNumber, 0, 128);
}

Device::~Device()
{
}

bool Device::init() { return false; }
bool Device::isConnected() { return false; }
void Device::addSlot(p11_slot * s, int i) { return; }
int Device::startSession() { return 0; }
bool Device::endSession() { return false; }
bool Device::sessionLimit() { return false; }
int Device::login(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_USER_TYPE userType) { return 0; }
int Device::logout() { return 0; }
bool Device::signData(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen) { return false; }
bool Device::verifySignature(CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG pulSignatureLen) { return false; }
bool Device::generateKeyPair(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE_PTR privateKey, CK_OBJECT_HANDLE_PTR publicKey) { return false; }
bool Device::getCertificate(CK_BYTE uid, CK_UTF8CHAR_PTR* certificate, CK_ULONG_PTR bufSize) { return false; }
bool Device::genCertificate(CK_ATTRIBUTE_PTR publicKeyTemplate, CK_ULONG ulCount, CK_UTF8CHAR_PTR publicKey, CK_UTF8CHAR_PTR certificate, CK_ULONG_PTR bufSize) { return false;  }
bool Device::addUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_BYTE_PTR uID) { return false; }
bool Device::modifyUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen) { return false; }
bool Device::deleteUser(CK_BYTE uID) { return false; }
bool Device::logsAdd(CK_UTF8CHAR_PTR message) { return false; }

void Device::strcpy_bp(void * destination, const char * source, size_t dest_size)
{
	int c = strlen(source) > dest_size ? dest_size : strlen(source);

	memcpy((char *)destination, source, c);
	dest_size -= c;
	memset((char *)destination + c, ' ', dest_size);
}