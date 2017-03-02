#ifndef LOGS_H
#define LOGS_H

#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include "common.h"

#define LOGS_HASHES_PER_BLOCK 128
#define LOGS_CURRENT_DAY_BLOCK 1
#define LOGS_DAYS_BLOCK 2
#define LOGS_MONTHS_BLOCK 3

uint8_t LOGS_currentQueue[LOGS_HASHES_PER_BLOCK]; // today's current queue
uint8_t LOGS_daysQueue[LOGS_HASHES_PER_BLOCK]; // past 128 days queue
uint8_t LOGS_monthsQueue[LOGS_HASHES_PER_BLOCK]; // past 128 months queue

void LOGS_init();
void LOGS_terminate();

uint8_t* LOGS_getHash(uint8_t n); // n goes from 0 to 127
uint8_t* LOGS_getHashDay(uint8_t n); // n goes from 0 to 127
uint8_t* LOGS_getHashMonth(uint8_t n); // n goes from 0 to 127

BOOL LOGS_add(uint8_t * hash);

#endif // LOGS_H
