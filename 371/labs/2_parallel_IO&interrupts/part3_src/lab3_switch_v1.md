### question
Move the actions for responding to a button interrupt from the interrupt service routine to a new subroutine HandleButton(). The if statement stays in the ISR, but the then body now simply calls the new subroutine.  
Extends the button-interrupt actions to read the switch settings on the DE0 board and add the value from the switches to a variable sum in memory. Modify the Init() code to explicitly intialize this variable to zero.  
Finally modify the main routine loop to also check the current value of the sum variable. If the value of that variable is larger than 256, a break instruction should be executed, which will cause the program(incl. the timer interrupt activity) to simply halt.
### pseudocode