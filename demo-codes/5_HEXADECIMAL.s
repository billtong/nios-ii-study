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
  .equ  END_OF_NUMBER, '\0'
  .equ  TERMINAL_SIGN, '>'

  .section		CODE
  .text
  .global _start
  .org		TEXT_RAM_LOC

_start:
  movia sp, LAST_RAM_WORD
  movi  r2, TERMINAL_SIGN
  call  PrintChar
  call  GetHexdecimalNumber
  movi  r2, NEW_LINE 
  call  PrintChar
  call  PrintHexdecimalNumber

_end:
  br  _end

GetHexdecimalNumber:
  subi  sp, sp, 16
  stw   r2, 12(sp)
  stw   r3, 8(sp)
  stw   r4, 4(sp)
  stw   ra, 0(sp)
  movia r3, NUMBER_BUFFER
ghn_loop:
  call  GetHexDecimalDight
  movi  r4, NEW_LINE
  beq   r2, r4, end_ghn_loop
  stb   r2, 0(r3)
  addi  r3, r3, 1
  br    ghn_loop
end_ghn_loop:
  movi  r4, END_OF_NUMBER
  stb   r4, DATA_OFFSET(r3)
  ldw   r2, 12(sp)
  ldw   r3, 8(sp)
  ldw   r4, 4(sp)
  ldw   ra, 0(sp)
  addi  sp, sp, 16
  ret

GetHexDecimalDight:
  subi  sp, sp, 8
  stw   r3, 4(sp)
  stw   ra, 0(sp)
ghd_loop:
  call  GetChar
  movi  r3, NEW_LINE
  beq   r2, r3, end_ghd_loop
check_number_loop:
  movi  r3, CHAR_ZERO
  blt   r2, r3, check_letter_loop
  movi  r3, CHAR_NINE
  bgt   r2, r3, check_letter_loop
  br    end_check_number_loop
check_letter_loop:
  movi  r3, CHAR_LOWERCASE_A
  blt   r2, r3, ghd_loop 
  movi  r3, CHAR_LOWERCASE_F
  bgt   r2, r3, ghd_loop
  br    end_check_letter_loop
end_check_number_loop:
  subi  r2, r2, CHAR_ZERO
  br    end_ghd_loop
end_check_letter_loop:
  subi  r2, r2, CHAR_LOWERCASE_A
  addi  r2, r2, 10
end_ghd_loop:
  ldw   r3, 4(sp)
  ldw   ra, 0(sp)
  addi  sp, sp, 8
  ret

PrintHexdecimalNumber:
  subi  sp, sp, 16
  stw   r2, 12(sp)
  stw   r3, 8(sp)
  stw   r4, 4(sp)
  stw   ra, 0(sp)
  movia r3, NUMBER_BUFFER
phn_loop:
  ldb   r2, 0(r3)
  movi  r4, END_OF_NUMBER
  beq   r2, r4, end_phn_loop
  call  PrintHexDecimalDight
  addi  r3, r3, 1
  br    phn_loop
end_phn_loop:
  movi  r2, NEW_LINE
  call  PrintChar
  ldw   r2, 12(sp)
  ldw   r3, 8(sp)
  ldw   r4, 4(sp)
  ldw   ra, 0(sp)
  addi  sp, sp, 16
  ret

PrintHexDecimalDight:
	subi	sp, sp, 12
  stw 	ra, 8(sp)			
  stw		r2, 4(sp)			
  stw		r3, 0(sp)
  blt		r2,	r0,	end_phd		
  movi	r3, 0xa
  blt		r2, r3, phd_handle_number
  movi	r3, 0xf		
  ble		r2, r3, phd_handle_alpha
  br		end_phd					
phd_handle_number:
  addi 	r2,	r2,	CHAR_ZERO	
  br		end_phd
phd_handle_alpha:
	subi	r2, r2, 10
  addi  r2, r2, CHAR_LOWERCASE_A 	
end_phd:
  call 	PrintChar			
  ldw		r3, 0(sp)
  ldw 	r2, 4(sp)
  ldw 	ra, 8(sp)			
	addi	sp, sp, 12
  ret  

PrintChar:  # r2的值是传入的打印值;
  subi  sp, sp, 8
  stw   r3, 4(sp) # r3用来存JTAG_UART_BASE;
  stw   r4, 0(sp) # r4用来存Status Value;
  movia r3, JTAG_UART_BASE
pc_loop:
  ldwio r4, STATUS_OFFSET(r3)
  andhi r4, r4, WSPACE_MASK
  beq   r4, r0, pc_loop
end_pc_loop:
  stwio r2, DATA_OFFSET(r3)
  ldw   r3, 4(sp)
  ldw   r4, 0(sp)
  addi  sp, sp, 8
  ret

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
  andi  r2, r2, DATA_MASK
  ldw   r3, 4(sp)
  ldw   r4, 0(sp)
  addi  sp, sp, 8
  ret

  .section		VARIABLES
  .data
  .org		DATA_RAM_LOC
NUMBER_BUFFER: .skip  100
  .end