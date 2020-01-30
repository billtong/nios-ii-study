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
	# movi r3, 0
mainloop:
  # addi r3, r3, 1
	br mainloop

Init:
  subi sp, sp, 8
  stw r3, 0(sp)
  stw r4, 4(sp)
  /*set the interval timer period fro HEX displays*/
  movia r4, TIMMER_BASE
  movia r3, 0x017d7840 # (1/50MHZ) * (0x17d7840) = 1.5sec
  sthio r3, TIMMER_LOW_HALF_START_VALUE(r4)
  srli r3, r3, 16
  sthio r3, TIMMER_HIGH_HALF_START_VALUE(r4)
  /*start interval timer, enable its interrupts*/
  movi r3, 0b0111 /*START=1, CONT=1, ITO=1*/
  sthio r3, TIMMER_CONTROL_REGISTER(r4)
  /*write to pushbutton port interrupt*/
  movia r4, PUSH_BOTTONS_BASE
  movi r3, 0b0110
  stwio r3, BUTTONS_MASK_REGISTER(r4)
  /*enable Nios II processor interrupts*/
  rdctl r3, ienable
  ori r3, r3, 0b011 # 0b1: timer interrupts, 0b10 button interrupts
  wrctl ienable, r3
  rdctl r3, status
  ori r3, r3, 0b1
  wrctl status, r3
  ldw r3, 0(sp)
  ldw r4, 0(sp)
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
  call HandleTimer
isr_check_bshbtn:
  movia r3, PUSH_BOTTONS_BASE
  ldwio r4, BUTTONS_EDGE_REGISTER(r3)
  andi r4, r4, 0b0010
  beq r4, r0, isr_end_if
isr_check_bshbtn_then:
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
  ldw r5, 8(sp)
  ldw ra, 12(sp)
  addi sp, sp, 16
  eret

/* if 判断全部的switch开关
HandleTimer:
  subi sp, sp, 16
  stw r3, 0(sp)
  stw r4, 4(sp)
  stw r5, 8(sp)
  stw ra, 12(sp)
  movia r3, SWITCH_VALUE
  mov r5, r0
check_led_zero:
  ldbio r4, 0(r3)
  andi r4, r4, 0b0001
  beq r0, r4, check_led_one
  ori r5, r5, 0xFF
check_led_one:
  ldbio r4, 0(r3)
  andi r4, r4, 0b0010
  beq r0, r4, check_led_two
  ori r5, r5, 0xFF00
check_led_two:
  ldbio r4, 0(r3)
  andi r4, r4, 0b0100
  beq r0, r4, check_led_three
  orhi r5, r5, 0xFF
check_led_three:
  ldbio r4, 0(r3)
  andi r4, r4, 0b1000
  beq r0, r4, end_check_led
  orhi r5, r5, 0xFF00
end_check_led:
  movia r3, HEX_BASE
  ldwio r4, 0(r3)
  xor r4, r4, r5
  stwio r4, 0(r3)
  ldw r3, 0(sp)
  ldw r4, 4(sp)
  ldw r5, 8(sp)
  ldw ra, 12(sp)
  addi sp, sp, 16
  ret
*/

# 循环遍历全部的switch开关
HandleTimer:
  subi sp, sp, 24
  stw r3, 0(sp) 	# save switch_value
  stw r4, 4(sp) 	# save counter
  stw r5, 8(sp) 	# temp
  stw r6, 12(sp)	# temp
  stw r7, 16(sp)	# temp 
  stw ra, 20(sp)	# save calling subroutine addr
  movia r5, SWITCH_VALUE
  ldbio r3, 0(r5) # load data from r3
  mov r4, r0      # set counter to 0
ht_loop:
  movi r5, 3
  bgt r4, r5, end_ht_loop
  srl r5, r3, r4
  andi r5, r5, 0b1
  beq r5, r0, ht_else
ht_if:
  movia r5, HEX_BASE
  ldwio r6, 0(r5)
  movi r5, 0xFF
  muli r7, r4, 8
  sll r5, r5, r7
  xor r6, r6, r5
  movia r5, HEX_BASE
  stwio r6, 0(r5)
  br ht_end_if
ht_else:
  movi r5, 0xFF
  muli r6, r4, 8
  sll r5, r5, r6
  addi r6, r0, -1
  xor r5, r5, r6
  movia r6, HEX_BASE
  ldwio r7, 0(r6)
  and r7, r7, r5
  stwio r7, 0(r6)
ht_end_if:
  addi r4, r4, 1
  br ht_loop
end_ht_loop:
  ldw r3, 0(sp)
  ldw r4, 4(sp)
  ldw r5, 8(sp)
  ldw r6, 12(sp)
  ldw r7, 16(sp)
  ldw ra, 20(sp)
  addi sp, sp, 24
  ret

  .org	0x1000

  .end
