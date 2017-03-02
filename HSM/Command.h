#ifndef COMMAND_H
#define COMMAND_H

#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include "common.h"

void COMMAND_USER_process(uint8_t * command);
void COMMAND_DATASIGN_process(uint8_t * command);
void COMMAND_CERTMGT_process(uint8_t * command);
void COMMAND_LOGS_process(uint8_t * command);
void COMMAND_TIME_process(uint8_t * command);
void COMMAND_SESSION_process(uint8_t * command);

void COMMAND_ERROR(char * message);
void COMMAND_process(uint8_t * command);

#endif // COMMAND_H
