#include "Command.h"
#include <time.h>

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
		COMMAND_DATASIGN_process(command);
		return;
	}
	else if(command[0] == 'C' && command[1] == 'R' && command[2] == 'T')
	{
		COMMAND_CERTMGT_process(command);
		return;
	}
	else if(command[0] == 'L' && command[1] == 'O' && command[2] == 'G' && command[3] == 'S')
	{
		COMMAND_LOGS_process(command);
		return;
	}
	else if(command[0] == 'T' && command[1] == 'I' && command[2] == 'M' && command[3] == 'E')
	{
		COMMAND_TIME_process(command);
		return;
	}
}

void COMMAND_USER_process(uint8_t * command)
{
	if(strcmp(command, "USER_NEW") == 0)
	{
		// New User

		// Expect 32B ADMIN_PIN and 32B User PIN
		uint8_t buffer[64] = {0};
		UART_receive(&buffer[0], 64u);

		uint8_t AUTH_PIN[32] = {0};
		uint8_t U_PIN[32] = {0};

		// First 32B => AUTH_PIN
		memcpy(AUTH_PIN, &buffer[0], 32u);

		// Second 32B => User PIN
		memcpy(U_PIN, &buffer[32], 32u);

		if(!USER_isAdmin(AUTH_PIN))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Not Admin");
			return;
		}

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

		// Send SUCCESS with ID
		UART_send("SUCCESS_ID", 10);

		uint8_t data[1];
		data[0] = U_ID;
		UART_send(data, 1);
	}
	else if(strcmp(command, "USER_MODIFY") == 0)
	{
		// Modify PIN

		// Expect 32B PIN and ID|PIN
		uint8_t buffer[2*PIN_SIZE+1] = {0};
		UART_receive(&buffer[0], 65u);

		uint8_t AUTH_PIN[PIN_SIZE] = {0};
		uint8_t U_ID = 0;
		uint8_t U_PIN[PIN_SIZE] = {0};

		// First 32B => AUTH_PIN (user or admin)
		memcpy(AUTH_PIN, &buffer[0], PIN_SIZE);

		U_ID = buffer[PIN_SIZE];

		// Authenticate
		if(!USER_isAdmin(AUTH_PIN))
		{
			// If not admin, check if ID matches PIN
			if(!USER_verify(U_ID, AUTH_PIN))
			{
				// Respond back with ERROR
				COMMAND_ERROR("ERROR: Not Admin");
				return;
			}
		}

		// Second 32B => New PIN
		memcpy(U_PIN, &buffer[PIN_SIZE+1], PIN_SIZE);

		USER_init();
		USER * u = USER_get(U_ID);
		if(!u)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Cannot find user");
			return;
		}

		memcpy(u->PIN, U_PIN, PIN_SIZE);

		if(!USER_modify(u))
		{
			free(u);

			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Cannot modify PIN");
			return;
		}

		free(u);

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
	else if(strcmp(command, "USER_DELETE") == 0)
	{
		// Delete User

		// Expect 32B ADMIN_PIN and User ID
		uint8_t buffer[PIN_SIZE+1] = {0};
		UART_get(&buffer[0], PIN_SIZE+1);
		UART_sendOK();

		uint8_t AUTH_PIN[PIN_SIZE] = {0};
		uint8_t ID = 0;

		// First 32B => AUTH_PIN
		memcpy(AUTH_PIN, &buffer[0], PIN_SIZE);

		// ID
		ID = buffer[PIN_SIZE];

		USER_init();
		if(!USER_isAdmin(AUTH_PIN))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Not Admin");
			return;
		}

		USER_init();

		USER_remove(ID);

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
	else if(strcmp(command, "USER_GENKEYS") == 0)
	{
		// Generate Key Pair for user (overwrites existing one)

		// Expect 32B PIN and ID
		uint8_t buffer[PIN_SIZE+1] = {0};
		UART_receive(&buffer[0], 33u);

		uint8_t AUTH_PIN[PIN_SIZE] = {0};
		uint8_t U_ID = 0;

		// First 32B => AUTH_PIN (user or admin)
		memcpy(AUTH_PIN, &buffer[0], PIN_SIZE);

		U_ID = buffer[PIN_SIZE];

		// Authenticate
		if(!USER_isAdmin(AUTH_PIN))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Not Admin");
			return;
		}

		USER_init();
		if(!USER_exists(U_ID))
		{
			// Respond back with ERROR
			// user already exists - but it shouldn't, our algorithm for finding the next free is wrong
			COMMAND_ERROR("ERROR: User does not exist");
			return;
		}

		uint8_t private[ECC_PRIVATE_KEY_SIZE] = {0};
		uint8_t public[ECC_PUBLIC_KEY_STORE_SIZE] = {0};
		if(!PKC_genKeyPair(&private[0], &public[0]))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Generating key pair");
			return;
		}

		// TODO: Store key pair
		// Add UPDATE routine to User (Modify and Remove need to be tested as well)

		// Success
		UART_send("SUCCESS", 7);
	}
	else if(strcmp(command, "USER_CERT") == 0)
	{
		// Get certificate of user's public key

		// Expect 1B ID
		uint8_t buffer[1] = {0};
		UART_receive(&buffer[0], 1u);

		uint8_t U_ID = buffer[0];

		USER_init();
		if(!USER_exists(U_ID))
		{
			// Respond back with ERROR
			// user already exists - but it shouldn't, our algorithm for finding the next free is wrong
			COMMAND_ERROR("ERROR: User does not exist");
			return;
		}

		// TODO: Get certificate

		// Success
		UART_send("CERTIFICATE", 11);

		// TODO: send certificate
	}
}

