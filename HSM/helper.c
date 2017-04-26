/*******************************************************************************
 * (c) Copyright 2012-2016 Microsemi SoC Products Group.  All rights reserved.
 *
 * Helper function for PUF system service example.
 *
 * SVN $Revision: 8346 $
 * SVN $Date: 2016-03-23 12:18:12 +0530 (Wed, 23 Mar 2016) $
 */
#include <stdio.h>
#include <string.h>
#include "CMSIS/mss_assert.h"
#include "drivers/mss_uart/mss_uart.h"
#include "drivers/mss_sys_services/mss_sys_services.h"
#include "helper.h"

#define ENTER                   0x0D

/*==============================================================================
  Error messages displayed over the UART.
 */
const uint8_t eNVM_error_msg[] = "\r\n Error - eNVM Error.";
const uint8_t PUF_error_msg[] =  "\r\n Error - PUF error when creating.";
const uint8_t Invalid_request_error_msg[] = "\r\n Error - Invalid request or KC, when exporting or importing.";
const uint8_t eNVM_program_error_msg[] = "\r\n Error - eNVM program error.";
const uint8_t Invalid_hash_error_msg[] = "\r\n Error - Invalid hash.";
const uint8_t Invalid_user_ac_error_msg[] = "\r\n Error - Invalid user activation code.";
const uint8_t eNVM_verify_error_msg[] = "\r\n Error - eNVM verify error.";
const uint8_t Incorrect_key_size_error_msg[] = "\r\n Error - Incorrect keysize for renewing a kc.";
const uint8_t Digest_mismatch_error_msg[] = "\r\n Error - Private eNVM user digest mismatch.";
const uint8_t Invalid_subcmd_error_msg[] = "\r\n Error - Invalid subcmd.";
const uint8_t Invalid_status_error_msg[] = "\r\n Error - Invalid status.";
const uint8_t HRESP_error_msg[] = "\r\n Error - HRESP error occurred during MSS transfer.";
const uint8_t License_error_msg[] = "\r\n Error - License not available in device.";
const uint8_t Disabled_factory_security_error_msg[] = "\r\n Error - Service disabled by factory security.";
const uint8_t Disabled_user_security_error_msg[] = "\r\n Error - Service disabled by user security.";
const uint8_t Invalid_keynum_error_msg[] = "\r\n Error - Invalid keynum or argument or exported or invalid key.";
const uint8_t Invalid_public_key_error_msg[] = "\r\n Error - No valid public key present in eNVM.";
const uint8_t DRBG_error_msg[] = "\r\n Error - DRBG error.";
const uint8_t Unexp_error_msg[] = "\r\n Error - Unexpected error.";

extern mss_uart_instance_t * const gp_my_uart;

/*==============================================================================
  Store the address into the array
 */
void write_ptr_value_into_array
(
    const uint8_t * pointer,
    uint8_t target_array[],
    uint32_t array_index
)
{
    target_array[array_index] = (uint8_t)((uint32_t)pointer);
    target_array[array_index + 1] = (uint8_t)((uint32_t)pointer >> 8u);
    target_array[array_index + 2] = (uint8_t)((uint32_t)pointer >> 16u);
    target_array[array_index + 3] = (uint8_t)((uint32_t)pointer >> 24u);
}

/*==============================================================================
  Convert ASCII value to hex value.
 */
uint8_t convert_ascii_to_hex(uint8_t* arr, uint32_t length)
{
    uint32_t inc = 0u;
    uint8_t nb_digit = 0u;
    uint8_t hex_byte = 0u;
    uint8_t error_flag = 0u;
    uint8_t* src_ptr = arr;
    uint8_t* dst_ptr = arr;
    
    for(inc = 0; inc < length; inc++)
    { 
       
        if((*src_ptr >= '0') && (*src_ptr <= '9'))
        {
            hex_byte = (hex_byte * 16u) + (*src_ptr - '0');
            *src_ptr = 0u;
            src_ptr++;
            nb_digit++;
        }
        else if((*src_ptr >= 'a') && (*src_ptr <= 'f'))
        {
            hex_byte = (hex_byte * 16u) + (*src_ptr - 'a') + 10u;
            *src_ptr = 0u;
            src_ptr++;
            nb_digit++;
        }
        else if((*src_ptr >= 'A') && (*src_ptr <= 'F'))
        {
            hex_byte = (hex_byte * 16u) + (*src_ptr - 'A') + 10u;
            *src_ptr = 0u;
            src_ptr++;
            nb_digit++;
        }
        else if(*src_ptr != 0x00u)
        {
            MSS_UART_polled_tx_string(gp_my_uart, (const uint8_t *)"\r\n Invalid data.");
            error_flag = 1u;
            break;
        }
        
        if(nb_digit >= 2u)
        {
            *dst_ptr = hex_byte;
            nb_digit = 0u;
            hex_byte = 0u;
            dst_ptr++;
        }
    }
    
    if(nb_digit == 1u)
    {
      *dst_ptr = (hex_byte * 16u);
    }
    return error_flag;
}

