##
# Questions
# develop a complete Nios II assembly-language program that uses the JTAG UART of the DE0 Basic Computer
# The program must first print "Type a lowercase character a-z:", and then wait for the user to type a character
# User a loop in the main program to ensure that only a lowercase character is accepted, others ignored
# When a valid lowercase character is accepted, that character should be printed.
# The main program must then cunt the number of occurrences of that lowercase character in a predefined string in the memory,
# and simply write that count value as a word to a location in the memory
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
  .equ	CHAR_LOWERCASE_A, 'a'
  .equ  CHAR_LOWERCASE_Z, 'z'
  .equ  NEW_LINE, '\n'

  .section		CODE
  .text
  .global _start
  .org TEXT_RAM_LOC

_start:
  movia sp, LAST_RAM_WORD
  movia r2, OPEN_MSG
  call PrintString
get_lowercase_letter_loop:
  call GetChar
  movi r3, CHAR_LOWERCASE_A
  blt r2, r3, loop
  movi r3, CHAR_LOWERCASE_Z
  bgt r2, r3, loop
count_lowercase_letter:
  movia r3, TEST_STR
  ldw r4, COUNT(r0)
loop:
  ldb r5, 0(r3)
  beq r5, r0, end_loop
  addi r3, r3, 1
  bne r5, r2, loop
  addi r4, r4, 1
  br loop
end_loop:
  stw r4, COUNT(r0)
_end:
  br _end

PrintChar:
  subi sp, sp, 8
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
  subi sp, sp, 8
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

PrintString:
  subi sp, sp, 12
  stw r2, 8(sp)
  stw r3, 4(sp)
  stw ra, 0(sp)
  mov r3, r2
ps_loop:
  ldb r2, 0(r3)
  beq r2, r0, end_ps_loop
  call PrintChar
  addi r3, r3, 1
  br ps_loop
end_ps_loop:
  movi r2, NEW_LINE
  call PrintChar
  ldw r2, 8(sp)
  ldw r3, 4(sp)
  ldw ra, 0(sp)
  addi sp, sp, 12
  ret

  .section		VARIABLES
  .data
  .org  DATA_RAM_LOC
COUNT: .word 0
OPEN_MSG: .asciz  "Type a lowercase character a-z: "
TEST_STR: .asciz  "Hello, I am the test string, count me please!"
  .end