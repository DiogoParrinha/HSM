#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include <iostream>
#include <list>
#include <vector>

#include "pkcs11_common.h"
#include "HSM.h"

/********************************
********** DEFINITIONS **********
*********************************/

#define MAX_SESSIONS 10
#define MAX_SLOTS 10

CK_FUNCTION_LIST pkcs11_function_list = {
	{ 2, 11 }, /* Note: NSS/Firefox ignores this version number and uses C_GetInfo() */
	C_Initialize,
	C_Finalize,
	C_GetInfo,
	C_GetFunctionList,
	C_GetSlotList,
	C_GetSlotInfo,
	C_GetTokenInfo,
	C_GetMechanismList,
	C_GetMechanismInfo,
	C_InitToken,
	C_InitPIN,
	C_SetPIN,
	C_OpenSession,
	C_CloseSession,
	C_CloseAllSessions,
	C_GetSessionInfo,
	C_GetOperationState,
	C_SetOperationState,
	C_Login,
	C_Logout,
	C_CreateObject,
	C_CopyObject,
	C_DestroyObject,
	C_GetObjectSize,
	C_GetAttributeValue,
	C_SetAttributeValue,
	C_FindObjectsInit,
	C_FindObjects,
	C_FindObjectsFinal,
	C_EncryptInit,
	C_Encrypt,
	C_EncryptUpdate,
	C_EncryptFinal,
	C_DecryptInit,
	C_Decrypt,
	C_DecryptUpdate,
	C_DecryptFinal,
	C_DigestInit,
	C_Digest,
	C_DigestUpdate,
	C_DigestKey,
	C_DigestFinal,
	C_SignInit,
	C_Sign,
	C_SignUpdate,
	C_SignFinal,
	C_SignRecoverInit,
	C_SignRecover,
	C_VerifyInit,
	C_Verify,
	C_VerifyUpdate,
	C_VerifyFinal,
	C_VerifyRecoverInit,
	C_VerifyRecover,
	C_DigestEncryptUpdate,
	C_DecryptDigestUpdate,
	C_SignEncryptUpdate,
	C_DecryptVerifyUpdate,
	C_GenerateKey,
	C_GenerateKeyPair,
	C_WrapKey,
	C_UnwrapKey,
	C_DeriveKey,
	C_SeedRandom,
	C_GenerateRandom,
	C_GetFunctionStatus,
	C_CancelFunction,
	C_WaitForSlotEvent
};

/********************************
************ GLOBALS ************
*********************************/
bool g_init = CK_FALSE;

p11_slot g_slots[MAX_SLOTS];

std::vector<Device*> devices_list;
std::vector<p11_session*> g_sessions;

/********************************
********** PROTOTYPES **********
*********************************/
void strcpy_bp(void * destination, char * source, size_t dest_size);

/********************************
******** GENERAL PURPOSE ********
*********************************/

/*
	Initializes Cryptoki

	Since we don't support multi-threading, the argument must be NULL

	If OK, returned value is CKR_OK

*/
CK_RV C_Initialize(CK_VOID_PTR pInitArgs)
{
	int i;

	if (pInitArgs != NULL_PTR)
	{
		return CKR_ARGUMENTS_BAD;
	}

	if (g_init)
		return CKR_CRYPTOKI_ALREADY_INITIALIZED;

	// init sessions list
	g_sessions.clear();
	/*for (i = 0; i < MAX_SESSIONS; i++)
	{
		g_sessions[i].slotID = 0;
		g_sessions[i].flags = CKF_SERIAL_SESSION; // default (must be set for backwards compatibility)
		g_sessions[i].state = 0;
		g_sessions[i].ulDeviceError = 0;
	}*/

	// add slots with HSM token
	HSM * g_hsm = new HSM();
	if (!g_hsm->init())
		return CKR_FUNCTION_FAILED;

	devices_list.clear();
	for (i = 0; i < MAX_SLOTS; i++)
	{
		devices_list.push_back(g_hsm);
		g_hsm->addSlot(&g_slots[i], i);
	}

	g_init = CK_TRUE;

	return CKR_OK;
}

CK_RV C_Finalize(CK_VOID_PTR pReserved)
{
	if (pReserved != NULL_PTR)
		return CKR_ARGUMENTS_BAD;

	// Clean up
	int i;
	Device * prev = NULL;
	for (i = 0; i < MAX_SLOTS; i++)
	{
		if (devices_list.at(i) != NULL)
		{
			// only attempt to delete if the previously deleted was different from this one
			if (prev != NULL && prev != devices_list.at(i))
			{
				prev = devices_list.at(i);
				delete devices_list.at(i);
			}
			
			devices_list.at(i) = NULL;
		}
	}

	g_init = CK_FALSE;

	return CKR_OK;
}

CK_RV C_GetInfo(CK_INFO_PTR pInfo)
{
	if (pInfo == NULL_PTR)
		return CKR_ARGUMENTS_BAD;

	memset(pInfo, 0, sizeof(CK_INFO));
	pInfo->cryptokiVersion.major = 2;
	pInfo->cryptokiVersion.minor = 20;
	strcpy_bp(pInfo->manufacturerID, "INESC-ID", sizeof(pInfo->manufacturerID));
	strcpy_bp(pInfo->libraryDescription, "INESC-ID HSM PKCS#11 Interface", sizeof(pInfo->libraryDescription));
	pInfo->libraryVersion.major = 0;
	pInfo->libraryVersion.minor = 1;

	return CKR_OK;
}

CK_RV C_GetFunctionList(CK_FUNCTION_LIST_PTR_PTR ppFunctionList)
{
	if (ppFunctionList == NULL_PTR)
		return CKR_ARGUMENTS_BAD;

	*ppFunctionList = &pkcs11_function_list;

	return CKR_OK;
}

