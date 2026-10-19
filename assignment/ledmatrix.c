/*
 * ledmatrix.c
 *
 * Author: Peter Sutton
 * 
 * See the LED matrix Reference for details of the SPI commands used.
 */ 

#include <avr/io.h>
#include "ledmatrix.h"
#include "spi.h"


#define CMD_UPDATE_DISP      0x00
#define CMD_CLEAR_SCREEN     0x0F


void ledmatrix_update_display(uint8_t pixels[MATRIX_NUM_COLUMNS][MATRIX_NUM_ROWS])
{
    (void)spi_send_byte(CMD_UPDATE_DISP);
    for (uint8_t y = 0; y < MATRIX_NUM_ROWS; y++)
    {
        for (uint8_t x = 0; x < MATRIX_NUM_COLUMNS; x++)
        {
            (void) spi_send_byte(pixels[x][y]);
        }
    }
}

void ledmatrix_clear(void)
{
    (void)spi_send_byte(CMD_CLEAR_SCREEN);
}

// sure would be useful to be able to use the other LED matrix commands...
