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

#include "stdafx.h"
#include "SerialPort.h"

FILE *fpOut, *fpIn;

SerialPort::SerialPort() {
	serialPortHandle = INVALID_HANDLE_VALUE;
}
 
SerialPort::~SerialPort() {
	if (serialPortHandle!=INVALID_HANDLE_VALUE)
		CloseHandle(serialPortHandle);
	 
	serialPortHandle = INVALID_HANDLE_VALUE;
}
 
int SerialPort::connect() {

	fopen_s(&fpOut, "./logOut.txt", "w+");
	fopen_s(&fpIn, "./logIn.txt", "w+");

	return connect(L"COM3");
}
 
int SerialPort::connect( wchar_t* device) {

	int error=0;
	DCB dcb;
	 
	memset(&dcb,0,sizeof(dcb));
	 
	dcb.DCBlength = sizeof(dcb);
	 
	dcb.BaudRate = 57600;
	dcb.Parity = NOPARITY;
	dcb.fParity = 0;
	dcb.StopBits = ONESTOPBIT;
	dcb.ByteSize = 8;
	 
	serialPortHandle = CreateFile(device, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, NULL, NULL);
	 
	if (serialPortHandle != INVALID_HANDLE_VALUE) {
		if(!SetCommState(serialPortHandle,&dcb))
			error=2;
	}
	else {
		error=1;
	}
	 
	if (error!=0) {
		disconnect();
	}
	else {
		clear();
	}

	// Non-blocking
	COMMTIMEOUTS cto;
	GetCommTimeouts(serialPortHandle, &cto);
	// Set the new timeouts
	cto.ReadIntervalTimeout = MAXDWORD;
	cto.ReadTotalTimeoutConstant = 0;
	cto.ReadTotalTimeoutMultiplier = 0;
	SetCommTimeouts(serialPortHandle, &cto);
	 
	return error;
}
 
void SerialPort::disconnect(void) {

	fclose(fpIn);
	fclose(fpOut);

	CloseHandle(serialPortHandle);
	serialPortHandle = INVALID_HANDLE_VALUE;
	 
	//printf("Port 1 has been CLOSED and %d is the file descriptionn", fileDescriptor);
}
 
int SerialPort::sendArray(unsigned char *buffer, int len) {
	unsigned long result;
	 
	if (serialPortHandle!=INVALID_HANDLE_VALUE)
		WriteFile(serialPortHandle, buffer, len, &result, NULL);

	fwrite("\n", sizeof(char), 1, fpOut);
	fwrite(buffer, sizeof(char), len, fpOut);
	 
	return result;
}
 
int SerialPort::getArray (unsigned char *buffer, int len) {
	unsigned long read_nbr;

	memset(buffer, 0, sizeof(buffer));
	 
	read_nbr = 0;
	if (serialPortHandle!=INVALID_HANDLE_VALUE)
	{
		ReadFile(serialPortHandle, buffer, len, &read_nbr, NULL);
	}

	fwrite("\n", sizeof(char), 1, fpIn);
	fwrite(buffer, sizeof(char), read_nbr, fpIn);
	 
	return((int) read_nbr);
}
 
void SerialPort::clear() {
	PurgeComm (serialPortHandle, PURGE_RXCLEAR | PURGE_TXCLEAR);
}