/********************************
*** SLOT AND TOKEN MANAGEMENT ***
*********************************/
CK_RV C_GetSlotList(CK_BBOOL tokenPresent, CK_SLOT_ID_PTR pSlotList, CK_ULONG_PTR pulCount)
{
	int h = 0;

	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	if (pulCount == NULL_PTR)
		return CKR_ARGUMENTS_BAD;

	// All slots
	if (tokenPresent == CK_FALSE)
	{
		if (pSlotList == NULL_PTR)
		{
			// Set pulCount to total slots available
			*pulCount = MAX_SLOTS;

			return CKR_OK;
		}

		// We want the list of slots
		// They must pass the buffer size in pulCount
		if (*pulCount < MAX_SLOTS)
		{
			return CKR_BUFFER_TOO_SMALL;
		}
	}
	
	int c = 0;
	for (h = 0; h < MAX_SLOTS; h++)
	{
		if (tokenPresent == CK_TRUE)
		{
			if (g_slots[h].slotInfo.flags & CKF_TOKEN_PRESENT)
			{
				if (pSlotList != NULL_PTR)
				{
					pSlotList[c] = h;
				}

				c++;
			}
		}
		else
		{
			if (pSlotList != NULL_PTR)
			{
				pSlotList[c] = h;
			}

			// we're getting the list of all slots
			if (tokenPresent == CK_FALSE)
				c++;
		}
	}

	*pulCount = c;

	return CKR_OK;
}

CK_RV C_GetSlotInfo(CK_SLOT_ID slotID, CK_SLOT_INFO_PTR pInfo)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	if (pInfo == NULL_PTR)
		return CKR_ARGUMENTS_BAD;

	if (slotID > MAX_SLOTS)
		return CKR_SLOT_ID_INVALID;

	// Copy slot information
	pInfo->firmwareVersion.major = g_slots[slotID].slotInfo.firmwareVersion.major;
	pInfo->firmwareVersion.minor = g_slots[slotID].slotInfo.firmwareVersion.minor;
	pInfo->flags = g_slots[slotID].slotInfo.flags;
	pInfo->hardwareVersion.major = g_slots[slotID].slotInfo.hardwareVersion.major;
	pInfo->hardwareVersion.minor = g_slots[slotID].slotInfo.hardwareVersion.minor;
	strcpy_bp(pInfo->manufacturerID, (char*)g_slots[slotID].slotInfo.manufacturerID, sizeof(pInfo->manufacturerID));
	strcpy_bp(pInfo->slotDescription, (char*)g_slots[slotID].slotInfo.slotDescription, sizeof(pInfo->slotDescription));

	return CKR_OK;
}

CK_RV C_GetTokenInfo(CK_SLOT_ID slotID, CK_TOKEN_INFO_PTR pInfo)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	if (pInfo == NULL_PTR)
		return CKR_ARGUMENTS_BAD;

	if (slotID > MAX_SLOTS)
		return CKR_SLOT_ID_INVALID;

	p11_slot pSlot = g_slots[slotID];
	if (!(pSlot.slotInfo.flags & CKF_TOKEN_PRESENT))
		return CKR_TOKEN_NOT_PRESENT;

	// Copy token information
	pInfo->firmwareVersion.major = pSlot.token->tokenInfo.firmwareVersion.major;
	pInfo->firmwareVersion.minor = pSlot.token->tokenInfo.firmwareVersion.minor;
	pInfo->hardwareVersion.major = pSlot.token->tokenInfo.hardwareVersion.major;
	pInfo->hardwareVersion.minor = pSlot.token->tokenInfo.hardwareVersion.minor;
	pInfo->flags = pSlot.token->tokenInfo.flags;
	pInfo->hardwareVersion.major = pSlot.token->tokenInfo.hardwareVersion.major;
	pInfo->hardwareVersion.minor = pSlot.token->tokenInfo.hardwareVersion.minor;
	strcpy_bp(pInfo->manufacturerID, (char*)pSlot.token->tokenInfo.manufacturerID, sizeof(pInfo->manufacturerID));
	strcpy_bp(pInfo->model, (char*)pSlot.token->tokenInfo.model, sizeof(pInfo->model));
	strcpy_bp(pInfo->label, (char*)pSlot.token->tokenInfo.label, sizeof(pInfo->label));
	strcpy_bp(pInfo->serialNumber, (char*)pSlot.token->tokenInfo.serialNumber, sizeof(pInfo->serialNumber));
	strcpy_bp(pInfo->utcTime, (char*)pSlot.token->tokenInfo.utcTime, sizeof(pInfo->utcTime));

	pInfo->ulMaxSessionCount = pSlot.token->tokenInfo.ulMaxSessionCount;
	pInfo->ulSessionCount = pSlot.token->tokenInfo.ulSessionCount;
	pInfo->ulMaxRwSessionCount = pSlot.token->tokenInfo.ulMaxRwSessionCount;
	pInfo->ulRwSessionCount = pSlot.token->tokenInfo.ulRwSessionCount;
	pInfo->ulMaxPinLen = pSlot.token->tokenInfo.ulMaxPinLen;
	pInfo->ulMinPinLen = pSlot.token->tokenInfo.ulMinPinLen;
	pInfo->ulTotalPublicMemory = pSlot.token->tokenInfo.ulTotalPublicMemory;
	pInfo->ulTotalPrivateMemory = pSlot.token->tokenInfo.ulTotalPrivateMemory;
	pInfo->ulFreePublicMemory = pSlot.token->tokenInfo.ulFreePublicMemory;
	pInfo->ulFreePrivateMemory = pSlot.token->tokenInfo.ulFreePrivateMemory;

	return CKR_OK;
}

