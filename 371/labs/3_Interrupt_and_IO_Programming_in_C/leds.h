#ifndef _LEDS_H_
#define _LEDS_H_


/* define pointer macro for accessing the LED interface data register */

#define LEDS	((volatile unsigned int *) 0x10000010)

#define HEX_LEDS	((volatile unsigned int *) 0x10000020)

#endif /* _LEDS_H_ */
