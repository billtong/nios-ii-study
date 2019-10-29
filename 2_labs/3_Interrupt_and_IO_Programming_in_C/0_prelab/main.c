#include "nios2_control.h"
#include "timer.h"
#include "chario.h"

int flag;

void	Init (void)
{
  /* initialize software variables */
  int counter;

  /* set the interval timer period for scrolling the HEX displays */
  counter = 0x1770000;

  /* set timer start value for interval of HALF SECOND (0.5 sec) */
  *TIMER_START_LO = (counter & 0xFFFF);
  *TIMER_START_HI = (counter >> 16) & 0xFFFF;
	
  /* clear extraneous timer interrupt */
  //??

  /* set ITO, CONT, and START bits of timer control register */
  *TIMER_CONTROL = 0x7;

  /* set device-specific bit for timer in Nios II ienable register */
  NIOS2_WRITE_IENABLE( 0x1 );

  /* set IE bit in Nios II status register */
  NIOS2_WRITE_STATUS( 1 );
}


int	main (void)
{

  /* perform initialization */
  Init ();

  /* main program is an empty infinite loop */
  while (1)
  {
    if (flag)
    {
      flag = 0;
      PrintChar('*');
    }
    
  }


  return 0; /* never reached, but needed to avoid compiler warning */
}
