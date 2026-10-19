/*
 * display.h
 *
 * Author: Ryan Wang
 */ 

#ifndef DISPLAY_H_
#define DISPLAY_H_

/*
 * display a start screen
 */
void show_splash_display(void);

/*
 * display 0-0 score at the start of the game
 */
void show_zero_zero(void);

/*
 * draws a small char glyph on the LED matrix starting at x_position (columnn number)
 */
void draw_digit(uint8_t digit, uint8_t x_position, uint8_t colour);

#endif 
