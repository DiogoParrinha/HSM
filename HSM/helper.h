/*******************************************************************************
 * (c) Copyright 2012-2016 Microsemi SoC Products Group.  All rights reserved.
 *
 * Helper function public API.
 *
 * SVN $Revision: 8346 $
 * SVN $Date: 2016-03-23 12:18:12 +0530 (Wed, 23 Mar 2016) $
 */
#ifndef __HELPER_H_
#define __HELPER_H_ 1

#include "CMSIS/m2sxxx.h"
void write_ptr_value_into_array
(
    const uint8_t * pointer,
    uint8_t target_array[],
    uint32_t array_index
);
uint8_t convert_ascii_to_hex(uint8_t* arr, uint32_t length);
uint8_t validate_input(uint8_t ascii_input);
void display_hex_values(uint8_t* in_buffer, uint32_t byte_length);
void clear_variable(volatile uint8_t *p_var, uint16_t size);
void write_array_into_ptr_value
( 
    uint8_t** pointer,
    uint8_t target_array[],
    uint32_t array_index
);
uint16_t get_data_from_uart(uint8_t* src_ptr, uint16_t size, const uint8_t* msg);
void display_user_ac_error(uint8_t status);
void display_puf_user_kc_error(uint8_t status);
void display_read_user_puf_key_error(uint8_t status);
void display_puf_public_key_error(uint8_t status);
void display_puf_seed_error(uint8_t status);

#endif /* __HELPER_H_ */
