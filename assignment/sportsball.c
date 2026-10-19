/*
 * sportsball.c
 *
 *
 * Authors: Peter Sutton, Bradley Stone, Ryan Wang
 * Modified by <YOUR NAME HERE>, <YOUR STUDENT ID HERE>
 */


/* Definitions */
#include <stdint.h>
#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>

/* Internal Library Includes */
#include "serialio.h"
#include "terminalio.h"
#include "ledmatrix.h"
#include "display.h"


/* Internal Function Declarations */
void initialise_hardware(void);
void splash_screen(void);
void run_game(void);

uint8_t score_home;
uint8_t score_away;

int main(void)
{
    initialise_hardware();
    while (1)
    {
        splash_screen();
        run_game();
    }
}

void initialise_hardware(void)
{
    spi_setup_master(128); // init LED matrix
    // Setup serial port for 19200 baud communication
    init_serial_stdio(19200);
    sei(); // enable global interrupts
}

void splash_screen(void)
{
    // draw sigil on LED matrix
    show_splash_display();
    
    clear_terminal();
    // '\' in output are escaped to '\\' in this array
    // alas, this causes the source code to misalign
    const char *ascii_art[11] = {
        "  /$$$$$$                                  /$$              /$$$$$$$            /$$ /$$",
        " /$$__  $$                                | $$             | $$__  $$          | $$| $$",
        "| $$  \\__/  /$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$   /$$$$$$$| $$  \\ $$  /$$$$$$ | $$| $$",
        "|  $$$$$$  /$$__  $$ /$$__  $$ /$$__  $$|_  $$_/  /$$_____/| $$$$$$$  |____  $$| $$| $$",
        " \\____  $$| $$  \\ $$| $$  \\ $$| $$  \\__/  | $$   |  $$$$$$ | $$__  $$  /$$$$$$$| $$| $$",
        " /$$  \\ $$| $$  | $$| $$  | $$| $$        | $$ /$$\\____  $$| $$  \\ $$ /$$__  $$| $$| $$",
        "|  $$$$$$/| $$$$$$$/|  $$$$$$/| $$        |  $$$$//$$$$$$$/| $$$$$$$/|  $$$$$$$| $$| $$",
        " \\______/ | $$____/  \\______/ |__/         \\___/ |_______/ |_______/  \\_______/|__/|__/",
        "          | $$                                                                         ",
        "          | $$                                                                         ",
        "          |__/                                                                         "};
    
    for (uint8_t i = 0; i < 11; i++)
    {
        move_terminal_cursor(10, 2+i);
        printf("%s", ascii_art[i]);
    }
    
    move_terminal_cursor(10, 16);
    printf("CSSE%d AVR Project", 2010); // change if masters student
    move_terminal_cursor(10, 18);
    printf("\"Sportsball Scoreboard Emulator\"");
    move_terminal_cursor(10, 20);
    printf("%d, Semester %s", 2026, "Two");
    move_terminal_cursor(10, 22);
    // "%ld" is "long decimal", since a student number is bigger than 2**16
    printf("By %s (%ld)", "Kobi Macartney", 50265523);
    
    // Wait until a button is pressed
    while(!(PINB & 0x0F))
    {
        ; // do nothing til button press
    }
    
}

void run_game(void)
{
    // as you are filling in this function,
    // you may wish to consider splitting it up into several functions
    // for example, contemplate what needs to be done:
    // a) at the start of a game;
    // b) at the end of a quarter;
    // c) during the game; and
    // d) at the end of the game
    show_zero_zero();
    clear_terminal();
    score_home = 0;
    score_away = 0;

    while(1)
    {
        if (PINB & (1 << 2))
        {
            if (score_home < 99)
            {
                score_home++;
                printf("Home_score: %u", score_home)
            }
            while (PINB & (1 << 2))
            {
                ;
            }
        }
    }
}
