#include "Command.h"
#include <time.h>

#define HSM_SERIAL_NUMBER "123456789"

BOOL connected = FALSE;
BOOL loggedIn = FALSE;
BOOL isAdmin = FALSE;
uint8_t authID = 0;

// Process command
void COMMAND_process(uint8_t * command)
{
	if(command[0] == 'U' && command[1] == 'S' && command[2] == 'E' && command[3] == 'R')
	{
		COMMAND_USER_process(command);
		return;
	}
	else if(command[0] == 'D' && command[1] == 'T' && command[2] == 'S' && command[3] == 'N')
	{
		if(!connected || !loggedIn)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		COMMAND_DATASIGN_process(command);
		return;
	}
	else if(command[0] == 'C' && command[1] == 'R' && command[2] == 'T')
	{
		if(!connected)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected");
			return;
		}

		COMMAND_CERTMGT_process(command);
		return;
	}
	else if(command[0] == 'L' && command[1] == 'O' && command[2] == 'G' && command[3] == 'S')
	{
		if(!connected || !loggedIn)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		COMMAND_LOGS_process(command);
		return;
	}
	else if(command[0] == 'T' && command[1] == 'I' && command[2] == 'M' && command[3] == 'E')
	{
		COMMAND_TIME_process(command);
		return;
	}
	else if(command[0] == 'S' && command[1] == 'E' && command[2] == 'S' && command[3] == 'S')
	{
		COMMAND_SESSION_process(command);
		return;
	}
	else if(command[0] == 'D' && command[1] == 'V' && command[2] == 'C')
	{
		COMMAND_DEVICE_process(command);
		return;
	}
}

void COMMAND_USER_process(uint8_t * command)
{
	if(strcmp(command, "USER_NEW") == 0)
	{
		if(!connected || !loggedIn || !isAdmin)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// New User

		// Expect 32B User PIN
		uint8_t buffer[PIN_SIZE] = {0};
		UART_receive(&buffer[0], PIN_SIZE);

		uint8_t U_PIN[PIN_SIZE] = {0};

		// 32B => User PIN
		memcpy(U_PIN, &buffer[0], PIN_SIZE);

		// Check if it's full
		USER_init();
		if(USER_isFull())
		{
			// Response back with ERROR
			COMMAND_ERROR("ERROR: Users Full");
			return;
		}

		// Get next available ID
		uint8_t U_ID = USER_getNextAvailableID();
		if(!USER_add(U_ID, U_PIN))
		{
			// Respond back with ERROR
			// user already exists - but it shouldn't, our algorithm for finding the next free is wrong
			COMMAND_ERROR("ERROR: User already exists");
			return;
		}

		// Send SUCCESS
		UART_send("SUCCESS", 7);

		uint8_t data[1];
		data[0] = U_ID;
		UART_send(data, 1);
	}
	else if(strcmp(command, "USER_MODIFY") == 0)
	{
		if(!connected || !loggedIn || isAdmin) // admin can't modify PINs
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// Modify PIN

		// Expect PIN
		uint8_t buffer[PIN_SIZE] = {0};
		UART_receive(&buffer[0], PIN_SIZE);

		uint8_t U_PIN[PIN_SIZE] = {0};

		// 32B => New PIN
		memcpy(U_PIN, &buffer[0], PIN_SIZE);

		USER_init();
		USER * u = USER_get(authID);
		if(!u)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: invalid user");
			return;
		}

		memcpy(u->PIN, U_PIN, PIN_SIZE);
		if(!USER_modify(u))
		{
			USER_free(u);

			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Cannot modify PIN");
			return;
		}

		USER_free(u);

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
	else if(strcmp(command, "USER_DELETE") == 0)
	{
		if(!connected || !loggedIn || !isAdmin)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// Delete User

		// Expect 1B User ID
		// Note: buffer must have at least capacity for 1 block (because AES has 16B blocks)
		uint8_t buffer[BLOCK_SIZE] = {0};
		UART_receive(&buffer[0], BLOCK_SIZE);

		uint8_t ID = 0;

		// ID
		ID = buffer[0];

		USER_init();

		USER_remove(ID);

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
	else if(strcmp(command, "USER_GENKEYS") == 0)
	{
		// Generate Key Pair and send it

		if(!connected || !loggedIn || !isAdmin)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// Generate key pair and store it
		uint8_t * privateKey = malloc(sizeof(uint8_t)*ECC_PRIVATE_KEY_SIZE);
		if(!privateKey)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not enough space");
			return;
		}

		uint8_t *  publicKey = malloc(sizeof(uint8_t)*ECC_PUBLIC_KEY_SIZE);
		if(!publicKey)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not enough space");
			return;
		};

		if(!PKC_genKeyPair(publicKey, privateKey))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Generating key pair");
			return;
		}

		// Success
		UART_send("SUCCESS", 7);

		// Send both keys
		UART_send(publicKey, strlen(publicKey));
		UART_send(privateKey, strlen(privateKey));

		free(publicKey);
		free(privateKey);
	}
	else if(strcmp(command, "USER_CERT") == 0)
	{
		// Get certificate of user's public key

		// Expect 1B ID
		// Note: buffer must have at least capacity for 1 block (because AES has 16B blocks)
		uint8_t buffer[BLOCK_SIZE] = {0};
		UART_receive(&buffer[0], BLOCK_SIZE);

		uint8_t U_ID = buffer[0];

		USER_init();
		if(!USER_exists(U_ID))
		{
			// Respond back with ERROR
			// user already exists - but it shouldn't, our algorithm for finding the next free is wrong
			COMMAND_ERROR("ERROR: User does not exist");
			return;
		}

		USER * u = USER_get(U_ID);

		// Send SUCCESS
		UART_send("SUCCESS", 7);

		// Send certificate
		UART_send(u->publicKeyCertificate, strlen(u->publicKeyCertificate)+1);
		
		USER_free(u);
	}
}