CK_RV C_WaitForSlotEvent(CK_FLAGS flags, CK_SLOT_ID_PTR pSlot, CK_VOID_PTR pReserved)
{
	// Possible TODO
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_GetMechanismList(CK_SLOT_ID slotID, CK_MECHANISM_TYPE_PTR pMechanismList, CK_ULONG_PTR pulCount)
{
	// TODO

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_GetMechanismInfo(CK_SLOT_ID slotID, CK_MECHANISM_TYPE type, CK_MECHANISM_INFO_PTR pInfo)
{
	// TODO

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_InitToken(CK_SLOT_ID slotID, CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_UTF8CHAR_PTR pLabel)
{
	/*if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	return CKR_OK;*/

	// We have no use for this function right now
	// in the future we may use it to send the time for example

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_InitPIN(CK_SESSION_HANDLE hSession, CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_SetPIN(CK_SESSION_HANDLE hSession, CK_UTF8CHAR_PTR pOldPin, CK_ULONG ulOldLen, CK_UTF8CHAR_PTR pNewPin, CK_ULONG ulNewLen)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// Modify PIN of logged in user

	return CKR_OK;
}

/*************************
*** SESSION MANAGEMENT ***
**************************/
CK_RV C_OpenSession(CK_SLOT_ID slotID, CK_FLAGS flags, CK_VOID_PTR pApplication, CK_NOTIFY Notify, CK_SESSION_HANDLE_PTR phSession)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	if (!(flags & CKF_SERIAL_SESSION))
	{
		// CKR_PARALLEL_NOT_SUPPORTED doesn't seem to exist
		//return CKR_PARALLEL_NOT_SUPPORTED;
	}

	// How many sessions in the selected token?
	if (devices_list.at(slotID)->sessionLimit())
	{
		// Too many open sessions with device
		return CKR_SESSION_COUNT;
	}

	// Start session
	int r = devices_list.at(slotID)->startSession();
	if (r == 1 || g_sessions.size() >= MAX_SESSIONS)
	{
		// Too many open sessions with device
		return CKR_SESSION_COUNT;
	}

	// NOTE
	// If we had more than 1 session allowed, we'd need to check if we have any SO session open
	// Read-Only session can't be opened when a SO session exists

	CK_SESSION_INFO_PTR session = (CK_SESSION_INFO*)malloc(sizeof(CK_SESSION_INFO));
	session->slotID = slotID;
	session->flags = flags;
	session->ulDeviceError = 0;
	session->state = 0;

	p11_session * session_h = (p11_session*)malloc(sizeof(p11_session));
	session_h->session = session;
	session_h->operation[P11_OP_FIND] = 0;
	session_h->operation[P11_OP_SIGN] = 0;
	session_h->objects = NULL;
	session_h->totalObjects = 0;

	g_sessions.push_back(session_h);

	// set the handle to the size of the vector-1 (regardless of having empty members or not)
	*phSession = g_sessions.size()-1;
	
	return CKR_OK;
}

CK_RV C_CloseSession(CK_SESSION_HANDLE hSession)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// End session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch(const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}
	
	if (s != NULL_PTR)
	{
		Device* d;
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}

		d->endSession();
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	return CKR_OK;
}

CK_RV C_CloseAllSessions(CK_SLOT_ID slotID)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	int r = 0;
	for (std::vector<p11_session*>::iterator it = g_sessions.begin(); it != g_sessions.end(); ++it) {
		/* std::cout << *it; ... */
		r = C_CloseSession(it - g_sessions.begin());
		if (r != CKR_OK)
			return CKR_FUNCTION_FAILED;

		delete g_sessions.at(it - g_sessions.begin());
		g_sessions.at(it - g_sessions.begin()) = NULL_PTR;
	}
	g_sessions.clear();

	return CKR_OK;
}

CK_RV C_GetSessionInfo(CK_SESSION_HANDLE hSession, CK_SESSION_INFO_PTR pInfo)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// TODO

	return CKR_OK;
}

CK_RV C_GetOperationState(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pOperationState, CK_ULONG_PTR pulOperationStateLen)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// TODO

	return CKR_OK;
}