void COMMAND_DATASIGN_process(uint8_t * command)
{
	if(strcmp(command, "DTSN_SIGN") == 0)
	{
		// User is requesting a hash to be signed using its private key

		// Expect 32B AUTH_PIN + 1B PIN
		uint8_t buffer[PIN_SIZE+1+HASH_SIZE] = {0};
		UART_receive(&buffer[0], PIN_SIZE+1+HASH_SIZE);

		uint8_t AUTH_PIN[PIN_SIZE] = {0};
		uint8_t U_ID = 0;
		uint8_t HASH[HASH_SIZE] = {0};

		// First 32B => AUTH_PIN (user)
		memcpy(AUTH_PIN, &buffer[0], PIN_SIZE);

		// 1B => U_ID
		U_ID = buffer[PIN_SIZE];

		memcpy(HASH, &buffer[PIN_SIZE+1], HASH_SIZE);

		// Check if ID matches PIN
		USER_init();
		if(!USER_verify(U_ID, AUTH_PIN))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Not Valid");
			return;
		}

		// Get user private key
		USER * u = USER_get(U_ID);

		// We have the hash
		// Apply ECDSA
		uint8_t sig[512] = {0};
		size_t sig_len = 0;
		if(!PKC_signData(u->privateKey, HASH, HASH_SIZE, &sig[0], &sig_len))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: signature");
			return;
		}

		free(u);

		// Send SIGNATURE
		UART_send("SIGNATURE", 9);

		// Send signature
		UART_send(sig, sig_len);
	}
	else if(strcmp(command, "DTSN_VERIFY") == 0)
	{
		// User is requesting a hash and a signature to be verified

		// Expect 32B AUTH_PIN + 1B PIN + 32B hash + 1B (signature size)
		uint8_t buffer[PIN_SIZE+1+HASH_SIZE] = {0};
		UART_receive(&buffer[0], PIN_SIZE+1+HASH_SIZE+4);

		uint8_t AUTH_PIN[PIN_SIZE] = {0};
		uint8_t U_ID = 0;
		uint8_t HASH[HASH_SIZE] = {0};
		uint8_t SIG_SIZE = 0;

		// First 32B => AUTH_PIN (user)
		memcpy(AUTH_PIN, &buffer[0], PIN_SIZE);

		// 1B => U_ID
		U_ID = buffer[PIN_SIZE];

		// 32B for hash
		memcpy(HASH, &buffer[PIN_SIZE+1], HASH_SIZE);

		// signature size
		SIG_SIZE = buffer[PIN_SIZE+1+HASH_SIZE];

		// Wait for X bytes
		uint8_t * SIGNATURE = malloc(sizeof(uint8_t)*SIG_SIZE);
		if(!SIGNATURE)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: No memory");
			return;
		}

		UART_receive(SIGNATURE, SIG_SIZE);

		// Check if ID matches PIN
		USER_init();
		if(!USER_verify(U_ID, AUTH_PIN))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Not Valid");
			return;
		}

		// Get user private key
		USER * u = USER_get(U_ID);

		// We have the hash
		// Apply ECDSA
		uint8_t res = PKC_verifySignature(u->publicKey, HASH, HASH_SIZE, SIGNATURE, SIG_SIZE);
		if(res == 0)
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: signature");
			return;
		}
		else if(res == 2)
		{
			UART_send("INCORRECT", 9);
		}

		free(u);

		// Send SUCCESS
		UART_send("SUCCESS", 7);
	}
}

void COMMAND_CERTMGT_process(uint8_t * command)
{
	if(strcmp(command, "CRT_REQUEST") == 0)
	{
		// User is requesting a certificate for a public key

		// Expect 32B ADMIN_PIN and 384-bit Public Key (assuming for now)
		uint8_t buffer[PIN_SIZE+ECC_PUBLIC_KEY_STORE_SIZE] = {0};
		UART_receive(&buffer[0], PIN_SIZE+ECC_PUBLIC_KEY_STORE_SIZE);

		uint8_t AUTH_PIN[PIN_SIZE] = {0};
		uint8_t KEY[ECC_PUBLIC_KEY_STORE_SIZE] = {0};

		// First 32B => AUTH_PIN
		memcpy(AUTH_PIN, &buffer[0], PIN_SIZE);

		// Second 48B => Public Key
		memcpy(KEY, &buffer[PIN_SIZE], ECC_PUBLIC_KEY_STORE_SIZE);

		if(!USER_isAdmin(AUTH_PIN))
		{
			// Respond back with ERROR
			COMMAND_ERROR("ERROR: Not Admin");
			return;
		}

		// TODO: Generate certificate for public key

		// Send SUCCESS with Certificate
		UART_send("CERTIFICATE", 11);

		// TODO: Send certificate
		/*
		uint8_t data[1];
		data[0] = U_ID;
		UART_send(data, 1);
		*/
	}
}

void COMMAND_LOGS_process(uint8_t * command)
{
	if(strcmp(command, "LOGS_ADD") == 0)
	{
		// Add a new action to the log
		// Receive 'user|action|date|'
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
        uint8_t buffer[4] = {0};
		UART_receive(&buffer[0], 4u);

		// Convert this back to an integer of 32bits
		time_t timestamp = (0x000000FF & buffer[0])
				| ((0x000000FF & buffer[1]) << 8)
				| ((0x000000FF & buffer[2]) << 16)
				| ((0x000000FF & buffer[3]) << 24);

		struct tm * ptm;
		ptm = gmtime(&timestamp);

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
        srand(timestamp);

        free(ptm);
	}
}

void COMMAND_ERROR(char * message)
{
	UART_send(message, strlen(message));
}
