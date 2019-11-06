#ifndef _TIMER_H_
#define _TIMER_H_


/* define pointer macros for accessing the timer interface registers */

#define TIMER_STATUS	((volatile unsigned int *) 0x10002000)

#define TIMER_CONTROL	((volatile unsigned int *) 0x10002004)

#define TIMER_START_LO	((volatile unsigned int *) 0x10002008)

#define TIMER_START_HI	((volatile unsigned int *) 0x1000200C)

#define TIMER_SNAP_LO	((volatile unsigned int *) 0x10002010)

#define TIMER_SNAP_HI	((volatile unsigned int *) 0x10002014)


/* define a bit pattern reflecting the position of the timeout (TO) bit
   in the timer status register */

#define TIMER_TO_BIT 0x1


#endif /* _TIMER_H_ */