CK_RV C_SetOperationState(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pOperationState, CK_ULONG ulOperationStateLen, CK_OBJECT_HANDLE hEncryptionKey, CK_OBJECT_HANDLE hAuthenticationKey)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_Login(CK_SESSION_HANDLE hSession, CK_USER_TYPE userType, CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	if (userType != CKU_USER && userType != CKU_SO)
	{
		return CKR_USER_TYPE_INVALID;
	}

	// We accept sessions with handle=0
	/*if (hSession == NULL_PTR)
	{
		return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get session device
	Device* d;
	try {
		d = devices_list.at(s->slotID);
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Perform login
	int r = d->login(pPin, ulPinLen, userType);
	if (r == 1)
	{
		return CKR_USER_ALREADY_LOGGED_IN;
	}
	else if (r == 2)
	{
		return CKR_FUNCTION_FAILED;
	}
	else if (r == 3)
	{
		return CKR_PIN_INCORRECT;
	}

	return CKR_OK;
}

CK_RV C_Logout(CK_SESSION_HANDLE hSession)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
		return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get session device
	Device* d;
	try {
		d = devices_list.at(s->slotID);
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Perform login
	int r = d->logout();
	if (r == 1)
	{
		return CKR_USER_NOT_LOGGED_IN;
	}
	else if (r == 2)
	{
		return CKR_FUNCTION_FAILED;
	}
	else if (r == 3)
	{
		return CKR_PIN_INCORRECT;
	}

	return CKR_OK;
}

/*************************
**** OBJECT MANAGEMENT ***
**************************/

CK_RV C_CreateObject(CK_SESSION_HANDLE hSession, CK_ATTRIBUTE_PTR pTemplate, CK_ULONG ulCount, CK_OBJECT_HANDLE_PTR phObject)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
		return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	p11_session * P11_SESSION;
	try {
		P11_SESSION = g_sessions.at(hSession);
		s = P11_SESSION->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get session device
	Device* d;
	try {
		d = devices_list.at(s->slotID);
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	if (pTemplate == NULL_PTR)
	{
		return CKR_ARGUMENTS_BAD;
	}

	// Do we have any objects already?
	CK_OBJECT_HANDLE h = P11_SESSION->totalObjects;
	if (P11_SESSION->objects == NULL)
	{
		// Allocate pointer to array of pointers (with one element so far)
		P11_SESSION->objects = (p11_object **)malloc(sizeof(p11_object *));
		if (P11_SESSION->objects == NULL)
		{
			return CKR_HOST_MEMORY;
		}

		P11_SESSION->objects[h] = NULL;
	}
	else
	{
		// We must realloc our array of pointers
		P11_SESSION->objects = (p11_object**)realloc(P11_SESSION->objects, sizeof(p11_object *)*(P11_SESSION->totalObjects+1));
		if (P11_SESSION->objects == NULL)
		{
			// Ideally we'd free our existing objects...

			return CKR_HOST_MEMORY;
		}

		P11_SESSION->objects[h] = NULL;
	}

	// Allocate our object pointer
	P11_SESSION->objects[h] = (p11_object *)malloc(sizeof(p11_object));
	P11_SESSION->objects[h]->oClass = 0;
	P11_SESSION->objects[h]->oType = 0;
	P11_SESSION->objects[h]->oToken = 0;
	P11_SESSION->objects[h]->oValue = NULL;
	P11_SESSION->totalObjects++;

	int p = 0;
	for (p = 0; p < ulCount; p++)
	{
		if (pTemplate[p].type == CKA_CLASS)
		{
			P11_SESSION->objects[h]->oClass = (*(CK_OBJECT_CLASS*)pTemplate[p].pValue);
		}
		else if (pTemplate[p].type == CKA_KEY_TYPE)
		{
			P11_SESSION->objects[h]->oType = (*(CK_KEY_TYPE*)pTemplate[p].pValue);
		}
		else if (pTemplate[p].type == CKA_TOKEN)
		{
			P11_SESSION->objects[h]->oToken = (*(CK_BBOOL*)pTemplate[p].pValue);
		}
		else if (pTemplate[p].type == CKA_VALUE || pTemplate[p].type == CKA_EC_POINT)
		{
			P11_SESSION->objects[h]->oValue = (CK_BYTE_PTR)malloc(sizeof(CK_BYTE)*pTemplate[p].ulValueLen);
			memcpy(P11_SESSION->objects[h]->oValue, pTemplate[p].pValue, pTemplate[p].ulValueLen * sizeof(CK_BYTE));
			P11_SESSION->objects[h]->oValueLen = pTemplate[p].ulValueLen;
		}
	}

	*phObject = h;

	return CKR_OK;
}

CK_RV C_CopyObject(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE hObject, CK_ATTRIBUTE_PTR pTemplate, CK_ULONG ulCount, CK_OBJECT_HANDLE_PTR phNewObject)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_DestroyObject(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE hObject)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	p11_session * P11_SESSION;
	try {
		P11_SESSION = g_sessions.at(hSession);
		s = P11_SESSION->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get session device
	Device* d;
	try {
		d = devices_list.at(s->slotID);
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Do we have any objects already?
	CK_OBJECT_HANDLE h = P11_SESSION->totalObjects;
	if (P11_SESSION->objects == NULL)
	{
		return CKR_OBJECT_HANDLE_INVALID;
	}
	else
	{
		// Delete the selected object
		free(P11_SESSION->objects[hObject]->oValue);
		free(P11_SESSION->objects[hObject]);
		P11_SESSION->objects[hObject] = NULL;
	}

	// DO NOT DECREASE TOTAL OBJECTS BECAUSE WE USE THAT AS HANDLE POINTER

	return CKR_OK;
}

CK_RV C_GetObjectSize(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE hObject, CK_ULONG_PTR pulSize)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_GetAttributeValue(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE hObject, CK_ATTRIBUTE_PTR pTemplate, CK_ULONG ulCount)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	p11_session * P11_SESSION;
	try {
		P11_SESSION = g_sessions.at(hSession);
		s = P11_SESSION->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get session device
	Device* d;
	try {
		d = devices_list.at(s->slotID);
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Do we have any objects already?
	if (P11_SESSION->objects == NULL || (P11_SESSION->totalObjects-1) < hObject)
	{
		return CKR_OBJECT_HANDLE_INVALID;
	}
	
	int p = 0;
	for (p = 0; p < ulCount; p++)
	{
		if (pTemplate[p].type == CKA_CLASS)
		{
			if (pTemplate[p].pValue == NULL_PTR)
			{
				// Modify length to contain value size
				pTemplate[p].ulValueLen = sizeof(P11_SESSION->objects[hObject]->oClass);
			}
			else
			{
				if (pTemplate[p].ulValueLen < sizeof(P11_SESSION->objects[hObject]->oClass))
				{
					pTemplate[p].ulValueLen = -1;
					return CKR_BUFFER_TOO_SMALL;
				}

				CK_OBJECT_CLASS_PTR ptr = (CK_OBJECT_CLASS_PTR)pTemplate[p].pValue;
				*ptr = P11_SESSION->objects[hObject]->oClass;
			}
		}
		else if (pTemplate[p].type == CKA_KEY_TYPE)
		{
			if (pTemplate[p].pValue == NULL_PTR)
			{
				// Modify length to contain value size
				pTemplate[p].ulValueLen = sizeof(P11_SESSION->objects[hObject]->oType);
			}
			else
			{
				if (pTemplate[p].ulValueLen < sizeof(P11_SESSION->objects[hObject]->oType))
				{
					pTemplate[p].ulValueLen = -1;
					return CKR_BUFFER_TOO_SMALL;
				}

				CK_OBJECT_CLASS_PTR ptr = (CK_OBJECT_CLASS_PTR)pTemplate[p].pValue;
				*ptr = P11_SESSION->objects[hObject]->oType;
			}
		}
		else if (pTemplate[p].type == CKA_TOKEN)
		{
			if (pTemplate[p].pValue == NULL_PTR)
			{
				// Modify length to contain value size
				pTemplate[p].ulValueLen = sizeof(P11_SESSION->objects[hObject]->oToken);
			}
			else
			{
				if (pTemplate[p].ulValueLen < sizeof(P11_SESSION->objects[hObject]->oToken))
				{
					pTemplate[p].ulValueLen = -1;
					return CKR_BUFFER_TOO_SMALL;
				}

				CK_OBJECT_CLASS_PTR ptr = (CK_OBJECT_CLASS_PTR)pTemplate[p].pValue;
				*ptr = P11_SESSION->objects[hObject]->oToken;
			}
		}
		else if (pTemplate[p].type == CKA_VALUE || pTemplate[p].type == CKA_EC_POINT)
		{
			if (pTemplate[p].pValue == NULL_PTR)
			{
				// Modify length to contain value size
				pTemplate[p].ulValueLen = sizeof(CK_BYTE)*P11_SESSION->objects[hObject]->oValueLen;
			}
			else
			{
				if (pTemplate[p].ulValueLen < sizeof(CK_BYTE)*P11_SESSION->objects[hObject]->oValueLen)
				{
					pTemplate[p].ulValueLen = -1;
					return CKR_BUFFER_TOO_SMALL;
				}

				memcpy(pTemplate[p].pValue, P11_SESSION->objects[hObject]->oValue, sizeof(CK_BYTE)*P11_SESSION->objects[hObject]->oValueLen);
			}
		}
	}

	return CKR_OK;
}

CK_RV C_SetAttributeValue(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE hObject, CK_ATTRIBUTE_PTR pTemplate, CK_ULONG ulCount)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_FindObjectsInit(CK_SESSION_HANDLE hSession, CK_ATTRIBUTE_PTR pTemplate, CK_ULONG ulCount)
{
	return CKR_FUNCTION_NOT_SUPPORTED;

	/*if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}*/

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
		return CKR_SESSION_HANDLE_INVALID;
	}*/

	/*if (pTemplate == NULL_PTR)
	{
		return CKR_ARGUMENTS_BAD;
	}
	
	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	if (s != NULL_PTR)
	{
		Device* d;
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Check parameters (we only care about CKA_CLASS and CKA_KEY_TYPE...)
	// We can only search for certificates!
	// And uids > 0
	uint32_t uid = 0;
	int p = 0;
	for (p = 0; p < ulCount; p++)
	{
		if (pTemplate[p].type == CKA_CLASS)
			if ((*(int*)pTemplate[p].pValue) != CKO_CERTIFICATE)
				return CKR_TEMPLATE_INCONSISTENT;

		if (pTemplate[p].type == CKA_ID)
			if ((*(int*)pTemplate[p].pValue) <= 0)
				return CKR_TEMPLATE_INCONSISTENT;
			else
				uid = (*(int*)pTemplate[p].pValue);
	}

	if (uid <= 0)
		return CKR_TEMPLATE_INCOMPLETE;

	// Is the selected session performing finding?
	if (g_sessions.at(hSession)->operation[P11_OP_FIND] == 1)
	{
		return CKR_OPERATION_ACTIVE;
	}

	g_sessions.at(hSession)->operation[P11_OP_FIND] = 1;
	g_sessions.at(hSession)->certUID = uid;
	g_sessions.at(hSession)->certAlready = false;

	return CKR_OK;*/
}

CK_RV C_FindObjects(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE_PTR phObject, CK_ULONG ulMaxObjectCount, CK_ULONG_PTR pulObjectCount)
{
	return CKR_FUNCTION_NOT_SUPPORTED;

	/*if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	if (ulMaxObjectCount > 1)
	{
		// Ignore...we only get one certificate
	}

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Is the selected session performing object finding?
	if (g_sessions.at(hSession)->operation[P11_OP_FIND] == 0)
	{
		return CKR_OPERATION_NOT_INITIALIZED;
	}

	if (g_sessions.at(hSession)->certAlready == true)
	{
		*pulObjectCount = 0;
		return CKR_OK;
	}

	if(!d->getCertificate(g_sessions.at(hSession)->certUID))
	{
		g_sessions.at(hSession)->certAlready = true;
		*pulObjectCount = 0;

		return CKR_FUNCTION_FAILED;
	}

	g_sessions.at(hSession)->certAlready = true;

	return CKR_OK;*/
}

CK_RV C_FindObjectsFinal(CK_SESSION_HANDLE hSession)
{
	return CKR_FUNCTION_NOT_SUPPORTED;

	/*g_sessions.at(hSession)->operation[P11_OP_FIND] = 0;
	g_sessions.at(hSession)->certAlready = false;
	g_sessions.at(hSession)->certUID = 0;

	return CKR_OK;*/
}

/*************************
******* ENCRYPTION *******
**************************/

CK_RV C_EncryptInit(CK_SESSION_HANDLE hSession, CK_MECHANISM_PTR pMechanism, CK_OBJECT_HANDLE hKey)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_Encrypt(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pEncryptedData, CK_ULONG_PTR pulEncryptedDataLen)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_EncryptUpdate(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pPart, CK_ULONG ulPartLen, CK_BYTE_PTR pEncryptedPart, CK_ULONG_PTR pulEncryptedPartLen)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_EncryptFinal(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pLastEncryptedPart, CK_ULONG_PTR pulLastEncryptedPartLen)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

/*************************
******* DECRYPTION *******
**************************/

CK_RV C_DecryptInit(CK_SESSION_HANDLE hSession, CK_MECHANISM_PTR pMechanism, CK_OBJECT_HANDLE hKey)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_Decrypt(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pEncryptedData, CK_ULONG ulEncryptedDataLen, CK_BYTE_PTR pData, CK_ULONG_PTR pulDataLen)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_DecryptUpdate(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pEncryptedPart, CK_ULONG ulEncryptedPartLen, CK_BYTE_PTR pPart, CK_ULONG_PTR pulPartLen)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_DecryptFinal(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pLastPart, CK_ULONG_PTR pulLastPartLen)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

/*************************
***** MESSAGE DIGEST *****
**************************/

CK_RV C_DigestInit(CK_SESSION_HANDLE hSession, CK_MECHANISM_PTR pMechanism)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_Digest(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pDigest, CK_ULONG_PTR pulDigestLen)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_DigestUpdate(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pPart, CK_ULONG ulPartLen)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_DigestKey(CK_SESSION_HANDLE hSession, CK_OBJECT_HANDLE hKey)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_DigestFinal(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pDigest, CK_ULONG_PTR pulDigestLen)
{
	// N/D

	return CKR_FUNCTION_NOT_SUPPORTED;
}

/*************************
*** CREATE SIGNATURES ****
**************************/

CK_RV C_SignInit(CK_SESSION_HANDLE hSession, CK_MECHANISM_PTR pMechanism, CK_OBJECT_HANDLE hKey)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	if (pMechanism->mechanism != CKM_ECDSA)
		return CKR_MECHANISM_INVALID;

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
		return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	if (s != NULL_PTR)
	{
		Device* d;
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Is the selected session performing data signing?
	if (g_sessions.at(hSession)->operation[P11_OP_SIGN] == 1)
	{
		return CKR_OPERATION_ACTIVE;
	}

	// Key object must be NULL_PTR (the HSM uses internal keys)
	if (hKey != NULL_PTR)
	{
		return CKR_KEY_HANDLE_INVALID;
	}

	// session is performing data signing
	g_sessions.at(hSession)->operation[P11_OP_SIGN] = 1;

	g_sessions.at(hSession)->signData = NULL;
	g_sessions.at(hSession)->signData_s = 0;

	return CKR_OK;
}

CK_RV C_Sign(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Is the selected session performing data signing?
	if (g_sessions.at(hSession)->operation[P11_OP_SIGN] == 0)
	{
		return CKR_OPERATION_NOT_INITIALIZED;
	}

	if (pData == NULL_PTR)
		return CKR_DATA_INVALID;

	if (ulDataLen == 0)
		return CKR_DATA_LEN_RANGE;

	// Did we run signUpdate already?
	if (g_sessions.at(hSession)->update == true)
	{
		return CKR_FUNCTION_FAILED;
	}
	
	// Signature
	if (pSignature == NULL_PTR)
	{
		*pulSignatureLen = 512; // should handle most signatures...
		return CKR_OK;
	}

	g_sessions.at(hSession)->operation[P11_OP_SIGN] = 0;

	if (!d->signData(pData, ulDataLen, pSignature, pulSignatureLen))
	{

		return CKR_FUNCTION_FAILED;
	}
	
	return CKR_OK;
}

CK_RV C_SignUpdate(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pPart, CK_ULONG ulPartLen)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	if (s != NULL_PTR)
	{
		Device* d;
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Is the selected session performing data signing?
	if (g_sessions.at(hSession)->operation[P11_OP_SIGN] == 0)
	{
		return CKR_OPERATION_NOT_INITIALIZED;
	}
	
	// We're doing an update operation
	g_sessions.at(hSession)->update = true;

	// Realloc
	g_sessions.at(hSession)->signData = (uint8_t*)realloc(g_sessions.at(hSession)->signData, g_sessions.at(hSession)->signData_s + ulPartLen);
	if (g_sessions.at(hSession)->signData == NULL)
	{
		return CKR_HOST_MEMORY;
	}

	// Copy data
	memcpy(g_sessions.at(hSession)->signData+ g_sessions.at(hSession)->signData_s, pPart, ulPartLen);

	g_sessions.at(hSession)->signData_s += ulPartLen;

	return CKR_OK;
}

CK_RV C_SignFinal(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Is the selected session performing data signing?
	if (g_sessions.at(hSession)->operation[P11_OP_SIGN] == 0)
	{
		return CKR_OPERATION_NOT_INITIALIZED;
	}

	// Didn't we run signUpdate yet?
	if (g_sessions.at(hSession)->update == false)
	{
		return CKR_FUNCTION_FAILED;
	}

	// Obtain signature
	if (!d->signData(g_sessions.at(hSession)->signData, g_sessions.at(hSession)->signData_s, pSignature, pulSignatureLen))
	{

		return CKR_FUNCTION_FAILED;
	}

	g_sessions.at(hSession)->operation[P11_OP_SIGN] = 0;
	g_sessions.at(hSession)->update = false;

	return CKR_OK;
}

CK_RV C_SignRecoverInit(CK_SESSION_HANDLE hSession, CK_MECHANISM_PTR pMechanism, CK_OBJECT_HANDLE hKey)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_SignRecover(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG_PTR pulSignatureLen)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

/*************************
*** VERIFY SIGNATURES ****
**************************/

CK_RV C_VerifyInit(CK_SESSION_HANDLE hSession, CK_MECHANISM_PTR pMechanism, CK_OBJECT_HANDLE hKey)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	if (pMechanism->mechanism != CKM_ECDSA)
		return CKR_MECHANISM_INVALID;

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	if (s != NULL_PTR)
	{
		Device* d;
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Is the selected session performing digital signatures verification?
	if (g_sessions.at(hSession)->operation[P11_OP_VERIFY] == 1)
	{
		return CKR_OPERATION_ACTIVE;
	}

	// Key object must be NULL_PTR (the HSM uses internal keys)
	if (hKey != NULL_PTR)
	{
		return CKR_KEY_HANDLE_INVALID;
	}

	// session is performing data signing
	g_sessions.at(hSession)->operation[P11_OP_VERIFY] = 1;

	g_sessions.at(hSession)->verifyData = NULL;
	g_sessions.at(hSession)->verifyData_s = 0;

	return CKR_OK;
}

CK_RV C_Verify(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pData, CK_ULONG ulDataLen, CK_BYTE_PTR pSignature, CK_ULONG ulSignatureLen)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Is the selected session performing data signatures verification?
	if (g_sessions.at(hSession)->operation[P11_OP_VERIFY] == 0)
	{
		return CKR_OPERATION_NOT_INITIALIZED;
	}

	if (pData == NULL_PTR)
		return CKR_DATA_INVALID;

	if (ulDataLen == 0)
		return CKR_DATA_LEN_RANGE;

	// Did we run signUpdate already?
	if (g_sessions.at(hSession)->update == true)
	{
		return CKR_FUNCTION_FAILED;
	}

	g_sessions.at(hSession)->operation[P11_OP_VERIFY] = 0;

	if (!d->verifySignature(pData, ulDataLen, pSignature, ulSignatureLen))
	{

		return CKR_SIGNATURE_INVALID;
	}

	return CKR_OK;
}

CK_RV C_VerifyUpdate(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pPart, CK_ULONG ulPartLen)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	if (s != NULL_PTR)
	{
		Device* d;
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Is the selected session performing data signatures verification?
	if (g_sessions.at(hSession)->operation[P11_OP_VERIFY] == 0)
	{
		return CKR_OPERATION_NOT_INITIALIZED;
	}

	// We're doing an update operation
	g_sessions.at(hSession)->update = true;

	// Realloc
	g_sessions.at(hSession)->verifyData = (uint8_t*)realloc(g_sessions.at(hSession)->verifyData, g_sessions.at(hSession)->verifyData_s + ulPartLen);
	if (g_sessions.at(hSession)->verifyData == NULL)
	{
		return CKR_HOST_MEMORY;
	}

	// Copy data
	memcpy(g_sessions.at(hSession)->verifyData + g_sessions.at(hSession)->verifyData_s, pPart, ulPartLen);

	g_sessions.at(hSession)->verifyData_s += ulPartLen;

	return CKR_OK;
}

CK_RV C_VerifyFinal(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pSignature, CK_ULONG ulSignatureLen)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Is the selected session performing data signatures verification?
	if (g_sessions.at(hSession)->operation[P11_OP_VERIFY] == 0)
	{
		return CKR_OPERATION_NOT_INITIALIZED;
	}

	// Didn't we run verifyUpdate yet?
	if (g_sessions.at(hSession)->update == false)
	{
		return CKR_FUNCTION_FAILED;
	}

	// Obtain signature
	if (!d->verifySignature(g_sessions.at(hSession)->verifyData, g_sessions.at(hSession)->verifyData_s, pSignature, ulSignatureLen))
	{

		return CKR_SIGNATURE_INVALID;
	}

	g_sessions.at(hSession)->operation[P11_OP_VERIFY] = 0;
	g_sessions.at(hSession)->update = false;

	return CKR_OK;
}

CK_RV C_VerifyRecoverInit(CK_SESSION_HANDLE hSession, CK_MECHANISM_PTR pMechanism, CK_OBJECT_HANDLE hKey)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_VerifyRecover(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pSignature, CK_ULONG ulSignatureLen, CK_BYTE_PTR pData, CK_ULONG_PTR pulDataLen)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

/*************************
** DUAL-FUNCTION CRYPTO **
**************************/

CK_RV C_DigestEncryptUpdate(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pPart, CK_ULONG ulPartLen, CK_BYTE_PTR pEncryptedPart, CK_ULONG_PTR pulEncryptedPartLen)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_DecryptDigestUpdate(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pEncryptedPart, CK_ULONG ulEncryptedPartLen, CK_BYTE_PTR pPart, CK_ULONG_PTR pulPartLen)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_SignEncryptUpdate(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pPart, CK_ULONG ulPartLen, CK_BYTE_PTR pEncryptedPart, CK_ULONG_PTR pulEncryptedPartLen)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_DecryptVerifyUpdate(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pEncryptedPart, CK_ULONG ulEncryptedPartLen, CK_BYTE_PTR pPart, CK_ULONG_PTR pulPartLen)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

/*************************
***** KEY MANAGEMENT *****
**************************/

CK_RV C_GenerateKey(CK_SESSION_HANDLE hSession, CK_MECHANISM_PTR pMechanism, CK_ATTRIBUTE_PTR pTemplate, CK_ULONG ulCount, CK_OBJECT_HANDLE_PTR phKey)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_GenerateKeyPair(CK_SESSION_HANDLE hSession,
	CK_MECHANISM_PTR pMechanism,
	CK_ATTRIBUTE_PTR pPublicKeyTemplate,
	CK_ULONG ulPublicKeyAttributeCount,
	CK_ATTRIBUTE_PTR pPrivateKeyTemplate,
	CK_ULONG ulPrivateKeyAttributeCount,
	CK_OBJECT_HANDLE_PTR phPublicKey,
	CK_OBJECT_HANDLE_PTR phPrivateKey)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
		return CKR_SESSION_HANDLE_INVALID;
	}*/

	if (pMechanism->mechanism != CKM_EC_KEY_PAIR_GEN)
		return CKR_MECHANISM_INVALID;

	if (pPublicKeyTemplate == NULL_PTR || pPrivateKeyTemplate == NULL_PTR)
		return CKR_TEMPLATE_INCONSISTENT;

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Check parameters (we only care about CKA_CLASS and CKA_KEY_TYPE...)
	uint32_t p = 0;
	for (p = 0; p < ulPublicKeyAttributeCount; p++)
	{
		if (pPublicKeyTemplate[p].type == CKA_CLASS)
			if ((*(int*)pPublicKeyTemplate[p].pValue) != CKO_PUBLIC_KEY)
				return CKR_TEMPLATE_INCONSISTENT;

		if (pPrivateKeyTemplate[p].type == CKA_KEY_TYPE)
			if ((*(int*)pPrivateKeyTemplate[p].pValue) != CKK_EC)
				return CKR_TEMPLATE_INCONSISTENT;
	}

	for (p = 0; p < ulPrivateKeyAttributeCount; p++)
	{
		if (pPrivateKeyTemplate[p].type == CKA_CLASS)
			if ((*(int*)pPrivateKeyTemplate[p].pValue) != CKO_PRIVATE_KEY)
				return CKR_TEMPLATE_INCONSISTENT;

		if (pPrivateKeyTemplate[p].type == CKA_KEY_TYPE)
			if ((*(int*)pPrivateKeyTemplate[p].pValue) != CKK_EC)
				return CKR_TEMPLATE_INCONSISTENT;
	}

	CK_OBJECT_HANDLE privateKey;
	CK_OBJECT_HANDLE publicKey;

	// Either return both keys or none (with their CKA_LOCAL attribute set to CK_TRUE)
	if (!d->generateKeyPair(hSession, &privateKey, &publicKey))
	{
		return CKR_FUNCTION_FAILED;
	}

	*phPrivateKey = privateKey;
	*phPublicKey = publicKey;

	return CKR_OK;
}

