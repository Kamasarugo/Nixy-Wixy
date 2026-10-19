/*
 * ledmatrix.h
 *
 * Author: Peter Sutton, Ryan Wang
 */ 

#ifndef LEDMATRIX_H_
#define LEDMATRIX_H_


#include <stdint.h>
#include "spi.h"


// The matrix has 16 columns (x ranges from 0 to 15, left to right) and 
// 8 rows (y ranges from 0 to 7, bottom to top) - as per the X,Y
// coordinates marked on the board.
#define MATRIX_NUM_COLUMNS 16
#define MATRIX_NUM_ROWS 8

// Colour definitions
#define COLOUR_BLACK     0x00
#define COLOUR_YELLOW    0xFF


// Functions to update the display
// For those functions which take an x or a y value, the value must be
// valid or the request will be ignored. (i.e. 0 <= x < MATRIX_NUM_COLUMNS
// and 0 <= y < MATRIX_NUM_ROWS)
void ledmatrix_update_display(uint8_t pixels[MATRIX_NUM_COLUMNS][MATRIX_NUM_ROWS]);
void ledmatrix_clear(void);

#endif /* LEDMATRIX_H_ */
