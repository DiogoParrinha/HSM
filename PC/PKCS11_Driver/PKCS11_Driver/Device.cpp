#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <stdbool.h>
#include <stdint.h>
#include <errno.h>

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
int Device::initDevice(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen) { return false; }
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
bool Device::logsAdd(CK_UTF8CHAR_PTR pMessage, CK_ULONG lMessage) { return false; }

bool Device::logsGet(CK_ULONG lNumber, CK_UTF8CHAR_PTR pLog, CK_ULONG_PTR logSize)
{
	return false;
}

bool Device::logsGetHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize)
{
	return false;
}

bool Device::logsGetDayHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize)
{
	return false;
}

bool Device::logsGetMonthHash(CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize)
{
	return false;
}

bool Device::logsVerifyDay(CK_ULONG lNumber)
{
	return false;
}

bool Device::logsVerify(CK_ULONG lNumber)
{
	return false;
}

bool Device::logsVerifyDayHash(CK_ULONG lNumber)
{
	return false;
}

bool Device::logsVerifyMonthHash(CK_ULONG lNumber)
{
	return false;
}

bool Device::logsGetCounter(CK_ULONG_PTR lNumber1, CK_ULONG_PTR lNumber2)
{
	return false;
}

bool Device::sendData(CK_BYTE_PTR pData, CK_ULONG ulDataLen)
{
	return false;
}

void Device::strcpy_bp(void * destination, const char * source, size_t dest_size)
{
	int c = strlen(source) > dest_size ? dest_size : strlen(source);

	memcpy((char *)destination, source, c);
	dest_size -= c;
	memset((char *)destination + c, ' ', dest_size);
}


// read_directory()
//   Return an ASCII-sorted vector of filename entries in a given directory.
//   If no path is specified, the current working directory is used.
//
//   Always check the value of the global 'errno' variable after using this
//   function to see if anything went wrong. (It will be zero if all is well.)
//
std::vector<std::string> Device::read_directory(const std::string& path = std::string(), bool folders = true)
{
	std::vector <std::string> result;
	dirent* de;
	DIR* dp;
	errno = 0;
	dp = opendir(path.empty() ? "." : path.c_str());
	if (dp)
	{
		while (true)
		{
			errno = 0;
			de = readdir(dp);
			if (de == NULL) break;

			char p[256] = { 0 };
			sprintf_s(p, 256, "%s/%s", path.c_str(), de->d_name);

			struct stat entrystat;
			int r = stat(p, &entrystat);
			if (r == 0 && strcmp(de->d_name, "..") != 0 && strcmp(de->d_name, ".") != 0)
			{
				// Folders only?
				if (folders == true && S_ISDIR(entrystat.st_mode))
				{
					result.push_back(std::string(de->d_name));
				}
				// Files only?
				else if (folders == false && S_ISREG(entrystat.st_mode))
				{
					result.push_back(std::string(de->d_name));
				}
			}
		}
		closedir(dp);
		std::sort(result.begin(), result.end());
	}
	return result;
}

std::string getLastLine(std::ifstream& in)
{
	std::string line;
	while (in >> std::ws && std::getline(in, line)) // skip empty lines
		;

	return line;
}