CK_RV C_WrapKey(CK_SESSION_HANDLE hSession,
	CK_MECHANISM_PTR pMechanism,
	CK_OBJECT_HANDLE hWrappingKey,
	CK_OBJECT_HANDLE hKey,
	CK_BYTE_PTR pWrappedKey,
	CK_ULONG_PTR pulWrappedKeyLen)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_UnwrapKey(CK_SESSION_HANDLE hSession,
	CK_MECHANISM_PTR pMechanism,
	CK_OBJECT_HANDLE hUnwrappingKey,
	CK_BYTE_PTR pWrappedKey,
	CK_ULONG ulWrappedKeyLen,
	CK_ATTRIBUTE_PTR pTemplate,
	CK_ULONG ulAttributeCount,
	CK_OBJECT_HANDLE_PTR phKey)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_DeriveKey(CK_SESSION_HANDLE hSession,
	CK_MECHANISM_PTR pMechanism,
	CK_OBJECT_HANDLE hBaseKey,
	CK_ATTRIBUTE_PTR pTemplate,
	CK_ULONG ulAttributeCount,
	CK_OBJECT_HANDLE_PTR phKey)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

/*************************
*** RANDOM NUMBER GEN ****
**************************/

CK_RV C_SeedRandom(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pSeed, CK_ULONG ulSeedLen)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_GenerateRandom(CK_SESSION_HANDLE hSession, CK_BYTE_PTR pRandomData, CK_ULONG ulRandomLen)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

