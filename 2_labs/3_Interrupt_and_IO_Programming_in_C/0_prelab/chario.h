#ifndef _CHARIO_H_
#define _CHARIO_H_

#define JTAG_UART_DATA (volatile unsigned int *) 0x10001000
#define JTAG_UART_STATUS (volatile unsigned int *) 0x10001004

void PrintChar(int);
void PrintString(char *);

#endif;