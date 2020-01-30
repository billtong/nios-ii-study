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
  .equ  NEW_LINE, '\n'
  .equ  TERMINAL_SIGN, '>'
  .equ  END_OF_STRING, '\0'

  .section		CODE
  .text
  .global _start
  .org		TEXT_RAM_LOC

_start:
  movia sp, LAST_RAM_WORD
  movi  r2, TERMINAL_SIGN
  call  PrintChar
  call  GetString
  movi  r2, NEW_LINE 
  call  PrintChar
  call  PrintString
_end:
  br  _end

GetString:
  subi  sp, sp, 16
  stw   r2, 12(sp)  # r2存放键盘输入的字符
  stw   r3, 8(sp)   # r3存放STRING_BUFFER地址
  stw   r4, 4(sp)   # r4存放'\0'结束符号
  stw   ra, 0(sp)   # 嵌套subroutine
  movia r3, STRING_BUFFER
gs_loop:
  call  GetChar
  movia r4, NEW_LINE
  beq   r2, r4, end_gs_loop
  stb   r2, DATA_OFFSET(r3)
  addi  r3, r3, 1
  br    gs_loop
end_gs_loop:
  movi  r4, END_OF_STRING
  stb 	r4, DATA_OFFSET(r3)
  ldw   r2, 12(sp)
  ldw   r3, 8(sp)
  ldw   r4, 4(sp)
  ldw   ra, 0(sp)
  addi  sp, sp, 16
  ret

PrintString:
  subi  sp, sp, 16
  stw   r2, 12(sp) # r2用来存放字符;
  stw   r3, 8(sp) # r3是传入的打印字符串;
  stw   r4, 4(sp)
  stw   ra, 0(sp) # ra用来存放Instruction address(嵌套subroutine需要返回原来位置);
  movia r3, STRING_BUFFER
ps_loop:
  ldb   r2, DATA_OFFSET(r3)
  movi  r4, END_OF_STRING
  beq   r2, r4, end_ps_loop
  call  PrintChar
  addi  r3, r3, 1
  br    ps_loop
end_ps_loop:
  ldw   r2, 12(sp)
  ldw   r3, 8(sp)
  ldw   r4, 4(sp)
  ldw   ra, 0(sp)
  addi  sp, sp, 16
  ret

GetChar:  # 键盘输入字符通过r2返回;
  subi  sp, sp, 8
  stw   r3, 4(sp) # r3用来存JTAG_UART_BASE;
  stw   r4, 0(sp) # r4用来存放data&status value
  movia r3, JTAG_UART_BASE
gc_loop:
  ldwio r2, DATA_OFFSET(r3)
  andi  r4, r2, RVALID_MASK
  beq   r4, r0, gc_loop
end_gc_loop:
  andi  r2, r2, DATA_MASK
  ldw   r3, 4(sp)
  ldw   r4, 0(sp)
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
STRING_BUFFER:  .skip 10
  .end
  
  
  
  
  