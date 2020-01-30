#-----------------------------------------------------------------------------
# This template source file for ELEC 371 Lab 2 experimentation with interrupts
# also serves as the template for all assembly-language-level coding for
# Nios II interrupt-based programs in this course. DO NOT USE the approach
# shown in the documentation for the DE0 Basic (or Media) Computer. The
# approach illustrated in this template file is far simpler for learning.
#
# N. Manjikian  Sept. 2019
#-----------------------------------------------------------------------------

	.text		# start a code segment 

	.global	_start	# export _start symbol for linker 

#-----------------------------------------------------------------------------
# Define symbols for memory-mapped I/O register addresses and use them in code
#-----------------------------------------------------------------------------

# the symbols below are specifically for the Lab 2 pushbutton/LED experiment

	.equ	BUTTONS_MASK_REGISTER, ???????
	.equ	BUTTONS_EDGE_REGISTER, ???????

	.equ	LEDS_DATA_REGISTER, ???????

#-----------------------------------------------------------------------------
# Define two branch instructions in specific locations at the start of memory
#-----------------------------------------------------------------------------

	.org	0x0000	# this is the _reset_ address 
_start:
	br	main	# branch to actual start of main() routine 

	.org	0x0020	# this is the _exception/interrupt_ address
 
	br	isr	# branch to start of interrupt service routine 
			# (rather than placing all of the service code here) 

#-----------------------------------------------------------------------------
# The actual program code (incl. service routine) can be placed immediately
# after the second branch above, or another .org directive could be used
# to place the program code at a desired address (e.g., 0x0080). It does not
# matter because the _start symbol defines where execution begins, and the
# branch at that location simply force execution to continue where desired.
#-----------------------------------------------------------------------------

main:
	???????			# initialize stack pointer

	???????			# call hw/sw initialization subroutine

	???????			# perform any local initialization before main loop 

mainloop:

	???????			# body of main loop (reflecting typical embedded
					#   software organization where execution does not
					#   terminate)

	br mainloop

#-----------------------------------------------------------------------------
# This subroutine should encompass preparation of I/O registers as well as
# special processor registers for recognition and processing of interrupt
# requests. Preparation of program data can also be included here.
#-----------------------------------------------------------------------------

Init:

	???????			# body of Init() subroutine

	ret

#-----------------------------------------------------------------------------
# The code for the interrupt service routine is below. Note that the branch
# instruction at 0x0020 is executed first upon recognition of interrupts,
# and that branch brings the flow of execution to the code below. Therefore,
# the actual code for this routine can be anywhere in memory for convenience.
# This template involves only hardware-generated interrupts. Therefore, the
# return-address adjustment on the ea register is performed unconditionally.
# Programs with software-generated interrupts must check for hardware sources
# to conditionally adjust the ea register (no adjustment for s/w interrupts).
#-----------------------------------------------------------------------------

isr:
	addi	ea, ea, -4	# this is _required_ for hardware interrupts

				# body of interrupt service routine
	???????			# (save/restore registers that are modified,
				#  except ea which must be modified as above)

	eret			# interrupt service routines end _differently_
				# than normal subroutines; the eret goes back
				# to wherever execution was in the main program
				# (possibly in a subroutine) at the time the
				# interrupt request triggered invocation of
				# the service routine

#-----------------------------------------------------------------------------
# Definitions for program data, incl. anything shared between main/isr code
#-----------------------------------------------------------------------------

	.org	0x1000		# start should be fine for most small programs
				
?????:	???	???		# define/reserve storage for program data

	.end
