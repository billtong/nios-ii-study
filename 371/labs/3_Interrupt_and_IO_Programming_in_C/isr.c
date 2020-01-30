#include "nios2_control.h"
#include "leds.h"
#include "timer.h"
#include "button.h"

extern volatile char interuptFlag;
void interrupt_handler(void)
{
	/* read current value in ipending register, using macro */
	unsigned int ipending;
	
	ipending = NIOS2_READ_IPENDING();
	
	/* _if_ ipending bit for timer is set,
	   _then_
	       clear timer interrupt,
	       and toggle the least-sig. LED
	       (use the C '^' operator for XOR with constant 1)
	*/
	
	//check if interrupt is caused by timer
	if(ipending & 0x1){
		//clear timer interupt bit 
		*TIMER_STATUS = 0x1;//write it back into mem/IO
		
		//flip led bits
		*LEDS = *LEDS ^ 0x1; //bitwise XOR on contents of word at LEDS address (led control bits), toggles lowest LED 
		interuptFlag = 1;
	}//end if
	//check if interrupt is caused by button
	if(ipending & 0x2){
		//clear button interrupt
		*BUTTONS_EDGE_REGISTER = 0xFFFFFFFF;
		//flip bit 1 led
		*LEDS = *LEDS ^ 0x2;
	} 
	
}
