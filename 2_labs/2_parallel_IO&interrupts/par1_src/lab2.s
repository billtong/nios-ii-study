# the hardware source is pressing then releasing pushbutton 1 on the circuit board
# used in laboratory activity. A parallel input/output port associated with the
# pushbuttons must be configured for the assertion of a hardware signal to the
# processor when this pushbutton event occurs
# main()::
#   Init()
#   local_var = 0
#   loop
#     local_var = local_var + 1
#   end loop
# Init()::
#   enable interrupts on pshbtn 0
#   enable procr to recog. pshbtn interrput
#   enable procr to response to all interrupts
# isr()::
#   perform processor-specific reg. update
#   read special reg. with pending interrupts      
#   if (pshbtn interrupt is pending) then
#     clear pshbtn interrupt source
#     toggle LED0 using XOR operation
#   end if
#   return from interrupt

# Author: Bill Tong

  .equ  PUSH_BOTTONS_BASE, 0x10000050
  .equ	BUTTONS_MASK_REGISTER, 0x8
  .equ	BUTTONS_EDGE_REGISTER, 0xc
  .equ	LEDS_DATA_REGISTER, 0x10000010
  .equ	LAST_RAM_WORD, 0x007FFFC
  .equ	LED_ZERO, 0b1
  .text
  .global	_start
  .org	0x0000

_start:
	br	main
  .org	0x0020
	br	isr
main:
	movia sp, LAST_RAM_WORD
	call Init
	movi r3, 0
mainloop:
  addi r3, r3, 1
	br mainloop

Init:
  subi sp, sp, 8
  stw r7, 0(sp)
  stw r8, 4(sp)
  movia r8, PUSH_BOTTONS_BASE
  movi r7, 0b0110
  stwio r7, BUTTONS_MASK_REGISTER(r8)
  movi r7, 0b011
  wrctl ienable, r7
  movi r7, 1
  wrctl status, r7
  ldw r7, 0(sp)
  ldw r8, 0(sp)
  addi sp, sp, 8
  ret

isr:
  subi sp, sp, 12
  stw r3, 0(sp)
  stw r4, 4(sp)
  stw ra, 8(sp)
  addi	ea, ea, -4
isr_if:
  movia r3, PUSH_BOTTONS_BASE
  ldwio r4, BUTTONS_EDGE_REGISTER(r3)
  andi r4, r4, 0b0010
  beq r4, r0, isr_end_if
isr_then:
  movi r4, 2
  stwio r4, BUTTONS_EDGE_REGISTER(r3)
  movia r3, LEDS_DATA_REGISTER
  ldwio r4, 0(r3)
  xori r4, r4, LED_ZERO
  stwio r4, 0(r3)
isr_end_if:
  ldw r3, 0(sp)
  ldw r4, 4(sp)
  ldw ra, 8(sp)
  addi sp, sp, 12
  eret
	
  .org	0x1000
KEY_PRESSED:	.word	0
  .end
