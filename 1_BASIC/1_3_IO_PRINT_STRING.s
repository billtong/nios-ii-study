  .equ  LAST_RAM_WORD, 0x007FFFFC
  .equ  JTAG_UART_BASE, 0x10001000
  .equ  DATA_OFFSET, 0
  .equ  STATUS_OFFSET, 4
  .equ  WSPACE_MASK, 0xFFFF
  .equ  TEXT_RAM_LOC, 0x00000000
  .equ  DATA_RAM_LOC, 0x00001000

  .section		CODE
  .text
  .global _start
  .org		TEXT_RAM_LOC

_start:
  movia sp, LAST_RAM_WORD
  movia r3, MSG
  call PrintString

_end:
  br  _end

PrintString:
  subi  sp, sp, 12
  stw ra, 8(sp)
  stw r3, 4(sp)
  stw r2, 0(sp)

ps_loop:
  ldb r2, DATA_OFFSET(r3)
  beq r2, r0, end_ps_loop
  call  PrintChar
  addi  r3, r3, 1
  br  ps_loop

end_ps_loop:
  movi  r2, '\n'
  call PrintChar
  ldw ra, 8(sp)
  ldw r3, 4(sp)
  ldw r2, 0(sp)
  addi  sp, sp, 12
  ret

PrintChar:
  subi  sp, sp, 8
  stw r4, 4(sp)
  stw r3, 0(sp)
  movia r3, JTAG_UART_BASE

pc_loop:
  ldwio r4, STATUS_OFFSET(r3)
  andhi r4, r4, WSPACE_MASK
  beq r4, r0, pc_loop

end_pc_loop:
  stwio r2, DATA_OFFSET(r3)
  ldw r4, 4(sp)
  ldw r3, 0(sp)
  addi  sp, sp, 8
  ret

  .section		VARIABLES
  .data
  .org		DATA_RAM_LOC
MSG:  .asciz  "Hello World!"
  .end
  
  
  
  
  