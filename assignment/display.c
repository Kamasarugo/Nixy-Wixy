/*
 * display.c
 *
 * Author: Ryan Wang
 */ 

#include <stdint.h>
#include "display.h"
#include "ledmatrix.h"

// constant value used to display splash screen on launch
const uint8_t splash_display[MATRIX_NUM_COLUMNS] =
    { 
        0b11101000,  // far left column
        0b10101000, 
        0b10111000, 
        0b00011111, 
        0b00010100, 
        0b00011100, 
        0b11111000, 
        0b10001000, 

        0b11111000, 
        0b00011111, 
        0b00010100, 
        0b00011011, 
        0b10000000, 
        0b11111000, 
        0b10000000, 
        0b00011101   // far right column
    };

void show_splash_display(void)
{
    uint8_t colour_data[MATRIX_NUM_COLUMNS][MATRIX_NUM_ROWS];
    for (uint8_t x = 0; x < MATRIX_NUM_COLUMNS; x++)
    {
        // go through the bottom 8 bits and set any to be the correct colour
        for(uint8_t y = 0; y < MATRIX_NUM_ROWS; y++)
        {
            if(splash_display[x] & (1<<y))
            {
                colour_data[x][y] = COLOUR_YELLOW;
            }
            else
            {
                colour_data[x][y] = COLOUR_BLACK;
            }
        }
    }
    ledmatrix_update_display(colour_data);
}

// 6 rows by 3 columns, padded to 8 rows centered
// first uint8_t element in each entry is left column
// MSB of each uint8_t is top pixel
const uint8_t font[10][3] =
{
	{ 0b00111100, 0b01000010, 0b00111100 }, // '0'
	{ 0b00100010, 0b01111110, 0b00000010 }, // '1'
	{ 0b01001110, 0b01010010, 0b00100010 }, // '2'
	{ 0b01000010, 0b01010010, 0b00111100 }, // '3'
	{ 0b01110000, 0b00010000, 0b01111110 }, // '4'
	{ 0b01110010, 0b01010010, 0b01001100 }, // '5'
	{ 0b00111100, 0b01010010, 0b01001100 }, // '6'
	{ 0b01000000, 0b01011110, 0b01100000 }, // '7'
	{ 0b00101100, 0b01010010, 0b00101100 }, // '8'
	{ 0b00110010, 0b01001010, 0b00111100 }, // '9'
};

// 4 rows by 2 columns - one nybble for each column
const uint8_t font_small[10] =
{
	0b11111111, // '0'
	0b00001111, // '1'
	0b10111101, // '2'
	0b10111111, // '3'
	0b01101111, // '4'
	0b11011011, // '5'
	0b11111011, // '6'
	0b10001111, // '7'
	0b10111011, // '8'
	0b11011111, // '9'
};

void show_zero_zero(void)
{
    uint8_t colour_data[MATRIX_NUM_COLUMNS][MATRIX_NUM_ROWS];
    for (uint8_t x = 0; x < MATRIX_NUM_COLUMNS; x++)
    {
        uint8_t data = 0;
        // get the glyph column for 0 if in the correct column;
        // other columns should be fully blank
        if (x == 4 || x == 12)
        {
            data = font[0][0];
        }
		else if (x == 5 || x == 13)
        {
            data = font[0][1];
        }
		else if (x == 6 || x == 14)
        {
            data = font[0][2];
        }
        // go through the bottom 8 bits and set any to be the correct colour
        for(uint8_t y = 0; y < MATRIX_NUM_ROWS; y++)
        {
            if(data & (1<<y))
            {
                colour_data[x][y] = COLOUR_YELLOW;
            }
            else
            {
                colour_data[x][y] = COLOUR_BLACK;
            }
        }
    }
    ledmatrix_update_display(colour_data);
}

void show_score(uint8_t home, uint8_t away
    {
        uint8_t colour_data[MATRIX_NUM_COLUMNS][MATRIX_NUM_ROWS];
        for (uint8_t x = 0; x < MATRIX_NUM_COLUMNS; x++)
        {
            uint8_t data = 0
            if (x >=2 && x<=4) {
                data = font[home/10][x-2];
            }
            else if (x >=5 && x <=7) {
                data = font[home % 10][x-5];
            }
            else if (x >=9 && x <=11) {
                data = font[away/10][x-9];
            }
            else if (x >=12 && x<=14){
                data = font[away % 10][x-12];
            }

            for (uint8_t y = 0; y < MATRIX_NUM_ROWS; y++)
            {
                if (data & (1<<y))
                {
                    colour_data[x][y] = COLOUR_YELLOW;
                }
                else
                {
                    colour_data[x][y] = COLOUR_BLACK;
                }
            }
        }
    }

void draw_digit(uint8_t digit, uint8_t x_position, uint8_t colour
{
    
    // todo
    // first, implement an "update column" SPI command in ledmatrix.c
	// then
    // get one column of the digit's glyph from the font array
    // expand this into an array of pixel colours for that column
    // send that to the LED matrix with your new ledmatrix.c command
    // repeat for the other two columns
    // see show_splash_display or show_zero_zero for a similar, but not identical, process
}
