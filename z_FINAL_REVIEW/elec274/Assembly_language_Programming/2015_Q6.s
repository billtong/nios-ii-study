##
# Questions
# develop a complete Nios II assembly-language program that uses the JTAG UART of the DE0 Basic Computer
# The program must accept only hexadecimal digit characters 0 to 9, a to f (not uppercase), 
# echoling valid digit as they recieved, and pacing their binary values in consecutive bytes of a list in the memory
# This process must continue unitl a 0 digit is entered. The 0 dight is echoed, but not placed in memory (no 0 bytes in the list)
# This program must also compute the sum of the digits entered and write the final sum as a word to location in memory
# Answer By Bill Tong
##

  .equ  LAST_RAM_WORD, 0x007FFFFC
  .equ  JTAG_UART_BASE, 0x10001000
  .equ  DATA_OFFSET, 0
  .equ  STATUS_OFFSET, 4
  .equ  WSPACE_MASK, 0xFFFF
  .equ  RVALID_MASK, 0x8000
  .equ  DATA_MASK, 0xFF
  .equ  TEXT_RAM_LOC, 0x00000000
  .equ  DATA_RAM_LOC, 0x00001000
  .equ  CHAR_ZERO, '0'
  .equ  CHAR_NINE, '9'
  .equ	CHAR_LOWERCASE_A, 'a'
  .equ  CHAR_LOWERCASE_F, 'f'
  .equ  NEW_LINE, '\n'

  .section		CODE
  .text
  .global _start
  .org TEXT_RAM_LOC

_start:
  movia sp, LAST_RAM_WORD
  ldw r3, SUM(r0)
  movia r4, LIST
loop:
  call GetHexDigit
  beq r2, r0, end_loop
  stb r2, 0(r4)
  addi r3, r3, 1 
  addi r4, r4, 1
  br loop
end_loop:
  stw r3, SUM(r0)
_end:
  br _end

PrintChar:
  subi  sp, sp, 8
  stw r3, 4(sp)
  stw r4, 0(sp)
  movia r3, JTAG_UART_BASE
pc_loop:
  ldwio r4, STATUS_OFFSET(r3)
  andhi r4, r4, WSPACE_MASK
  beq r4, r0, pc_loop
end_pc_loop:
  stwio r2, DATA_OFFSET(r3)
  ldw r3, 4(sp)
  ldw r4, 0(sp)
  addi sp, sp, 8
  ret

GetChar:
  subi  sp, sp, 8
  stw r3, 4(sp)
  stw r4, 0(sp)
  movia r3, JTAG_UART_BASE
gc_loop:
  ldwio r2, DATA_OFFSET(r3)
  andi r4, r2, RVALID_MASK
  beq r4, r0, gc_loop
end_gc_loop:
  andi r2, r2, DATA_MASK
  ldw r3, 4(sp)
  ldw r4, 0(sp)
  addi sp, sp, 8
  ret

GetHexDigit:
  subi sp, sp, 8
  stw r3, 4(sp)
  stw ra, 0(sp)
ghd_loop:
  call GetChar
check_if_number:
  movi r3, CHAR_ZERO
  blt r2, r3, check_if_letter
  movi r3, CHAR_NINE
  bgt r2, r3, check_if_letter
  br end_check_if_number
check_if_letter:
  movi r3, CHAR_LOWERCASE_A
  blt r2, r3, ghd_loop
  movi r3, CHAR_LOWERCASE_F
  bgt r2, r3, ghd_loop
  br end_check_if_letter
end_check_if_number:
  call PrintChar
  subi r2, r2, CHAR_ZERO
  br end_ghd_loop
end_check_if_letter:
  call PrintChar
  subi r2, r2, CHAR_LOWERCASE_A
  addi r2, r2, 10
  br end_ghd_loop
end_ghd_loop:
  ldw r3, 4(sp)
  ldw ra, 0(sp)
  addi sp, sp, 8
  ret

  .section		VARIABLES
  .data
  .org DATA_RAM_LOC
SUM: .word 0
LIST: .skip 256
  .end
  