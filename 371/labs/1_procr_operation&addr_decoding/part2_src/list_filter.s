  # Implement a Nios II asm.-lang. program 
  # that copies only the non-negative word-sized items from LIST1 in memory to LIST2.
  # Use another location N that contains the number of items in LIST1.
  # For testing, use the following list of values: 3, -5, -7, 9, 11, -13, 15

  .equ  LAST_RAM_WORD, 0x007FFFFC
  .equ  JTAG_UART_BASE, 0x10001000
  .equ  TEXT_RAM_LOC, 0x00000000
  .equ  DATA_RAM_LOC, 0x00001000

  .section		CODE
  .text
  .global _start
  .org TEXT_RAM_LOC
  
_start:
    movia sp, LAST_RAM_WORD
    movia r3, LIST1
    movia r4, LIST2
loop:
    ldw r2, 0(r3)
    beq r2, r0, _end
    blt r2, r0, else
if_non_neg:
    stw r2, 0(r4)
    addi r4, r4, 4
else:
    addi r3, r3, 4
    br loop
_end:
    br _end

  .section		VARIABLES
  .data
  .org  DATA_RAM_LOC
LIST1:	.word 3, -5, -7, 9, 11, -13, 15
END_OF_LIST1:   .word 0
LIST2:	.skip 10
  .end