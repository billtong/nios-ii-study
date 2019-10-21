# software
## c
- the DE0 output port word data address for the green LEDs is 0x10000010. Using a #define appropriately, write code that would appear within a program in the C language to turn on(i.e. light up) all ten of the LEDs.
```c
  #define LED_PORT (volatile unsigned int*) 0x10000010
  *LED_PORT = 0x3FF;
```
- The DE0 input port word data address for the switches is 0x10000040. The DE0 output port word data address for the green LEDs is 0x10000010. Write a short but complete program in the C language that continuously shows the switch settings on the green LEDs.
```c
  #define LED_PORT (volatile unsigned int*) 0x10000010
  #define SWITCHES (volatile unsigned int*) 0x10000040
  void main()
  {
    while(1)
    {
      *LED_PORT = *SWITCHES;
    }
  }
```
- How can processor control registers be accessed within a C function?
```
Use special asm("..."); directive to embed assembly-language instructions within C code
Alternative: write an assembly-language subroutine for control registers, and call it from C
```