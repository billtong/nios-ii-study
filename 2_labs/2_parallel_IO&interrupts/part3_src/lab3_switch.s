# 通过四个switch分别控制 7-segment LEDs
# Author: Bill Tong

  .equ  PUSH_BOTTONS_BASE, 0x10000050
  .equ	BUTTONS_MASK_REGISTER, 0x8
  .equ	BUTTONS_EDGE_REGISTER, 0xc
  .equ	LEDS_DATA_REGISTER, 0x10000010

  .equ  TIMMER_BASE, 0x10002000
  .equ  TIMMER_CONTROL_REGISTER, 0x4
  .equ  TIMMER_LOW_HALF_START_VALUE, 0x8
  .equ  TIMMER_HIGH_HALF_START_VALUE, 0xc
  
  .equ  HEX_BASE, 0x10000020
  .equ  SWITCH_VALUE, 0x10000040

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
  /*set the interval timer period fro HEX displays*/
  movia r8, TIMMER_BASE
  movia r7, 0x017d7840 # (1/50MHZ) * (0x17d7840) = 1.5sec
  sthio r7, TIMMER_LOW_HALF_START_VALUE(r8)
  srli r7, r7, 16
  sthio r7, TIMMER_HIGH_HALF_START_VALUE(r8)
  /*start interval timer, enable its interrupts*/
  movi r7, 0b0111 /*START=1, CONT=1, ITO=1*/
  sthio r7, TIMMER_CONTROL_REGISTER(r8)
  /*write to pushbutton port interrupt*/
  movia r8, PUSH_BOTTONS_BASE
  movi r7, 0b0110
  stwio r7, BUTTONS_MASK_REGISTER(r8)
  /*enable Nios II processor interrupts*/
  movi r7, 0b011
  wrctl ienable, r7
  movi r7, 1
  wrctl status, r7
  ldw r7, 0(sp)
  ldw r8, 0(sp)
  addi sp, sp, 8
  ret

isr:
  subi sp, sp, 16
  stw r3, 0(sp)
  stw r4, 4(sp)
  stw r5, 8(sp)
  stw ra, 12(sp)
  addi	ea, ea, -4
isr_check_timmer:
  rdctl r3, ipending
  andi r3, r3, 0b1
  beq r3, r0, isr_check_bshbtn
isr_check_timmer_then:
  movia r3, TIMMER_BASE
  sthio r0, 0(r3)
  mov r5, r0
check_led_zero:
  movia r3, SWITCH_VALUE
  ldbio r4, 0(r3)
  andi r4, r4, 0b0001
  beq r0, r4, check_led_one
  ori r5, r5, 0xFF
check_led_one:
  movia r3, SWITCH_VALUE
  ldbio r4, 0(r3)
  andi r4, r4, 0b0010
  beq r0, r4, check_led_two
  ori r5, r5, 0xFF00
check_led_two:
  movia r3, SWITCH_VALUE
  ldbio r4, 0(r3)
  andi r4, r4, 0b0100
  beq r0, r4, check_led_three
  orhi r5, r5, 0xFF
check_led_three:
  movia r3, SWITCH_VALUE
  ldbio r4, 0(r3)
  andi r4, r4, 0b1000
  beq r0, r4, check_else
  orhi r5, r5, 0xFF00
end_check_led:
  movia r3, HEX_BASE
  ldwio r4, 0(r3)
  xor r4, r4, r5
  stwio r4, 0(r3)
  br isr_check_bshbtn
check_else:
  movia r3, HEX_BASE
  ldwio r4, 0(r3)
  xor r4, r4, r5
  stwio r4, 0(r3)
isr_check_bshbtn:
  movia r3, PUSH_BOTTONS_BASE
  ldwio r4, BUTTONS_EDGE_REGISTER(r3)
  andi r4, r4, 0b0010
  beq r4, r0, isr_end_if
isr_check_bshbtn_then:
  movi r4, 2
  stwio r4, BUTTONS_EDGE_REGISTER(r3)
  movia r3, LEDS_DATA_REGISTER
  ldwio r4, 0(r3)
  xori r4, r4, LED_ZERO
  stwio r4, 0(r3)
isr_end_if:
  ldw r3, 0(sp)
  ldw r4, 4(sp)
  ldw r5, 8(sp)
  ldw ra, 12(sp)
  addi sp, sp, 16
  eret

  .org	0x1000
  .end
