  .equ  LAST_RAM_WORD, 0x007FFFFC
  .equ  JTAG_UART_BASE, 0x10001000
  .equ  RVALID_MASK, 0x8000
  .equ  DATA_OFFSET, 0
  .equ  DATA_MASK, 0xFF
  .equ  TEXT_RAM_LOC, 0x00000000
  .equ  DATA_RAM_LOC, 0x00001000

  .section		CODE
  .text
  .global _start
  .org  TEXT_RAM_LOC

_start:
  movia sp, LAST_RAM_WORD
  call  GetChar
  stb r2, CHAR_BUFFER(r0)

_end:
  br  _end

GetChar:  # 键盘输入字符通过r2返回;
  subi  sp, sp, 8
  stw   r3, 4(sp) # r3用来存JTAG_UART_BASE;
  stw   r4, 0(sp) # r4用来存放data&status value
  movia r3, JTAG_UART_BASE

gc_loop:
  ldwio   r2, DATA_OFFSET(r3)
  andi    r4, r2, RVALID_MASK
  beq     r4, r0, gc_loop

end_gc_loop:
  andi    r2, r2, DATA_MASK
  ldw   r3, 4(sp)
  ldw   r4, 0(sp)
  addi  sp, sp, 8
  ret

  .section		VARIABLES
  .data
  .org  DATA_RAM_LOC
CHAR_BUFFER: .skip 1
  .end
