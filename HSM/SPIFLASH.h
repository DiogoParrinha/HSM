#ifndef SPIFLASH_H
#define SPIFLASH_H

#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include "UART.h"
#include "Common.h"

#define FLASH_BASE_ADDRESS 0x0
#define FLASH_BLOCK_SIZE 4096

// Can't be 255 because when erased, all bytes=255 so we can't check if it's 255 because it will be for empty ones and we couldn't distinguish
#define FLASH_MAX_BLOCKS 254

uint8_t SPIFLASH_total;
uint8_t SPIFLASH_list[FLASH_MAX_BLOCKS];

void SPIFLASH_init();
void SPIFLASH_terminate();

/*
 * Read bytes from block (ID-1) into buffer
 *
 * Buffer must be as long as len
 */
void SPIFLASH_readBytes(uint8_t ID, uint8_t * buffer, uint32_t len);

/*
 * Read block (ID-1) into buffer
 *
 * Buffer must be as long as FLASH_BLOCK_SIZE
 */
void SPIFLASH_readBlock(uint8_t ID, uint8_t * buffer);

/*
 * Write buffer into block (ID-1)
 */
void SPIFLASH_writeBlock(uint8_t ID, uint8_t * buffer);

/*
 * Erase block (ID-1)
 */
BOOL SPIFLASH_eraseBlock(uint8_t ID);

/*
 * Erase all
 */
void SPIFLASH_eraseAll();

#endif // SPIFLASH_H
