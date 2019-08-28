  .equ  LAST_RAM_WORD, 0x007FFFFC
  .equ  JTAG_UART_BASE, 0x10001000
  .equ  RVALID_MASK, 0x8000
  .equ  DATA_OFFSET, 0
  .equ  DATA_MASK, 0xFF
  .equ  TEXT_RAM_LOC, 0x00000000
  .equ  DATA_RAM_LOC, 0x00001000
  
  .section		CODE
  .text
  .org		TEXT_RAM_LOC

  .section		VARIABLES
  .data
  .org		DATA_RAM_LOC

  .end
  
  
  
  
  