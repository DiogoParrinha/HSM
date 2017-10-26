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
bool Device::getCertificate(CK_LONG uid, CK_UTF8CHAR_PTR* certificate, CK_ULONG_PTR bufSize) { return false; }
bool Device::genCertificate(CK_ATTRIBUTE_PTR publicKeyTemplate, CK_ULONG ulCount, CK_UTF8CHAR_PTR publicKey, CK_UTF8CHAR_PTR certificate, CK_ULONG_PTR bufSize) { return false;  }
bool Device::addUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_BYTE_PTR uID) { return false; }
bool Device::modifyUser(CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen) { return false; }
bool Device::deleteUser(CK_BYTE uID) { return false; }
bool Device::logsAdd(CK_UTF8CHAR_PTR pMessage, CK_ULONG lMessage) { return false; }
bool Device::logsVerifyDay(CK_ULONG lDay, CK_ULONG lMonth, CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain) { return false; }
bool Device::logsVerifyMonth(CK_ULONG lMonth, CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain) { return false; }
bool Device::logsVerifyYear(CK_ULONG lYear, CK_UTF8CHAR_PTR prevHash, CK_BBOOL fullChain) { return false; }
bool Device::logsVerifyChain(CK_ULONG lNumber1, CK_ULONG lNumber2) { return false; }
bool Device::logsGetCounter(CK_ULONG_PTR lNumber1, CK_ULONG_PTR lNumber2) { return false; }

bool Device::sendData(CK_BYTE_PTR pData, CK_ULONG ulDataLen) { return false; }

void Device::strcpy_bp(void * destination, const char * source, size_t dest_size)
{
	int c = strlen(source) > dest_size ? dest_size : strlen(source);

	memcpy((char *)destination, source, c);
	dest_size -= c;
	memset((char *)destination + c, ' ', dest_size);
}


// The functions below are not mine and were retrieved from stack overflow

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

		// sort using a custom function object
		struct {
			bool operator()(std::string a, std::string b) const
			{
				int vA = atoi(a.c_str());
				int vB = atoi(b.c_str());

				return vA < vB;
			}
		} sortByNumber;

		std::sort(result.begin(), result.end(), sortByNumber);
	}
	return result;
}

std::string Device::getLastLine(std::ifstream& in)
{
	std::string line;
	while (in >> std::ws && std::getline(in, line)) // skip empty lines
		;

	return line;
}

///// Source: https://stackoverflow.com/questions/17261798/converting-a-hex-string-to-a-byte-array
int Device::char2int(char input)
{
	if (input >= '0' && input <= '9')
		return input - '0';
	if (input >= 'A' && input <= 'F')
		return input - 'A' + 10;
	if (input >= 'a' && input <= 'f')
		return input - 'a' + 10;
	throw std::invalid_argument("Invalid input string");
}

// This function assumes src to be a zero terminated sanitized string with
// an even number of [0-9a-f] characters, and target to be sufficiently large
// len -> len of source
void Device::hex2bin(const char* src, char* target, int len)
{
	while (len > 0)
	{
		*(target++) = char2int(*src) * 16 + char2int(src[1]);
		src += 2;

		len -= 2;
	}
}