/*
 * terminalio.c
 *
 * Author: Peter Sutton
 */

#include <stdio.h>
#include <stdint.h>

#include "terminalio.h"

void move_terminal_cursor(int x, int y)
{
    printf("\x1b[%d;%dH", y, x);
}

void clear_terminal(void)
{
    printf("\x1b[2J");
}
