#define JTAG_UART_DATA 		((volatile unsigned int *) 0x10001000)
#define JTAG_UART_STATUS 	((volatile unsigned int *) 0x10001004)
#define STATUS_MASK	0xFFFF0000

extern void PrintChar(unsigned int c);
extern void PrintString(char *c);