void COMMAND_DATASIGN_process(uint8_t * command)
{
	if(strcmp(command, "DTSN_SIGN") == 0)
	{
		if(!connected || !loggedIn || authID == 0) // admin (authID=0) cannot sign data because it has no generated data signing key pair
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// User is requesting a hash to be signed using its private key

		// Expect HASH_SIZE
		uint8_t buffer[HASH_SIZE] = {0};
		UART_receive(&buffer[0], HASH_SIZE);

		uint8_t HASH[HASH_SIZE] = {0};

		memcpy(HASH, &buffer[0], HASH_SIZE);

		uint8_t sig[512] = {0};
		size_t sig_len = 0;

		// Get user private key
		USER * u = USER_get(authID);

		// We have the hash
		// Apply ECDSA
		if(!PKC_signData(u->privateKey, HASH, HASH_SIZE, &sig[0], &sig_len))
		{
			USER_free(u);

			// Respond back with ERROR
			COMMAND_ERROR("ERROR: signature");
			return;
		}

		USER_free(u);

		// Send SUCCESS
		UART_send("SUCCESS", 7);

		// Send signature
		UART_send(sig, sig_len);
	}
	else if(strcmp(command, "DTSN_VERIFY") == 0)
	{
		if(!connected)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// User is requesting a hash and a signature to be verified

		// Note, buffer must be multiple of BLOCK_SIZE for UART_receive
		// Expect 1B ID + 32B hash
		uint8_t buffer[3*BLOCK_SIZE] = {0};
		UART_receive(&buffer[0], 3*BLOCK_SIZE);

		uint8_t U_ID = 0;
		uint8_t HASH[HASH_SIZE] = {0};

		// 1B => U_ID
		U_ID = buffer[0];

		// 32B for hash
		memcpy(HASH, &buffer[1], HASH_SIZE);

		// > 256B shouldn't happen! (unless the points of the curve are huge, e,g. > 1000 bits)
		uint8_t signature[16*BLOCK_SIZE];
		uint32_t signature_len = UART_receive(&signature[0], 16*BLOCK_SIZE);

		// Get user private key
		USER_init();
		if(!USER_exists(U_ID))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: User does not exist");
			return;
		}
		USER * u = USER_get(U_ID);

		// We have the hash
		// Apply ECDSA
		uint8_t res = PKC_verifySignature(u->publicKey, HASH, HASH_SIZE, signature, signature_len);
		USER_free(u);
		if(res == 1)
		{
			// Respond back with ERROR
			UART_send("SIG_ERROR", 9);
			return;
		}
		else if(res == 2)
		{
			UART_send("PUBLIC_KEY_ERROR", 16);
		}
		else if(res == 3)
		{
			UART_send("INCORRECT", 9);
		}
		else
		{
			// Send SUCCESS
			UART_send("SUCCESS", 7);
		}
	}
}

