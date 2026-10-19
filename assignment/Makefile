# Target microcontroller and clock speed (Standard for CSSE2010 ATmega324A boards)
MCU = atmega324a
F_CPU = 8000000UL

# Compiler definitions
CC = avr-gcc
OBJCOPY = avr-objcopy
CFLAGS = -Wall -Os -mmcu=$(MCU) -DF_CPU=$(F_CPU) -std=gnu99

# Automatically find all .c files in your directory and list corresponding .o objects
SOURCES = $(wildcard *.c)
OBJECTS = $(SOURCES:.c=.o)

# Name of the final output program
TARGET = sportsball

all: $(TARGET).hex

# Link objects together to form the binary executable
$(TARGET).elf: $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS)

# Compile individual source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Convert the executable binary into Intel HEX format for the microcontroller
$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

# Command to clean intermediate build files
clean:
	rm -f *.o *.elf *.hex

.PHONY: all clean
