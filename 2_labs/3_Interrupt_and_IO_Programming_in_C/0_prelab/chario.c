#include "chario.h"

void PrintChar(int ch)
{
  if (*JTAG_UART_STATUS & 0xFFFF)
  {
    *JTAG_UART_DATA = ch;
  }
  
}

void PrintString(char * str)
{
  int counter = 0;
  while(str[counter] != '\0')
  {
    PrintChar(str[counter]);
    counter++;
  }
}