/*************************
*** PARALLEL FUNCTIONS ***
**************************/

CK_RV C_GetFunctionStatus(CK_SESSION_HANDLE hSession)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

CK_RV C_CancelFunction(CK_SESSION_HANDLE hSession)
{
	return CKR_FUNCTION_NOT_SUPPORTED;
}

/*************************
*** EXTRA FUNCTIONS ***
**************************/

// HSM_C_UserAdd
CK_RV HSM_C_UserAdd(CK_SESSION_HANDLE hSession, CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen, CK_BYTE_PTR uID)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	if (pPin == NULL || ulPinLen <= 0)
	{
		return ERROR_BAD_ARGUMENTS;
	}

	if (!d->addUser(pPin, ulPinLen, uID))
	{
		return CKR_FUNCTION_FAILED;
	}

	return CKR_OK;
}

// HSM_C_UserModify
CK_RV HSM_C_UserModify(CK_SESSION_HANDLE hSession, CK_UTF8CHAR_PTR pPin, CK_ULONG ulPinLen)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	if (pPin == NULL || ulPinLen <= 0)
	{
		return ERROR_BAD_ARGUMENTS;
	}

	if (!d->modifyUser(pPin, ulPinLen))
	{
		return CKR_FUNCTION_FAILED;
	}

	return CKR_OK;
}

