#include "nios2_control.h"
#include "timer.h"
#include "chario.h"
#include "button.h"
#include "switch.h"
#include "leds.h"

void	Init (void)
{
  /* initialize software variables */
  /* set timer start value for interval of HALF SECOND (0.5 sec) */
	*TIMER_START_LO = 25000000&0x0000FFFF; //0x7840; //
	*TIMER_START_HI= 25000000>>16; //0x17D; //0x017D7840
  /* clear extraneous timer interrupt */
	*TIMER_STATUS =0x0;
  /* set ITO, CONT, and START bits of timer control register */
  //thats bits 0,1,2, 0111 = 0x7
	*TIMER_CONTROL = 0x7;
  /*set bits for button mask to enable button interrupts*/
	*BUTTONS_MASK_REGISTER = 0x3;//check this
  /* set device-specific bit for timer in Nios II ienable register */
	NIOS2_WRITE_IENABLE(0x3);//0 bit is for the timer, 1 bit is for the button.
  /* set IE bit in Nios II status register */
	NIOS2_WRITE_STATUS(0x1);
}

volatile int interuptFlag =0;

void switches() 
{
	PrintString("\b\b\b\b\b\b\b\b\b\b");
	unsigned int value = *SWITCH_DATA_REGISTER;
	unsigned int mask_value = 1<<9;
	int i=0;
	while (i < 10) 
	{
		if (value & mask_value) PrintChar('#');
		else PrintChar(':');
		mask_value = mask_value >> 1;
		i++;
	}
  if (value == 1023)  //0b11 1111 111 all switches on
    *HEX_LEDS = 4294967295; //0xffff ffff
}


int	main (void)
{

  /* perform initialization */
  Init ();
	PrintString("ELEC371 Lab 3\n");
	int i;
	//char buffer[num];
	//for(i=0; i<num; i++) buffer[i] = ' ';
	PrintString("          ");
  	// PrintString("button2 ");
  while (1)
  {
	  if (interuptFlag) 
    {
		  interuptFlag=0;
      switches();
	  }
  }
  return 0; /* never reached, but needed to avoid compiler warning */
}

//  if(interuptFlag !=0){
// 			interuptFlag=0;
// 			//PrintChar('*');
// 			//variable to keep track if we printed a backspace
// 			int havePrintedBackSpace = 0;//set to false initially.
// 			if(havePrintedBackSpace == 0){
// 				PrintChar('\b');//check
// 				havePrintedBackSpace = 1;
// 			}//end if
// 			//if the second bit is high
// 			if(*BUTTONS_DATA_REGISTER & 0x4){
// 				PrintChar('^');
// 				*LEDS = *LEDS ^ 0x3FC; //flipping top 8 led bits. 
// 		} else{
// 			PrintChar('V');
// 		}