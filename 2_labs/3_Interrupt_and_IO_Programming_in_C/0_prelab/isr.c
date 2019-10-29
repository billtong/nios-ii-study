#include "nios2_control.h"
#include "leds.h"
#include "timer.h"

extern int flag;

void interrupt_handler(void)
{
	unsigned int ipending;


	/* read current value in ipending register */
  ipending = NIOS2_READ_IPENDING();

	/* _if_ ipending bit for timer is set,
	   _then_
	       clear timer interrupt,
	       and toggle the least-sig. LED
	       (use the C '^' operator for XOR with constant 1)
	*/
  if (ipending)
  {
    *TIMER_STATUS = 0;
    *LEDS = *LEDS  + 1;
    flag = 1;
  }
}