/*==============================================================================
  Validate the input hex value .
 */
uint8_t validate_input(uint8_t ascii_input)
{
    uint8_t valid_key = 0u;
    
    if(((ascii_input >= 'A') && (ascii_input <= 'F')) ||        \
       ((ascii_input >= 'a') && (ascii_input <= 'f')) ||        \
       ((ascii_input >= '0') && (ascii_input <= '9')))
    {
        valid_key = 1u;
    }
    else
    {
        valid_key = 0u;
    }
    return valid_key;
}

/*==============================================================================
  Display content of buffer passed as parameter as hex values.
 */
void display_hex_values
(
    uint8_t* in_buffer,
    uint32_t byte_length
)
{
    uint8_t display_buffer[128];
    uint32_t inc;
        
    for(inc = 0; inc < byte_length; ++inc)
    {
        if((inc > 1u) &&(0u == (inc % 8u)))
        {
            MSS_UART_polled_tx_string(gp_my_uart,(const uint8_t*)"\r\n");
        }
        MSS_UART_polled_tx_string(gp_my_uart, (const uint8_t*)" 0x");
        snprintf((char *)display_buffer, sizeof(display_buffer), "%02x", in_buffer[inc]);
        MSS_UART_polled_tx_string(gp_my_uart, display_buffer);
    }
}

/*==============================================================================
  Function to clear local variable and array.
 */
void clear_variable(volatile uint8_t *p_var, uint16_t size)
{
    uint16_t i;
    
    for(i = 0; i < size; i++)
    {
        *p_var = 0x00;
        p_var++;
    }
}

/*==============================================================================
  Function to write array address to pointer location.
 */
void write_array_into_ptr_value
(
    uint8_t** pointer,
    uint8_t target_array[],
    uint32_t array_index
)
{
    uint32_t var;
    
    var = (uint32_t)target_array[array_index + 3];
    var = ((var << 8u) & 0xFFFFFF00) | target_array[array_index + 2];
    var = ((var << 8u) & 0xFFFFFF00) | target_array[array_index + 1];
    var = ((var << 8u) & 0xFFFFFF00) | target_array[array_index];
    
    *pointer = (uint8_t*)var;
}

/*==============================================================================
  Function to read the data from UART terminal.
 */
uint16_t get_data_from_uart(uint8_t* src_ptr, uint16_t size, const uint8_t* msg)
{
    uint8_t complete = 0u;
    uint8_t rx_buff[1];
    uint8_t rx_size = 0u;
    uint16_t count = 0u;
    
    /* Read the key size sent by user and store it. */
    count = 0u;
    while(!complete)
    {
        rx_size = MSS_UART_get_rx (gp_my_uart, rx_buff, sizeof(rx_buff));
        if(rx_size > 0u)
        {
            /* Is it to terminate from the loop */
            if(ENTER == rx_buff[0])
            {
                complete = 1u;
            }
            /* Is entered key valid */
            else if(validate_input(rx_buff[0]) != 1u)
            {
                MSS_UART_polled_tx(gp_my_uart, rx_buff, sizeof(rx_buff));
                MSS_UART_polled_tx_string(gp_my_uart, (const uint8_t *)"\r\n Invalid input.");
                MSS_UART_polled_tx_string(gp_my_uart, msg);
                complete = 0u;
                count = 0u;
                clear_variable(src_ptr, 4);
            }
            else
            {
                src_ptr[count] = rx_buff[0];
                
                /* Switching to next line after every 8 bytes */
                if(((count % 16u) == 0x00u) && 
                    (count > 0x00u) && 
                    (complete != 0x01u))
                {
                    MSS_UART_polled_tx_string(gp_my_uart, (const uint8_t *)"\n\r");
                }

                if((count % 2u) == 0u)
                {
                    MSS_UART_polled_tx_string(gp_my_uart, (const uint8_t *)" 0x"); 
                }
                MSS_UART_polled_tx(gp_my_uart, rx_buff, sizeof(rx_buff));
                count++;
                if(size == count)
                {
                   complete = 1u;
                }
            }
        }
    }
    
    return count;
}

