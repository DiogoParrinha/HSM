/*
 * common.c
 *
 *  Created on: 10/02/2017
 *      Author: diogo
 */

#include "common.h"
#include <stdio.h>

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