void COMMAND_CERTMGT_process(uint8_t * command)
{
	if(strcmp(command, "CRT_REQUEST") == 0)
	{
		if(!connected || !loggedIn || !isAdmin || authID > 0)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// Admin is requesting a certificate for a public key

		// Buffer size must be a multiple of BLOCK_SIZE
		// Expect subject name + \0 or 0 (should be the same thing) | 2B key usage
		uint8_t buffer[17*BLOCK_SIZE] = {0};
		UART_receive(&buffer[0], 17*BLOCK_SIZE);

		uint8_t SUBJECT_NAME[1*BLOCK_SIZE] = {0}; // subject name shouldn't go over this limit
		uint8_t KEY[ECC_PUBLIC_KEY_SIZE] = {0}; // key shouldn't go over this limit
		uint8_t keyUsageArray[2] = {0};

		// Then go through the subject name until we find \0 or 0
		uint32_t i;
		uint32_t k = 0;
		for(i=0;i<256;i++)
		{
			SUBJECT_NAME[i] = buffer[i];

			if(buffer[i]  == '\0' || buffer[i] == 0)
			{
				// We're at the end of subject name
				k = i+1;
				break;
			}
		}

		keyUsageArray[0] = buffer[k];
		keyUsageArray[1] = buffer[k+1];

		// Convert this back to an integer of 16bits
		uint16_t keyUsage = (0x000000FF & keyUsageArray[0])
			| ((0x000000FF & keyUsageArray[1]) << 8);

		// Get key usage
		/*uint32_t key_usage = 0;
		if(k > 0)
		{
			key_usage = buffer[k];
		}

		switch(key_usage)
		{
			case 0:
				key_usage = MBEDTLS_X509_KU_DIGITAL_SIGNATURE;
			break;
			case 1:
				key_usage = MBEDTLS_X509_KU_NON_REPUDIATION;
			break;
			case 2:
				key_usage = MBEDTLS_X509_KU_KEY_ENCIPHERMENT;
			break;
			case 3:
				key_usage = MBEDTLS_X509_KU_DATA_ENCIPHERMENT;
			break;
			case 4:
				key_usage = MBEDTLS_X509_KU_KEY_AGREEMENT;
			break;
			case 5:
				key_usage = MBEDTLS_X509_KU_KEY_CERT_SIGN;
			break;
			case 6:
				key_usage = MBEDTLS_X509_KU_CRL_SIGN;
			break;
			case 7:
				key_usage = MBEDTLS_X509_KU_ENCIPHER_ONLY;
			break;
			case 8:
				key_usage = MBEDTLS_X509_KU_DECIPHER_ONLY;
			break;
		}*/

		// Except public key now
		UART_receive(KEY, ECC_PUBLIC_KEY_SIZE);

		if(!PKC_createCertificate(KEY, SUBJECT_NAME, keyUsage, &global_buffer[0], GLOBAL_BUFFER_SIZE))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: generating certificate");
			return;
		}

		// Send SUCCESS with Certificate
		UART_send("SUCCESS", 7);

		// Send certificate
		UART_send(global_buffer, strlen(global_buffer)+1);
	}
}

void COMMAND_LOGS_process(uint8_t * command)
{
	if(strcmp(command, "LOGS_ADD") == 0)
	{
		if(!connected || !loggedIn || isAdmin)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// Add a new action to the log
		// 1. Receive 'message' (null terminated string)
		// 2. Append UID, TIME, COUNTER1, COUNTER2
		// 3. Format: TIME: {"message", UID, TIME, COUNTER1, COUNTER2}
		// 4. Generate signature
		// 5. Send back final message + signature

		// Expect message (max 512B)
		uint8_t buffer[512] = {0};
		UART_receive(&buffer[0], 512);

		uint8_t * finalMessage;
		uint8_t signature[128];
		size_t sig_len;
		if(!LOGS_sign(buffer, strlen(buffer), 1, finalMessage, &signature[0], &sig_len))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: signing message");
			return;
		}

		// Send SUCCESS with data + signature
		UART_send("SUCCESS", 7);

		// Send data
		UART_send(global_buffer, strlen(global_buffer)+1); // include null character

		UART_send(signature, sig_len);

		/*// Send sha256 of signature
		uint8_t digest[32] = {0};
		mbedtls_sha256(signature, sig_len, digest, 0);
		UART_send(digest, 32);*/
	}
}

