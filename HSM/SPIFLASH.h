#ifndef SPIFLASH_H
#define SPIFLASH_H

#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include "common.h"

void SPIFLASH_init();
void SPIFLASH_terminate();

/*
 * Read bytes from block (ID-1) into buffer
 *
 * Buffer must be as long as len
 */
void SPIFLASH_readBytes(uint8_t ID, uint8_t * buffer, uint32_t len, uint32_t base_addr);

/*
 * Read block (ID-1) into buffer
 *
 * Buffer must be as long as FLASH_BLOCK_SIZE
 */
void SPIFLASH_readBlock(uint8_t ID, uint8_t * buffer, uint32_t base_addr);

/*
 * Write buffer into block (ID-1)
 */
void SPIFLASH_writeBlock(uint8_t ID, uint8_t * buffer, uint32_t base_addr);

/*
 * Erase block (ID-1)
 */
BOOL SPIFLASH_eraseBlock(uint8_t ID, uint32_t base_addr);

/*
 * Erase all
 */
void SPIFLASH_eraseAll();

#endif // SPIFLASH_H
