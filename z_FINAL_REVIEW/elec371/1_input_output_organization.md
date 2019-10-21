# input/output organization
## Multiple Discrete Chips vs A Single FPGA Chip
- For data connections to a processor, briefly describe difference(s) between all-in-a-single-chip implement and circuit-board-with-multiple-chips implement
  - data lines from processor are one-to-many, so only wiring from processor output to destination inputs; data line to processor are many to one which means ORing outputs from sources to input of processor, but each source also requires 2-to-1 MUX internally for zeros.
  - Bidirectional data pins on all relevant chips are connected to common set of data lines on circuit board. Those data pins all must have tristate logic for the output driver.
- Explain similarities/differences in address connections for the system in question 7 between implementations in a single FPGA or on a circuit board.
  - similarity: In both cases, only one source of address information - the processor. Therefore, the connections are simple -- one-to-many with wiring only.
  - difference: Inside an FPGA, internal routing between logic blocks must carry address bits. On a circuit borad, wire traces between chips must carry address bits.
- For a sistem consists of the five-step processor, ROM, RAM, and 3 I/O devices. A 16-bit address space is used. Describe the implementation of the data lines if the hardware uses (a) multiple discrete chips or (b) a single FPGA chip.
  1. a tri-state driver on pins of up to 5 chips/devices (I/O devices could be output only), connected to common bus line
  2. up to 5 data outputs combined with OR logic (and 2-to-1 muxes insides each devices)
## address decoding logic design
- The DE0 output port word data address for the green LEDs is 0x1000 0010. Assume that the DE0 system hardware includes some central decoding logic that asserts a signal `IO_ports` for any address with a prefix 0x10000_ _ _. If only word-sized accesses are made to the LED/SWITCH/button ports, write a Boolean expression for logic within the LED port for its alias-free activation.
```
LED_port_active = IO_ports*(~A11)*(~A10)*(~A9)*(~A8)*(~A7)*(~A6)*(~A5)*(A4)*(~A3)*(~A2)
0X10000 COVERS A31 downto A12; 
0x010 = 0b0000 0001 0000
word-sized accesses allow A1, A0 to be dropped.
```
- The DE0 input port word data address for the switches is 0x1000 0040. If the switch input port above does not rely on any central address decoding, complete the Booleanlogic expression for alias-free activation.
- A system consists of a processor, ROM, RAM, and two input/output devices. A 16-bit address space is used. The ROM of 32 kbytes begins at address 0. The RAM of 16 kbytess is at the end of the address space. Design address decoding logic and fill in the table.

  Device | Start | End | Size
  --- | --- | --- | ---
  *ROM* | 0x0000 | 0x7FFF | 32kbytes
  *I/O 1* | 0x8000 | 0x9FFF | 8kbytes
  *I/O 2* | 0xA000 | 0xBFFF | 8kbytes
  *RAM* | 0xC000 | 0xFFFF | 16kbytes
  - 3-to-8 decoder using A15, A14, A13 for 8 kbyte regions; need ORing for ROM and RAM; each I/O device uses a dedicated decoder output.
- A system with a 16-bit address space has a processor, ROM, RAM, and two I/O devices. ROM is half of the space from addr. 0. RAM is one-quarter of the space, positioned right after the ROM. Each I/O device uses 2 kbutes of space. Derive & write alias-free decoding logic expression.
## Others
- What circuitry is required in a system with multiple masters or initiators?
  - bus arbitration logic