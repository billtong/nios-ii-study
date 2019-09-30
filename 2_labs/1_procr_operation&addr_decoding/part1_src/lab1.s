# Implement an assembly-language program using only Nios II "ldw", "stw", "addi", and "br"
# instructions and only registers r1 and r0 for the following pseudocode, 
# where variable V5 is assigned (usign .equ) to location 0x1000
# and variable V16 is assigned to location 0x1004
# -----------------
# V5 = 5
# V16 = 16
# loop
#	V5 = V5 + 5
#	V16 = V16 + 6
# end loop
# -----------------

.set noat
.equ V5, 0x1000
.equ V16, 0X1004
.text
.global _start
_start:	 
	addi	r1, r0, 5
 	stw	r1, V5(r0)
	addi	r1, r0, 16
    stw	r1, V16(r0)
loop:
	ldw  r1, V5(r0)			/*read data from RAM*/
	addi r1, r1 ,5			/* increment reg value */
	stw  r1, V5(r0)			/* put new value in RAM */
	ldw  r1, V16(r0)
	addi r1, r1 ,16			/* increment reg value */
	stw  r1, V16(r0)		/* put new value in RAM */
	br		loop			/* repeat */
_end:
    br _end
	