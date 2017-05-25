#include "Command.h"
#include <time.h>
#include <sys/time.h>

#define HSM_SERIAL_NUMBER "123456789"

uint8_t authID = 0;

void COMMAND_inited()
{
	system_status |= STATUS_INITED;

	// Up to 18446744073709551616 entries
	LOGS_globalCounter1 = 0;
	LOGS_globalCounter2 = 0;
}

// Process command
void COMMAND_process(uint8_t * command)
{
	if(command[0] == 'U' && command[1] == 'S' && command[2] == 'E' && command[3] == 'R')
	{
		if(!(system_status & STATUS_INITED))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not initialized");
			return;
		}

		COMMAND_USER_process(command);
		return;
	}
	else if(command[0] == 'D' && command[1] == 'T' && command[2] == 'S' && command[3] == 'N')
	{
		if(!(system_status & STATUS_INITED))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not initialized");
			return;
		}

		// DTSN commands require a secure connection and auth
		if(!(system_status & STATUS_CONNECTED) || !(system_status & STATUS_LOGGEDIN))
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
		if(!(system_status & STATUS_INITED))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not initialized");
			return;
		}

		COMMAND_CERTMGT_process(command);
		return;
	}
	else if(command[0] == 'L' && command[1] == 'O' && command[2] == 'G' && command[3] == 'S')
	{
		if(!(system_status & STATUS_INITED))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not initialized");
			return;
		}

		// LOGS commands require a secure connection
		if(!(system_status & STATUS_CONNECTED))
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
		if(!(system_status & STATUS_INITED))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not initialized");
			return;
		}

		COMMAND_TIME_process(command);
		return;
	}
	else if(command[0] == 'S' && command[1] == 'E' && command[2] == 'S' && command[3] == 'S')
	{
		if(!(system_status & STATUS_INITED))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not initialized");
			return;
		}

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
		if(!(system_status & STATUS_CONNECTED) || !(system_status & STATUS_LOGGEDIN) || !(system_status & STATUS_ISADMIN))
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
		// admin can't modify PINs
		if(!(system_status & STATUS_CONNECTED) || !(system_status & STATUS_LOGGEDIN) || (system_status & STATUS_ISADMIN))
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
		if(!(system_status & STATUS_CONNECTED) || !(system_status & STATUS_LOGGEDIN) || !(system_status & STATUS_ISADMIN))
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

		USER_remove(ID);

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
	else if(strcmp(command, "USER_GENKEYS") == 0)
	{
		// Generate Key Pair and send it
		// Admins cannot generate key pairs
		if(!(system_status & STATUS_CONNECTED) || !(system_status & STATUS_LOGGEDIN) || (system_status & STATUS_ISADMIN))
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
		// admin (authID=0) cannot sign data because it has no generated data signing key pair
		if(!(system_status & STATUS_CONNECTED) || !(system_status & STATUS_LOGGEDIN) || (system_status & STATUS_ISADMIN))
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
		if(!(system_status & STATUS_CONNECTED))
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
		// Secure connection, auth, admin
		if(!(system_status & STATUS_CONNECTED) || !(system_status & STATUS_LOGGEDIN) || !(system_status & STATUS_ISADMIN))
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

		uint8_t SUBJECT_NAME[16*BLOCK_SIZE] = {0}; // subject name shouldn't go over this limit
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
	else if(strcmp(command, "CRT_GET_LOGS") == 0)
	{
		uint8_t SUBJECT_NAME[16*BLOCK_SIZE] = "CN=HSM, O=HSM, C=PT"; // subject name shouldn't go over this limit
		uint16_t keyUsage = MBEDTLS_X509_KU_DIGITAL_SIGNATURE;

		if(!PKC_createCertificate(LOGS_PUBLIC_KEY, SUBJECT_NAME, keyUsage, &global_buffer[0], GLOBAL_BUFFER_SIZE))
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
	else if(strcmp(command, "CRT_GET_SESSION") == 0)
	{
		uint8_t SUBJECT_NAME[16*BLOCK_SIZE] = "CN=HSM, O=HSM, C=PT"; // subject name shouldn't go over this limit
		uint16_t keyUsage = MBEDTLS_X509_KU_DIGITAL_SIGNATURE;

		if(!PKC_createCertificate(SESS_PUBLIC_KEY, SUBJECT_NAME, keyUsage, &global_buffer[0], GLOBAL_BUFFER_SIZE))
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
	else if(strcmp(command, "CRT_GET_ISSUER") == 0)
	{
		uint8_t SUBJECT_NAME[16*BLOCK_SIZE] = "CN=HSM, O=HSM, C=PT"; // subject name shouldn't go over this limit
		uint16_t keyUsage = MBEDTLS_X509_KU_DIGITAL_SIGNATURE;

		if(!PKC_createCertificate(ISSUER_PUBLIC_KEY, SUBJECT_NAME, keyUsage, &global_buffer[0], GLOBAL_BUFFER_SIZE))
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
		// Secure connection, logged in, not admin
		if(!(system_status & STATUS_CONNECTED) || !(system_status & STATUS_LOGGEDIN) || (system_status & STATUS_ISADMIN))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// Add a new action to the log
		// 1. Receive 'message' (null terminated string)
		// 1. Receive previous hash
		// 3. Append UID, TIME, COUNTER1, COUNTER2
		// 4. Format: TIME: {"message", UID, TIME, COUNTER1, COUNTER2}
		// 5. Generate signature
		// 6. Send back final message + signature

		// Expect message (max 512B)
		uint8_t buffer[512] = {0};
		UART_receive(&buffer[0], 512);

		// Expect previous hash (32B)
		uint8_t prev_hash[32] = {0};
		UART_receive(&prev_hash[0], 32);

		uint8_t * finalMessage;
		uint8_t signature[128];
		size_t sig_len;
		uint8_t hash[32];
		if(!LOGS_sign(buffer, strlen(buffer), 1, finalMessage, &signature[0], &sig_len, prev_hash, hash))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: signing message");
			return;
		}

		// Send SUCCESS with data + signature
		UART_send("SUCCESS", 7);

		// Send data
		UART_send(global_buffer, strlen(global_buffer)+1); // include null character

		// Send hash
		//UART_send(hash, 32);

		// Send signature
		UART_send(signature, sig_len);
	}
	else if(strcmp(command, "LOGS_COUNTERS") == 0)
	{
		// Secure connection
		if(!(system_status & STATUS_CONNECTED))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		uint8_t buffer[128] = {0};
		snprintf(buffer, 128, "%d %d", LOGS_globalCounter1, LOGS_globalCounter2);

		// Send SUCCESS with counters
		UART_send("SUCCESS", 7);

		// Send counters
		UART_send(buffer, strlen(buffer)+1); // include null character
	}
}

void COMMAND_TIME_process(uint8_t * command)
{
	if(strcmp(command, "TIME_SEND") == 0)
	{
		// Generate 512-bit nonce and send it
		uint8_t nonce[64] = {0};
		#ifdef SECURITY_DEVICE
			/* Generate random bits */
			uint8_t status = MSS_SYS_nrbg_generate(&nonce[0],    // p_requested_data
				0,              // p_additional_input
				64,				// requested_length
				0,              // additional_input_length
				0,              // pr_req
				drbg_handle);   // drbg_handle
			if(status != MSS_SYS_SUCCESS)
			{
				// Respond back with ERROR
				COMMAND_ERROR("ERROR: no random");
				return;
			}
		#endif

		// Start counting time (> 5s difference reject timestamp)
		mss_rtc_calendar_t new_calendar_time, diff_calendar_time;
		MSS_RTC_get_calendar_count(&new_calendar_time);
		UART_send(nonce, 64);

		// Wait for signed nonce + timestamp (64B + 4B) + signature
		uint8_t data[16*BLOCK_SIZE] = {0};
		uint32_t signature_len = UART_receive(&data[0], 16*BLOCK_SIZE) - 68;

		uint8_t hash[32] = {0};
		mbedtls_sha256(data, 68, hash, 0);

		uint8_t signature[8*BLOCK_SIZE] = {0};
		memcpy(signature, &data[68], signature_len);

		// Check time difference
		MSS_RTC_get_calendar_count(&diff_calendar_time);
		uint32_t time1 = convertDateToUnixTime(&new_calendar_time);
		uint32_t time2 = convertDateToUnixTime(&diff_calendar_time);

		// Same minute?
		if(time2-time1 > 5)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: too long");
			return;
		}

		// Verify signature of its hash
		uint8_t res = PKC_verifySignature(STS_PUBLIC_KEY, hash, 32, signature, signature_len);
		if(res == 1)
		{
			// Respond back with ERROR
			UART_send("SIG_ERROR", 9);
			return;
		}
		else if(res == 2)
		{
			UART_send("PUBLIC_KEY_ERROR", 16);
			return;
		}
		else if(res == 3)
		{
			UART_send("INCORRECT", 9);
			return;
		}

		MSS_RTC_get_calendar_count(&new_calendar_time);

		// Convert this back to an integer of 32bits
		time_t timestamp = (0x000000FF & data[64])
			| ((0x000000FF & data[65]) << 8)
			| ((0x000000FF & data[66]) << 16)
			| ((0x000000FF & data[67]) << 24);

		last_timestamp = timestamp; // last timestamp received!

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
		new_calendar_time.year = ptm->tm_year-100; // time works with years since 1900, while RTC works with years since 2000
		new_calendar_time.weekday = ptm->tm_wday+1; // time works with days since Sunday 80 being sunday) while RTC works with 1-7
		new_calendar_time.week = calculate_week(new_calendar_time.day, new_calendar_time.month,  new_calendar_time.year);

		MSS_RTC_set_calendar_count(&new_calendar_time);

		// Get our timestamp
		mss_rtc_calendar_t calendar_time;
		MSS_RTC_get_calendar_count(&calendar_time);

		/*volatile uint32_t t = convertDateToUnixTime(&calendar_time);

		volatile int a = 0;
		a++;*/

		// Use timestamp as random seed
		#ifndef SECURITY_DEVICE
			srand(timestamp);
		#endif

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
}

void COMMAND_SESSION_process(uint8_t * command)
{
	if(strcmp(command, "SESS_START") == 0)
	{
		UART_connect();

		if(SECURE_SESSION == 1)
		{
			if(!SecComm())
			{
				// Respond back with ERROR
				COMMAND_ERROR("ERROR: init sec comm");
				return;
			}
		}

		// Send SUCCESS
		UART_send("SUCCESS", 7);

		// Connected
		system_status |= STATUS_CONNECTED;
	}
	else if(strcmp(command, "SESS_END") == 0)
	{
		// Secure connection
		if(!(system_status & STATUS_CONNECTED))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected");
			return;
		}

		UART_disconnect();
	}
	else if(strcmp(command, "SESS_LOGIN") == 0)
	{
		// Secure connection
		if(!(system_status & STATUS_CONNECTED))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected");
			return;
		}

		// Not logged in
		if((system_status & STATUS_LOGGEDIN))
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
		if(!USER_verify(U_ID, AUTH_PIN))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Not Valid");
			return;
		}

		authID = U_ID;

		// Unset any possibility of having the current user as admin and logged in
		// (shouldn't happen because we start fresh and when we logout we unset these)
		system_status &= ~STATUS_ISADMIN;
		system_status &= ~STATUS_LOGGEDIN;
		if(U_ID == 0)
			system_status |= STATUS_ISADMIN;

		system_status |= STATUS_LOGGEDIN;

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
	else if(strcmp(command, "SESS_LOGOUT") == 0)
	{
		// Secure connection, logged in
		if(!(system_status & STATUS_CONNECTED) || !(system_status & STATUS_LOGGEDIN))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: not connected/auth");
			return;
		}

		// Logout

		authID = 0; // even though UID is 0 by default (admin), nothing bad happens as long as isAdmin/loggedIn gets checked when necessary
		system_status &= ~STATUS_ISADMIN;
		system_status &= ~STATUS_LOGGEDIN;

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
	else if(strcmp(command, "DVC_TEST") == 0)
	{
		// Simply receive 4,096B

		// Send SERIAL with data
		UART_receive(&global_buffer[0], GLOBAL_BUFFER_SIZE);

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
	else if(strcmp(command, "DVC_INIT") == 0)
	{
		if((system_status & STATUS_INITED))
		{
			// Respond back with ERROR
			//COMMAND_ERROR("ERROR: init 0");

			// If we're already initialized, reply back with ALREADY_INIT
			// But we must receive incoming data first...

			// Expect 32B AUTH_PIN
			uint8_t buffer[2*BLOCK_SIZE] = {0};
			UART_receive(&buffer[0], 2*BLOCK_SIZE);

			UART_send("ALREADY_INIT", 12);

			return;
		}

		// Expect 32B AUTH_PIN
		uint8_t buffer[2*BLOCK_SIZE] = {0};
		UART_receive(&buffer[0], 2*BLOCK_SIZE);

		// 32B => ADMIN_PIN (copy to RAM)
		memcpy(ADMIN_PIN, &buffer[0], PIN_SIZE);

		// Write to eNVM
		if(USE_ENVM)
		{
			// Convert to hex
			uint8_t hexPIN[64] = {0};
			bin2hex(ADMIN_PIN, 32, hexPIN);

			// Update eNVM
			nvm_status_t status = NVM_write(0x0020000, hexPIN, 64, NVM_DO_NOT_LOCK_PAGE);
			if(status != NVM_SUCCESS)
			{
				// Respond back with ERROR
				COMMAND_ERROR("ERROR: eNVM write");
				return;
			}
		}

		// Generate keys
		uint8_t status = 0;

		MSS_SYS_puf_delete_activation_code();
		MSS_SYS_puf_create_activation_code();

		uint8_t g_my_user_key[512] = {0};

		status = MSS_SYS_puf_enroll_key(2, 384 / 64, 0u, &g_my_user_key[0]);
		if(status != MSS_SYS_SUCCESS)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: init 1");
			return;
		}

		status = MSS_SYS_puf_enroll_key(3, 384 / 64, 0u, &g_my_user_key[0]);
		if(status != MSS_SYS_SUCCESS)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: init 2");
			return;
		}

		// Auth Key
		status = MSS_SYS_puf_enroll_key(4, 384 / 64, 0u, &g_my_user_key[0]);
		if(status != MSS_SYS_SUCCESS)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: init 3");
			return;
		}

		// SPI Flash Key
		status = MSS_SYS_puf_enroll_key(5, 256 / 64, 0u, &g_my_user_key[0]);
		if(status != MSS_SYS_SUCCESS)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: init 4");
			return;
		}

		// SPI Flash IV
		status = MSS_SYS_puf_enroll_key(6, 128 / 64, 0u, &g_my_user_key[0]);
		if(status != MSS_SYS_SUCCESS)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: init 5");
			return;
		}

		uint8_t key_numbers = 0;
		status = MSS_SYS_puf_get_number_of_keys(&key_numbers);
		if(key_numbers != 7)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: init 6");
			return;
		}

		COMMAND_inited();

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
}

void COMMAND_ERROR(char * message)
{
	UART_send(message, strlen(message));
	UART_disconnect();
}
