/*
 * terminalio.h
 *
 * Author: Peter Sutton
 *
 * Functions for interacting with the terminal. These should be used
 * to encapsulate all sending of escape sequences.
 */

#ifndef TERMINAL_IO_H_
#define TERMINAL_IO_H_

#include <stdint.h>

// x (column number) and y (row number) are measured relative to the
// top left of the screen. First column is 1, first row is 1.
void move_terminal_cursor(int x, int y);
void clear_terminal(void);

#endif /* TERMINAL_IO_H */
