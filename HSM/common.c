/*
 * common.c
 *
 *  Created on: 10/02/2017
 *      Author: diogo
 */

#include "common.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

void __printf(char *s)
{
	// We only print out stuff if we're in the CLI version
#ifdef DEBUG_MODE
		MSS_UART_polled_tx_string(&g_mss_uart0, (uint8_t *)s);
#endif
}

// Functions below come from the example projects

/*------------------------------------------------------------------------------
  Calculate week day from given date.
 */
uint32_t calculate_weekday(uint32_t day, uint32_t month, uint32_t year)
{

    uint32_t weekdays = 1;
    uint32_t prev_totaldays;
    uint32_t totaldays;
    uint32_t t_year = year + 2000;
    uint32_t prev_year = t_year - 1;

    totaldays = calculate_totaldays(day, month, t_year);
    prev_totaldays = (prev_year * 365) + (prev_year / 4) - (prev_year / 100) + (prev_year / 400);
    weekdays += (totaldays + prev_totaldays) % 7;

    return weekdays;
}

/*------------------------------------------------------------------------------
  Calculate total number of days from given date.
 */
uint32_t calculate_totaldays(uint32_t day, uint32_t month, uint32_t year)
{
    uint32_t totaldays = day;
    uint8_t inc;
    uint8_t leap = 0u;

    static char daytab[2][13] =
    {
        {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
        {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    };

    if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
    {
        leap = 1u;
    }
    for (inc = 1; inc < month; inc++)
    {
        totaldays += daytab[leap][inc];
    }
    return totaldays;
}

/*------------------------------------------------------------------------------
  Calculate week number from given date.
 */
uint32_t calculate_week(uint32_t day, uint32_t month, uint32_t year)
{
    uint32_t weeks;
    uint32_t weekdays;
    uint32_t prev_totaldays;
    uint32_t totaldays;
    uint32_t t_year = year + 2000;
    uint32_t prev_year = t_year - 1;
    uint32_t prev_weekdays;

    totaldays = calculate_totaldays(day, month, t_year);
    weekdays = calculate_weekday(day, month, t_year);

    prev_totaldays = (prev_year * 365) + (prev_year / 4) - (prev_year / 100) + (prev_year / 400);

    weeks = totaldays / 7;

    if(weekdays != 0)
    {
        weeks++;
    }
    prev_weekdays = prev_totaldays % 7;

    if(((prev_weekdays + weekdays) <= 8) && (prev_weekdays != 0))
    {
        weeks++;
    }

    return weeks;
}

int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len, size_t *olen)
{
	mss_rtc_calendar_t calendar_count;
	MSS_RTC_get_calendar_count(&calendar_count);

	// apparently, using mktime requires an extra 5KB of binary size - out of question.
	/*struct tm ptm;

	ptm.tm_sec = calendar_count.second;
	ptm.tm_min = calendar_count.minute;
	ptm.tm_hour = calendar_count.hour;
	ptm.tm_mday = calendar_count.day;
	ptm.tm_mon = calendar_count.month-1; // time works with months since january (0 being jan) while RTC works with 1 to 12
	ptm.tm_year = calendar_count.year+100; // time works with years since 1900, while RTC works with years since 2009
	ptm.tm_wday = calendar_count.weekday-1; // time works with days since sunday 80 being sunday) while RTC works with 1-7

	uint32_t timer = mktime(&ptm);*/

#ifdef SECURITY_DEVICE
	uint8_t puf_seed[32] = {0};
	MSS_SYS_puf_get_random_seed(&puf_seed[0]);
	uint8_t status;
	if(status != MSS_SYS_SUCCESS)
	{
		return 1; // error
	}

	memcpy(output, puf_seed, sizeof(uint8_t)*32);
	*olen = sizeof(uint8_t)*32;
#else
	// instead, let's do some modifications to the structure we have
	// we're going to use the hardware RNG so this doesn't really matter!
	uint32_t timer = calendar_count.second + calendar_count.minute*60 + calendar_count.hour*60*60 + calendar_count.day*24*60*60 + calendar_count.month*30*24*60*60;

	MSS_RTC_clear_update_flag();

	*olen = 0;

	if( len < sizeof(uint32_t) )
		return(0);

	memcpy(output, &timer, sizeof(uint32_t));
	*olen = sizeof(uint32_t);
#endif

    return(0);
}

/*uint8_t get_timestamp()
{
	mss_rtc_calendar_t calendar_count;
	MSS_RTC_get_calendar_count(&calendar_count);

	struct tm ptm;

	ptm.tm_sec = calendar_count.second;
	ptm.tm_min = calendar_count.minute;
	ptm.tm_hour = calendar_count.hour;
	ptm.tm_mday = calendar_count.day;
	ptm.tm_mon = calendar_count.month-1; // time works with months since january (0 being jan) while RTC works with 1 to 12
	ptm.tm_year = calendar_count.year+100; // time works with years since 1900, while RTC works with years since 2009
	ptm.tm_wday = calendar_count.weekday-1; // time works with days since sunday 80 being sunday) while RTC works with 1-7

	uint8_t timer = mktime(&ptm);

	MSS_RTC_clear_update_flag();

	return timer;
}*/

/*
 * PKCS7 (and PKCS5) padding: fill with ll bytes, with ll = padding_len
 */
void add_pkcs_padding( unsigned char *output, size_t output_len,
        size_t data_len )
{
    size_t padding_len = output_len - data_len;
    unsigned char i;

    for( i = 0; i < padding_len; i++ )
        output[data_len + i] = (unsigned char) padding_len;
}

int get_pkcs_padding( unsigned char *input, size_t input_len,
        size_t *data_len )
{
    size_t i, pad_idx;
    unsigned char padding_len, bad = 0;

    if( NULL == input || NULL == data_len )
        return -1;

    padding_len = input[input_len - 1];
    *data_len = input_len - padding_len;

    /* Avoid logical || since it results in a branch */
    bad |= padding_len > input_len;
    bad |= padding_len == 0;

    /* The number of bytes checked must be independent of padding_len,
     * so pick input_len, which is usually 8 or 16 (one block) */
    pad_idx = input_len - padding_len;
    for( i = 0; i < input_len; i++ )
        bad |= ( input[i] ^ padding_len ) * ( i >= pad_idx );

    return( -2 * ( bad != 0 ) );
}


/*==============================================================================
  System Services event handler.
 */
void sys_services_event_handler(uint8_t opcode, uint8_t response)
{
	// TODO: There should be an admin command to clear the mesh and the clock flags (see tamper detection project example)

    if(POR_DIGEST_ERROR_OPCODE == opcode)
    {
        sys_services_data_event_handler(response);
    }
    else if((opcode >= TAMPER_ATTEMPT_BOUNDARY_SCAN_OPCODE) && \
	  (opcode <= TAMPER_ATTEMPT_ZEROIZATION_RECOVERY_OPCODE))
	{
    	system_status |= STATUS_TAMPER_DETECTED;

    	// Tamper attempt event detected; enter state of failure!
    	tamper_status |= STATUS_TAMPER_EVENT_DETECTED;
	}
	else if((opcode >= TAMPER_FAILURE_BOUNDARY_SCAN_OPCODE) && \
		   (opcode <= TAMPER_FAILURE_ZEROIZATION_RECOVERY_OPCODE))
	{
		system_status |= STATUS_TAMPER_DETECTED;

		// Tamper failure event detected; enter state of failure!
		tamper_status |= STATUS_TAMPER_FAILURE_EVENT_DETECTED;
	}
	else if(opcode == TAMPER_CLOCK_ERROR_DETECT_OPCODE)
	{
		system_status |= STATUS_TAMPER_DETECTED;

		// Tamper clock monitor error detected; enter state of failure!
		tamper_status |= STATUS_TAMPER_CLOCK_ERROR_DETECTED;
	}
	else if((opcode >= TAMPER_HARDWARE_MONITOR_JTAGACTIVE_ERROR_OPCODE) && \
			(opcode <= TAMPER_HARDWARE_MONITOR_MESHSHORT_ERROR_OPCODE))
	{
		system_status |= STATUS_TAMPER_DETECTED;

		// Hardware monitor error detected; enter state of failure!
		tamper_status |= STATUS_TAMPER_HARDWARE_MONITOR_ERROR_DETECTED;
	}
	else
	{
		// Invalid event detected
	}
}

/*==============================================================================
  System Services Data event handler.
 */
void sys_services_data_event_handler(uint8_t error_type)
{
    uint8_t fabric_digest_check_failure;
    uint8_t envm0_digest_check_failure;
    uint8_t envm1_digest_check_failure;
    static uint8_t buffer[2];

    fabric_digest_check_failure = error_type & MSS_SYS_DIGEST_CHECK_FABRIC;
    envm0_digest_check_failure = error_type & MSS_SYS_DIGEST_CHECK_ENVM0;
    envm1_digest_check_failure = error_type & MSS_SYS_DIGEST_CHECK_ENVM1;

    if(fabric_digest_check_failure)
    {
    	system_status |= STATUS_POR_FAILED;
    	tamper_status |= STATUS_POR_FABRIC_DIGEST_FAILED;
    }
    if(envm0_digest_check_failure)
    {
    	system_status |= STATUS_POR_FAILED;
    	tamper_status |= STATUS_POR_ENVM0_DIGEST_FAILED;
    }
    if(envm1_digest_check_failure)
    {
    	system_status |= STATUS_POR_FAILED;
    	tamper_status |= STATUS_POR_ENVM1_DIGEST_FAILED;
    }
}


int sys_keys_to_pem(uint8_t * private_key, uint8_t * pub_dest, uint32_t pub_size, uint8_t * pri_dest, uint32_t pri_size)
{
	int ret = 0;
	mbedtls_ecp_keypair issuerPair;
	mbedtls_ecp_keypair_init(&issuerPair);

	ret = mbedtls_ecp_group_load(&issuerPair.grp, MBEDTLS_ECP_DP_SECP384R1);
	if(ret != 0)
	{
		return ret;
	}

	// 384-bit values
	uint8_t status = 0u;
	uint8_t d[48] = {0x00u}; // m
	memcpy(&d[0], &private_key[0], 48u);
	uint8_t p[96] = {0x00u}; // P (x,y) -> (48B,48B)
	uint8_t q[96] = {0x00u}; // Q (x,y) -> (48B,48B)

	// Load private key
	if((ret = mbedtls_mpi_read_binary(&issuerPair.d, d, 48)) != 0)
	{
		return ret;
	}

	// Get base point G for NIST elliptic curve P-384.
	MSS_SYS_ecc_get_base_point(p);

	// Compute public key
	status = MSS_SYS_ecc_point_multiplication(&d[0], &p[0], &q[0]); // Q = d * P
	if(status != MSS_SYS_SUCCESS)
	{
		return status;
	}
	else{
		// X coordinate of Q
		if((ret = mbedtls_mpi_read_binary(&issuerPair.Q.X, q, 48)) != 0)
		{
			return ret;
		}

		// Y coordinate of Q
		if((ret = mbedtls_mpi_read_binary(&issuerPair.Q.Y, &q[48], 48)) != 0)
		{
			return ret;
		}

		// Z coordinate of R
		if((ret = mbedtls_mpi_lset(&issuerPair.Q.Z, 1)) != 0)
		{
			return ret;
		}
	}

	ret = mbedtls_ecp_check_privkey(&issuerPair.grp, &issuerPair.d);
	if(ret != 0)
	{
		return ret;
	}

	ret = mbedtls_ecp_check_pubkey(&issuerPair.grp, &issuerPair.Q);
	if(ret != 0)
	{
		return ret;
	}

	//// Now it's time to convert both into PEM format
	mbedtls_pk_context * pk_ctx = (mbedtls_pk_context*)malloc(sizeof(mbedtls_pk_context));
	mbedtls_pk_init(pk_ctx);
	if((ret = mbedtls_pk_setup(pk_ctx, mbedtls_pk_info_from_type(MBEDTLS_PK_ECKEY))) != 0)
	{
		return ret;
	}

	// Set the key pair of our context
	mbedtls_ecp_keypair * oldctx = pk_ctx->pk_ctx;
	pk_ctx->pk_ctx = (mbedtls_ecp_keypair *)&issuerPair;

	// Write a PEM string for the public key
	ret = mbedtls_pk_write_pubkey_pem(pk_ctx, pub_dest, ECC_PUBLIC_KEY_SIZE);
	if(ret != 0)
	{
		return ret;
	}

	// Write a PEM string for the private key
	ret = mbedtls_pk_write_key_pem(pk_ctx, pri_dest, ECC_PRIVATE_KEY_SIZE);
	if(ret != 0)
	{
		return ret;
	}

	pk_ctx->pk_ctx = oldctx; // we should set it back so we can free it properly below
	mbedtls_pk_free(pk_ctx);
	mbedtls_ecp_keypair_free(&issuerPair);

	return 0;
}
