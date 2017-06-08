/**
 * \file sha256_fpga.h
 *
 * \brief SHA-256 Driver for FPGA core
 *
 *  Copyright (C) 2017, Diogo Parrinha, All Rights Reserved
 *
 */
#ifndef MBEDTLS_SHA256_ALT_H
#define MBEDTLS_SHA256_ALT_H

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define AHB_BASE_ADDR 0x31000000

void SHA256_FPGA_init();
void SHA256_FPGA(uint8_t * data, uint8_t * hash, uint8_t first, uint8_t last);

#endif