/*==============================================================================
  Error information specific to service.
 */

/*==============================================================================
  Display error information related to PUF seed service.
 */
void display_puf_seed_error(uint8_t status)
{
    switch(status)
    {
        case MSS_SYS_PUF_ERROR_WHEN_CREATING:
            MSS_UART_polled_tx_string(gp_my_uart, PUF_error_msg);
            break;
            
        case MSS_SYS_MEM_ACCESS_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, HRESP_error_msg);
            break;
            
        case MSS_SYS_SERVICE_NOT_LICENSED:
            MSS_UART_polled_tx_string(gp_my_uart, License_error_msg);
            break;
            
        case MSS_SYS_SERVICE_DISABLED_BY_FACTORY:
            MSS_UART_polled_tx_string(gp_my_uart, Disabled_factory_security_error_msg);
            break;
            
        case MSS_SYS_SERVICE_DISABLED_BY_USER:
            MSS_UART_polled_tx_string(gp_my_uart, Disabled_user_security_error_msg);
            break;
            
        case MSS_SYS_ENVM_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, DRBG_error_msg);
            break;
            
        case MSS_SYS_UNEXPECTED_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, Unexp_error_msg);
            break;
    }
}

/*==============================================================================
  Display error information related to PUF public key service.
 */
void display_puf_public_key_error(uint8_t status)
{
    switch(status)
    {
        case MSS_SYS_NO_VALID_PUBLIC_KEY:
            MSS_UART_polled_tx_string(gp_my_uart, Invalid_public_key_error_msg);
            break;
            
        case MSS_SYS_PRIVATE_ENVM_USER_DIGEST_MISMATCH:
            MSS_UART_polled_tx_string(gp_my_uart, Digest_mismatch_error_msg);
            break;
            
        case MSS_SYS_MEM_ACCESS_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, HRESP_error_msg);
            break;
            
        case MSS_SYS_SERVICE_NOT_LICENSED:
            MSS_UART_polled_tx_string(gp_my_uart, License_error_msg);
            break;
            
        case MSS_SYS_SERVICE_DISABLED_BY_FACTORY:
            MSS_UART_polled_tx_string(gp_my_uart, Disabled_factory_security_error_msg);
            break;
            
        case MSS_SYS_SERVICE_DISABLED_BY_USER:
            MSS_UART_polled_tx_string(gp_my_uart, Disabled_user_security_error_msg);
            break;
            
        case MSS_SYS_ENVM_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, DRBG_error_msg);
            break;
            
        case MSS_SYS_UNEXPECTED_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, Unexp_error_msg);
            break;
    }
}

/*==============================================================================
  Display error information related to user PUF key service.
 */
void display_read_user_puf_key_error(uint8_t status)
{
    switch(status)
    {
        case MSS_SYS_PUF_ERROR_WHEN_CREATING:
            MSS_UART_polled_tx_string(gp_my_uart, PUF_error_msg);
            break;
            
        case MSS_SYS_INVALID_KEYNUM_OR_ARGUMENT:
            MSS_UART_polled_tx_string(gp_my_uart, Invalid_keynum_error_msg);
            break;
            
        case MSS_SYS_INVALID_HASH:
            MSS_UART_polled_tx_string(gp_my_uart, Invalid_hash_error_msg);
            break;
            
        case MSS_SYS_PRIVATE_ENVM_USER_DIGEST_MISMATCH:
            MSS_UART_polled_tx_string(gp_my_uart, Digest_mismatch_error_msg);
            break;
            
        case MSS_SYS_MEM_ACCESS_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, HRESP_error_msg);
            break;
            
        case MSS_SYS_SERVICE_NOT_LICENSED:
            MSS_UART_polled_tx_string(gp_my_uart, License_error_msg);
            break;
            
        case MSS_SYS_SERVICE_DISABLED_BY_FACTORY:
            MSS_UART_polled_tx_string(gp_my_uart, Disabled_factory_security_error_msg);
            break;
            
        case MSS_SYS_SERVICE_DISABLED_BY_USER:
            MSS_UART_polled_tx_string(gp_my_uart, Disabled_user_security_error_msg);
            break;
            
        case MSS_SYS_ENVM_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, DRBG_error_msg);
            break;
            
        case MSS_SYS_UNEXPECTED_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, Unexp_error_msg);
            break;
    }
}

