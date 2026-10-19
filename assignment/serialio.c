#include <stdio.h>
#include <stdint.h>
#include <avr/io.h>
#include <avr/interrupt.h>


#define OUTPUT_BUFFER_SIZE 128
volatile char output_buffer[OUTPUT_BUFFER_SIZE];
volatile uint8_t output_insert_pos;
volatile uint8_t output_dislodge_pos;
volatile uint8_t output_chars_to_send;

#define INPUT_BUFFER_SIZE 16
volatile char input_buffer[INPUT_BUFFER_SIZE];
volatile uint8_t input_insert_pos;
volatile uint8_t input_dislodge_pos;
volatile uint8_t input_chars_to_process;


/* Setup a stream to be used by the USART interrupts. We will make standard input and output use this stream 
 * below. The rationale for this is that it allows us to use functions that read from the standard input or write to
 * the standard output, such as printf.
*/
int uart_put_char(char, FILE*);
int uart_get_char(FILE*);
FILE IOStream = FDEV_SETUP_STREAM(uart_put_char, uart_get_char, _FDEV_SETUP_RW);


void init_serial_stdio(uint32_t baudrate)
{
    // Reset the buffer positions to zero.
    output_insert_pos = 0;
    output_dislodge_pos = 0;
    output_chars_to_send = 0;
    input_insert_pos = 0;
    input_dislodge_pos = 0;
    input_chars_to_process = 0;
    
    // Configure the serial port baud rate (this differs from the datasheet formula so that we get rounding to the 
    // nearest integer while still using integer division, which truncates).
    UBRR0 = ((8000000L / (8 * baudrate)) + 1)/2 - 1;
    
    // Enable USART receiver and transmitter.
    UCSR0B = (1<<RXEN0) | (1<<TXEN0);
    
    //  Enable the RX complete interrupt. We don't need to worry about the TX for now, since we can and will enable
    //  that when we actually send something (in the uart_put_char function).
    UCSR0B |= (1 <<RXCIE0);

    // Redirect the standard input/output to out stream. By doing this, we will call uart_put_char whenever we write
    // to the standard output, and we will call uart_get_char whenever we read from the standard input.
    stdout = &IOStream;
    stdin = &IOStream;
}

/* This function will add a character to the output buffer, and turn on the TX interrupt (if it isn't already). It
 * will return zero on success, and a non-zero integer on failure (this is traditional, as there is usually only one
 * mode of success, but there can be many modes of failure, and the zero/non-zero split allows the return value to
 * be zero-tested to see if error handling is needed; we do not use the return value here, but CSSE2310 covers this
 * sort of thing).
*/
int uart_put_char(char c, FILE* stream)
{
    /* The newline character \n behaves differently on different systems. In some places, especially older systems, it
     * moves the cursor one line vertically, but does not change location horizontally. PuTTY uses this behaviour. The
     * carriage return character \r will move the cursor horizontally to the start of the current line. Using both in
     * combination will move the cursor to the start of the next line. Here, whenever we would send a \n, we also send
     * a \r.
    */
    if(c == '\n')
    {
        uart_put_char('\r', stream);
    }
    
    /* If the TX interrupt fires while we are modifying the circular buffer, it's possible that it will do so while we
     * are between two important instructions, which may result in the buffer being corrupted. As such, we will disable
     * interrupts, then enable them again once we are done. However, we need to remember if interrupts were enabled
     * initially, so that we cause no net change to the interrupt status.
    */
    uint8_t interrupts_enabled = SREG & (1<<SREG_I);
    /* If the output buffer is too full, then we will need to wait for it to empty. However, if interrupts are disabled,
     * then the output buffer is not getting processed, and so this would infinite loop. In that case, we should exit this
     * function and return an error code.
    */
    while(output_chars_to_send >= OUTPUT_BUFFER_SIZE)
    {
        if(!interrupts_enabled)
        {
            return 1;
        }
    }
    cli();
    
    // Insert the character into the output buffer at the correct position
    output_buffer[output_insert_pos] = c;
    // Increment the output insertion point; if the output insertion point is at the end of the buffer, reset it to the start.
    output_insert_pos++;
    if(output_insert_pos == OUTPUT_BUFFER_SIZE)
    {
        output_insert_pos = 0;
    }
    // Increment the count of the number of characters waiting to be sent.
    output_chars_to_send++;
    // Turn on the USART Data Register Empty Interrupt.
    UCSR0B |= (1 << UDRIE0);
    
    if(interrupts_enabled)
    {
        sei();
    }
    return 0;
}

/* This interrupt will fire, if enabled, whenever the USART is able to receive a new byte to send
*/
ISR(USART0_UDRE_vect)
{
    if(output_chars_to_send > 0)
    {
        // Read the character from the output buffer at the correct position.
        char c = output_buffer[output_dislodge_pos];
        // Increment the output dislogement point; if the output dislogement point is at the end of the buffer, reset it to the start.
        output_dislodge_pos++;
        if(output_dislodge_pos == OUTPUT_BUFFER_SIZE)
        {
            output_dislodge_pos = 0;
        }
        // Decrement the count of the number of characters waiting to be sent.
        output_chars_to_send--;
        // Send the character to the USART data register
        UDR0 = c;
    }
    else
    {
        /* If there are no more characters to send, we want to disable this interrupt (otherwise it will immediately
         * fire again).
        */
        UCSR0B &= ~(1<<UDRIE0);
    }
}

/* This interrupt will fire, if enabled, whenever the USART receives a new character
*/
ISR(USART0_RX_vect)
{
    if(input_chars_to_process < INPUT_BUFFER_SIZE)
    {
        // Read the character from the USART data register, and insert it into the input buffer at the correct position.
        char c = UDR0;
        input_buffer[input_insert_pos] = c;
        // Increment the insertion point; if it is at the end of the buffer, reset it to the start.
        input_insert_pos++;
        if(input_insert_pos == INPUT_BUFFER_SIZE)
        {
            input_insert_pos = 0;
        }
        // Increment the count of the number of characters waiting to be processed.
        input_chars_to_process++;
    }
    // If there is no room in the input buffer, nothing will happen, and the character is likely to be lost.
}

/* This function will run whenever the standard input is read. It will return the oldest character from input buffer.
 * Standard input functions must be able to return any char as well as some special informational codes. As such, a
 * mere char is insufficient to store the values that can be returned, so standard input functions generally return an
 * int, and consequently so does this function. Casting the return int to a char will result in the correct char if
 * the int did in fact represent a char, or it will result in a "random" char if not.
*/
int uart_get_char(FILE* stream)
{
    // Many input reading functions are blocking i.e. if there is no input available, they will wait until there is.
    // This while loop will emulate this.
    while(input_chars_to_process == 0)
    {
        
    }
    
    //Similar to the above, we don't want interrupts firing while we are dealing with the buffer.
    uint8_t interrupts_enabled = SREG & (1<<SREG_I);
    cli();
    
    // Read the character from the input buffer at the correct position, increment the input dislogement point.
    char c = input_buffer[input_dislodge_pos];
    input_dislodge_pos++;
    // If the input dislogement point is at the end of the buffer, reset it to the start.
    if(input_dislodge_pos == INPUT_BUFFER_SIZE)
    {
        input_dislodge_pos = 0;
    }
    // Decrement the count of the number of characters waiting to be processed.
    input_chars_to_process--;

    if(interrupts_enabled)
    {
        sei();
    }
    return c;
}

uint8_t serial_input_available(void)
{
    return input_chars_to_process > 0;
}
