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

	// instead, let's do some modifications to the structure we have
	// we're going to use the hardware RNG so this doesn't really matter!
	uint32_t timer = calendar_count.second + calendar_count.minute*60 + calendar_count.hour*60*60 + calendar_count.day*24*60*60 + calendar_count.month*30*24*60*60;

	MSS_RTC_clear_update_flag();

    *olen = 0;

    if( len < sizeof(uint32_t) )
        return(0);

    memcpy(output, &timer, sizeof(uint32_t));
    *olen = sizeof(uint32_t);

    return(0);
}