// HSM_C_UserDelete
CK_RV HSM_C_UserDelete(CK_SESSION_HANDLE hSession, CK_BYTE pUid)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
	return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	if (pUid <= 0)
	{
		return ERROR_BAD_ARGUMENTS;
	}

	if (!d->deleteUser(pUid))
	{
		return CKR_FUNCTION_FAILED;
	}

	return CKR_OK;
}

// HSM_C_LogAdd
CK_RV HSM_C_LogAdd(CK_SESSION_HANDLE hSession, CK_UTF8CHAR_PTR pMessage)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// We accept handle=0
	/*if (hSession == NULL_PTR)
	{
		return CKR_SESSION_HANDLE_INVALID;
	}*/

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	// TODO

	return CKR_OK;
}

// HSM_C_LogGet
CK_RV HSM_C_LogGet(HANDLE hSession, CK_ULONG lNumber, CK_UTF8CHAR_PTR pLog, CK_ULONG_PTR logSize)
{
	// TODO

	return CKR_OK;
}

// HSM_C_LogGetHash
CK_RV HSM_C_LogGetHash(CK_SESSION_HANDLE hSession, CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize)
{
	// TODO

	return CKR_OK;
}

// HSM_C_LogGetDayHash
CK_RV HSM_C_LogGetDayHash(CK_SESSION_HANDLE hSession, CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize)
{
	// TODO

	return CKR_OK;
}

