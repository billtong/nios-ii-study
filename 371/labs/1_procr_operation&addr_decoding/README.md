# part one
Implement an assembly-language program using only Nios II ldw, stw, addi, and br instruction
and only registers r1 and r0 for the following pseudocode, where variable V5 is assigned
(using .equ) to location 0x1000 and variable V16 is assigned to location 0x1004.
```
  V5 = 5
  V16 = 16
  loop
    V5 = V5 + 5
    V16 = V16 + 6
  end loop
```
In the simualtion results, find the point when 32(0x20) is written to location 0x1004 and draw the 
five cycles for the instruction that performs the write in the diagram below.
# part two
Implement a simple but complete Nios II asm.-lang. program that copies only the non-negtive word-size
items from LIST1 in memory to LIST2. Use another location N that contains the number of items in LIST1.
For testing, use the following list of values: 3, -5, -7, 9, 11, -13, 15