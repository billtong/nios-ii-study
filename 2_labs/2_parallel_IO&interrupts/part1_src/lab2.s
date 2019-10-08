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
  stw r3, 0(sp)
  stw r4, 4(sp)
  /*write to pushbutton port interrupt*/
  movia r4, PUSH_BOTTONS_BASE
  movi r3, 0b0110
  stwio r3, BUTTONS_MASK_REGISTER(r4)
  movi r3, 0b011
  /*enable Nios II processor interrupts*/
  rdctl r3, ienable
  ori r3, r3, 0b10 # 0b10: button interrupts
  wrctl ienable, r3
  movi r3, 1
  rdctl r3, status
  ori r3, r3, 0b1
  wrctl status, r3
  ldw r3, 0(sp)
  ldw r4, 0(sp)
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
  movia r3, LEDS_DATA_REGISTER
  ldwio r4, 0(r3)
  xori r4, r4, LED_ZERO
  stwio r4, 0(r3)
isr_end_if:
  movia r3, PUSH_BOTTONS_BASE
  addi r4, r0, -1
  stwio r4, BUTTONS_EDGE_REGISTER(r3)
  ldw r3, 0(sp)
  ldw r4, 4(sp)
  ldw ra, 8(sp)
  addi sp, sp, 12
  eret
	
  .org	0x1000
  .end