void COMMAND_TIME_process(uint8_t * command)
{
	if(strcmp(command, "TIME_SEND") == 0)
	{
		// Receive the current timestamp

		mss_rtc_calendar_t new_calendar_time;
		MSS_RTC_get_calendar_count(&new_calendar_time);

		// Expect 4B (32bit timestamp)
		// Note: buffer must have at least capacity for 1 block (because AES has 16B blocks)
		uint8_t buffer[BLOCK_SIZE] = {0};
		UART_receive(&buffer[0], BLOCK_SIZE);

		// Convert this back to an integer of 32bits
		time_t timestamp = (0x000000FF & buffer[0])
			| ((0x000000FF & buffer[1]) << 8)
			| ((0x000000FF & buffer[2]) << 16)
			| ((0x000000FF & buffer[3]) << 24);

		struct tm * ptm;
		ptm = gmtime(&timestamp);
		if(ptm == NULL)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: no memory");
			return;
		}

		new_calendar_time.second = ptm->tm_sec;
		new_calendar_time.minute = ptm->tm_min;
		new_calendar_time.hour = ptm->tm_hour;
		new_calendar_time.day = ptm->tm_mday;
		new_calendar_time.month = ptm->tm_mon+1; // time works with months since january (0 being jan) while RTC works with 1 to 12
		new_calendar_time.year = ptm->tm_year-100; // time works with years since 1900, while RTC works with years since 2009
		new_calendar_time.weekday = ptm->tm_wday+1; // time works with days since sunday 80 being sunday) while RTC works with 1-7
		new_calendar_time.week = calculate_week(new_calendar_time.day, new_calendar_time.month,  new_calendar_time.year);

		MSS_RTC_set_calendar_count(&new_calendar_time);

		// Use timestamp as random seed
		#ifndef SECURITY_DEVICE
			srand(timestamp);
		#endif

		free(ptm);
	}
}

void COMMAND_SESSION_process(uint8_t * command)
{
	if(strcmp(command, "SESS_START") == 0)
	{
		UART_connect();

		char key[32] = {0};
		if(!SecComm_start(&key[0]))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: init sec comm");
			return;
		}

		if(!UART_recTime())
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: time error");
			return;
		}

		connected = TRUE;
	}
	else if(strcmp(command, "SESS_END") == 0)
	{
		if(!connected)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected");
			return;
		}

		UART_disconnect();

		//UART_init();

		connected = FALSE;
	}
	else if(strcmp(command, "SESS_LOGIN") == 0)
	{
		if(!connected)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected");
			return;
		}

		if(loggedIn)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: logged in");
			return;
		}

		// login

		// Expect 32B AUTH_PIN + 1B PIN
		uint8_t buffer[3*BLOCK_SIZE] = {0};
		UART_receive(&buffer[0], 3*BLOCK_SIZE);

		uint8_t AUTH_PIN[PIN_SIZE] = {0};
		uint8_t U_ID = 0;

		// First 32B => AUTH_PIN (user)
		memcpy(AUTH_PIN, &buffer[0], PIN_SIZE);

		// 1B => U_ID
		U_ID = buffer[PIN_SIZE];

		// Check if ID matches PIN
		USER_init();
		if(!USER_verify(U_ID, AUTH_PIN))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Not Valid");
			return;
		}

		authID = U_ID;

		isAdmin = FALSE;
		if(U_ID == 0)
			isAdmin = TRUE;

		loggedIn = TRUE;

		// Send SUCCESS
		UART_send("SUCCESS", 7);

		loggedIn = TRUE;
	}
	else if(strcmp(command, "SESS_LOGOUT") == 0)
	{
		if(!connected || !loggedIn)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// Logout

		authID = 0; // even though UID is 0 by default (admin), nothing bad happens as long as isAdmin/loggedIn gets checked when necessary
		isAdmin = FALSE;
		loggedIn = FALSE;

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
}

void COMMAND_DEVICE_process(uint8_t * command)
{
	if(strcmp(command, "DVC_CHECK") == 0)
	{
		// Reply back HSM_SERIAL_NUMBER

		// Send SERIAL with data
		UART_send("SUCCESS", 7);

		// Send data
		UART_send(HSM_SERIAL_NUMBER, strlen(HSM_SERIAL_NUMBER));
	}
}

void COMMAND_ERROR(char * message)
{
	UART_send(message, strlen(message));
	UART_disconnect();
	connected = FALSE;
}
