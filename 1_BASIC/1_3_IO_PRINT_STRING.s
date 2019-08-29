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
  call  PrintString

_end:
  br  _end

PrintString:  # r3是传入的打印字符串;
  subi  sp, sp, 8
  stw   ra, 4(sp) # ra用来存放Instruction address(嵌套subroutine需要返回原来位置);
  stw   r2, 0(sp) # r2用来存放字符;
ps_loop:
  ldb   r2, DATA_OFFSET(r3)
  beq   r2, r0, end_ps_loop
  call  PrintChar
  addi  r3, r3, 1
  br    ps_loop
end_ps_loop:
  movi  r2, '\n'
  call  PrintChar
  ldw   ra, 4(sp)
  ldw   r2, 0(sp)
  addi  sp, sp, 8
  ret

PrintChar:  # r2的值是传入的打印字符;
  subi  sp, sp, 8
  stw   r4, 4(sp) # r4用来存Status Value;
  stw   r3, 0(sp) # r3用来存JTAG_UART_BASE;
  movia r3, JTAG_UART_BASE
pc_loop:
  ldwio r4, STATUS_OFFSET(r3)
  andhi r4, r4, WSPACE_MASK
  beq   r4, r0, pc_loop
end_pc_loop:
  stwio r2, DATA_OFFSET(r3)
  ldw   r4, 4(sp)
  ldw   r3, 0(sp)
  addi  sp, sp, 8
  ret

  .section		VARIABLES
  .data
  .org		DATA_RAM_LOC
MSG:  .asciz  "Hello World!\0"
  .end
  