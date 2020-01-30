#include "chario.h"


//waits till availible and prits a character 
 void PrintChar(unsigned int c){
	
	unsigned int status;
	//loop until status shows its free 
	while(!((*JTAG_UART_STATUS) & STATUS_MASK ));
	*JTAG_UART_DATA = c;//write the character
	
	return;
}

//calls print char to print a string until \n
 void PrintString(char *c){
	int idx =0;
	while(c[idx] != '\0'){
		PrintChar(c[idx]);
		idx++;
	}
	return;
}