/*==============================================================================
  Display error information related to user activation code service.
 */
void display_user_ac_error(uint8_t status)
{
    switch(status)
    {
        case MSS_SYS_ENVM_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, eNVM_error_msg);
            break;
            
        case MSS_SYS_PUF_ERROR_WHEN_CREATING:
            MSS_UART_polled_tx_string(gp_my_uart, PUF_error_msg);
            break;
            
        case MSS_SYS_INVALID_SUBCMD:
            MSS_UART_polled_tx_string(gp_my_uart, Invalid_subcmd_error_msg);
            break;
            
        case MSS_SYS_ENVM_PROGRAM_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, eNVM_program_error_msg);
            break;
            
        case MSS_SYS_ENVM_VERIFY_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, eNVM_verify_error_msg);
            break;
            
        case MSS_SYS_MEM_ACCESS_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, HRESP_error_msg);
            break;
            
        case MSS_SYS_SERVICE_NOT_LICENSED:
            MSS_UART_polled_tx_string(gp_my_uart, License_error_msg);
            break;
            
        case MSS_SYS_SERVICE_DISABLED_BY_FACTORY:
            MSS_UART_polled_tx_string(gp_my_uart, Disabled_factory_security_error_msg);
            break;
            
        case MSS_SYS_SERVICE_DISABLED_BY_USER:
            MSS_UART_polled_tx_string(gp_my_uart, Disabled_user_security_error_msg);
            break;
            
        case MSS_SYS_UNEXPECTED_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, Unexp_error_msg);
            break;
    }
}

/*==============================================================================
  Display error information related to PUF user key code service.
 */
void display_puf_user_kc_error(uint8_t status)
{
    switch(status)
    {
        case MSS_SYS_ENVM_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, eNVM_error_msg);
            break;
            
        case MSS_SYS_PUF_ERROR_WHEN_CREATING:
            MSS_UART_polled_tx_string(gp_my_uart, PUF_error_msg);
            break;
            
        case MSS_SYS_INVALID_REQUEST_OR_KC:
            MSS_UART_polled_tx_string(gp_my_uart, Invalid_request_error_msg);
            break;
            
        case MSS_SYS_ENVM_PROGRAM_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, eNVM_program_error_msg);
            break;
            
        case MSS_SYS_INVALID_HASH:
            MSS_UART_polled_tx_string(gp_my_uart, Invalid_hash_error_msg);
            break;
            
        case MSS_SYS_INVALID_USER_AC1:
            MSS_UART_polled_tx_string(gp_my_uart, Invalid_user_ac_error_msg);
            break;
            
        case MSS_SYS_ENVM_VERIFY_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, eNVM_verify_error_msg);
            break;
            
        case MSS_SYS_INCORRECT_KEYSIZE_FOR_RENEWING_A_KC:
            MSS_UART_polled_tx_string(gp_my_uart, Incorrect_key_size_error_msg);
            break;
            
        case MSS_SYS_PRIVATE_ENVM_USER_DIGEST_MISMATCH:
            MSS_UART_polled_tx_string(gp_my_uart, Digest_mismatch_error_msg);
            break;
            
        case MSS_SYS_USER_KEY_CODE_INVALID_SUBCMD:
            MSS_UART_polled_tx_string(gp_my_uart, Invalid_subcmd_error_msg);
            break;
            
        case MSS_SYS_DRBG_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, DRBG_error_msg);
            break;
            
        case MSS_SYS_MEM_ACCESS_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, HRESP_error_msg);
            break;
            
        case MSS_SYS_SERVICE_NOT_LICENSED:
            MSS_UART_polled_tx_string(gp_my_uart, License_error_msg);
            break;
            
        case MSS_SYS_SERVICE_DISABLED_BY_FACTORY:
            MSS_UART_polled_tx_string(gp_my_uart, Disabled_factory_security_error_msg);
            break;
            
        case MSS_SYS_SERVICE_DISABLED_BY_USER:
            MSS_UART_polled_tx_string(gp_my_uart, Disabled_user_security_error_msg);
            break;
            
        case MSS_SYS_UNEXPECTED_ERROR:
            MSS_UART_polled_tx_string(gp_my_uart, Unexp_error_msg);
            break;
    }
}