// HSM_C_LogGetMonthHash
CK_RV HSM_C_LogGetMonthHash(CK_SESSION_HANDLE hSession, CK_ULONG lNumber, CK_UTF8CHAR_PTR pHash, CK_ULONG_PTR hashSize)
{
	// TODO

	return CKR_OK;
}

// HSM_C_LogVerify
CK_RV HSM_C_LogVerify(CK_SESSION_HANDLE hSession, CK_ULONG lNumber)
{
	// TODO

	return CKR_OK;
}

// HSM_C_LogVerifyDayHash
CK_RV HSM_C_LogVerifyDayHash(CK_SESSION_HANDLE hSession, CK_ULONG lNumber)
{
	// TODO

	return CKR_OK;
}

// HSM_C_LogCounter
CK_RV HSM_C_LogCounter(CK_SESSION_HANDLE hSession, CK_ULONG_PTR lNumber1, CK_ULONG_PTR lNumber2)
{
	// TODO

	return CKR_OK;
}


// HSM_C_CertGen
CK_RV HSM_C_CertGen(CK_SESSION_HANDLE hSession, CK_ATTRIBUTE_PTR publicKeyTemplate, CK_ULONG ulCount, CK_UTF8CHAR_PTR publicKey, CK_UTF8CHAR_PTR certificate, CK_ULONG_PTR bufSize)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	if (publicKey == NULL_PTR)
		return ERROR_BAD_ARGUMENTS;

	if (publicKeyTemplate == NULL_PTR)
		return CKR_TEMPLATE_INCOMPLETE;

	if (!d->genCertificate(publicKeyTemplate, ulCount, publicKey, certificate, bufSize))
	{
		return CKR_FUNCTION_FAILED;
	}

	return CKR_OK;
}

// HSM_C_CertGet
CK_RV HSM_C_CertGet(CK_SESSION_HANDLE hSession, CK_BYTE pUid, CK_UTF8CHAR_PTR certificate, CK_ULONG_PTR bufSize)
{
	if (!g_init)
	{
		return CKR_CRYPTOKI_NOT_INITIALIZED;
	}

	// Get session
	CK_SESSION_INFO_PTR s;
	try {
		s = g_sessions.at(hSession)->session;
	}
	catch (const std::out_of_range&) {
		// 'out of range' error
		return CKR_SESSION_HANDLE_INVALID;
	}

	// Get device
	Device* d;
	if (s != NULL_PTR)
	{
		try {
			d = devices_list.at(s->slotID);
		}
		catch (const std::out_of_range&) {
			// 'out of range' error
			return CKR_SESSION_HANDLE_INVALID;
		}
	}
	else
	{
		return CKR_SESSION_HANDLE_INVALID;
	}

	if (pUid <= 0)
		return ERROR_BAD_ARGUMENTS;

	if (!d->getCertificate(pUid, &certificate, bufSize))
	{
		return CKR_FUNCTION_FAILED;
	}

	return CKR_OK;
}

/*************************
***** OTHER FUNCTIONS ****
**************************/

void strcpy_bp(void * destination, char * source, size_t dest_size)
{
	int c = strlen(source) > dest_size ? dest_size : strlen(source);

	memcpy((char *)destination, source, c);
	dest_size -= c;
	memset((char *)destination + c, ' ', dest_size);
}