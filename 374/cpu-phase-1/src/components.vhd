library ieee;
use ieee.std_logic_1164.all;

package my_components is
	TYPE State IS (reset_state0, reset_state1, fetch0, fetch1, fetch2, fetch3, add3, add4, add5, sub3, sub4, sub5, mul3, mul4, mul5, mul6, and3, and4, and5, or3, or4, or5, div3, div4, div5, div6, andi3, andi4, andi5, ori3, ori4, ori5, branch3, branch4, jr3, jal3, jal4, in3, mfhi3, mflo3, shr3, shr4, shr5, shl3, shl4, shl5, ror3, ror4, ror5, rol3, rol4, rol5, neg3, neg4, not3, not4, ld3, ld4, ld5, ld6, ld7, ldi3, ldi4, ldi5, ldr2, ldr3, ldr4, ldr5, ldr6, addi3, addi4, addi5, out3, st3, st4, st5, st6, str3, str4, str5, str6, nop, halt);
	component lpm_mux0
		PORT
		(
			data0x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data1x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data2x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data3x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data4x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data5x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data6x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data7x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data8x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data9x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data10x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data11x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data12x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data13x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data14x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data15x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data16x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data17x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data18x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data19x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data20x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data21x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data22x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data23x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data24x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data25x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data26x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data27x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data28x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data29x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data30x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data31x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	
			sel		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component encoder32
		PORT
		(
			input : in std_logic_vector(31 downto 0);
			result		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
		);
	end component;
	
	component reg32
		port(
			clk, clr, load_en : in std_logic;	-- clock, (active low) reset, and load enable
			d : in std_logic_vector(31 downto 0);	-- 32 bits of input
			q : out std_logic_vector(31 downto 0)	-- 32 bits of output	
		);
	end component;
	
	component reg64
		port(
			clk, clr, load_en : in std_logic;	-- clock, (active low) reset, and load enable
			d : in std_logic_vector(63 downto 0);	-- 64 bits of input
			q1 : out std_logic_vector(31 downto 0);	-- 2 sets of 32 bits of output
			q0 : out std_logic_vector(31 downto 0)	
		);
	end component;
	
	component regMDR
		port(
			clk, clr, MDR_enable, MDRead : in std_logic;
			MDIn0, MDIn1 : in std_logic_vector(31 downto 0);
			MDOut : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component myBus
		PORT (
			muxIn0		: in std_logic_vector (31 downto 0);
			muxIn1		: in std_logic_vector (31 downto 0);
			muxIn2		: in std_logic_vector (31 downto 0);
			muxIn3		: in std_logic_vector (31 downto 0);
			muxIn4		: in std_logic_vector (31 downto 0);
			muxIn5		: in std_logic_vector (31 downto 0);
			muxIn6		: in std_logic_vector (31 downto 0);
			muxIn7		: in std_logic_vector (31 downto 0);
			muxIn8		: in std_logic_vector (31 downto 0);
			muxIn9		: in std_logic_vector (31 downto 0);
			muxIn10		: in std_logic_vector (31 downto 0);
			muxIn11		: in std_logic_vector (31 downto 0);
			muxIn12		: in std_logic_vector (31 downto 0);
			muxIn13		: in std_logic_vector (31 downto 0);
			muxIn14		: in std_logic_vector (31 downto 0);
			muxIn15		: in std_logic_vector (31 downto 0);
			muxIn16		: in std_logic_vector (31 downto 0);
			muxIn17		: in std_logic_vector (31 downto 0);
			muxIn18		: in std_logic_vector (31 downto 0);
			muxIn19		: in std_logic_vector (31 downto 0);
			muxIn20		: in std_logic_vector (31 downto 0);
			muxIn21		: in std_logic_vector (31 downto 0);
			muxIn22		: in std_logic_vector (31 downto 0);
			muxIn23		: in std_logic_vector (31 downto 0);
			muxIn24		: in std_logic_vector (31 downto 0);
			muxIn25		: in std_logic_vector (31 downto 0);
			muxIn26		: in std_logic_vector (31 downto 0);
			muxIn27		: in std_logic_vector (31 downto 0);
			muxIn28		: in std_logic_vector (31 downto 0);
			muxIn29		: in std_logic_vector (31 downto 0);
			muxIn30		: in std_logic_vector (31 downto 0);
			muxIn31		: in std_logic_vector (31 downto 0);
			encoderIn	: in std_logic_vector(31 downto 0);
			BusMuxOut	: out std_logic_vector(31 downto 0)
		);
	end component;

	component and32
		port(
			input0 : in std_logic_vector(31 downto 0);	-- 32 bits of input1
			input1 : in std_logic_vector(31 downto 0);	-- 32 bits of input2
			output : out std_logic_vector(31 downto 0)	-- 32 bits of output
		);
	end component;
	
	component or32
		port(
			input0 : in std_logic_vector(31 downto 0);	-- 2 32 bits of input
			input1 : in std_logic_vector(31 downto 0);
			output : out std_logic_vector(31 downto 0)	-- 32 bits of output
		);
	end component;
	
	component not32
		port(
			input : in std_logic_vector(31 downto 0);	-- 2 32 bits of input
			output : out std_logic_vector(31 downto 0)	-- 32 bits of output
		);
	end component;
	
	component lpm_add_sub0
		PORT
		(
			add_sub		: IN STD_LOGIC ;
			dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			overflow		: OUT STD_LOGIC ;
			result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component boothMul
		port(
			input0 : in std_logic_vector(31 downto 0);
			input1 : in std_logic_vector(31 downto 0);
			output : out std_logic_vector(63 downto 0)
		);
	end component;
	
	component lpm_divide0
		PORT
		(
			denom		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			numer		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			quotient		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			remain		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component shr32
		port(
			input0 : in std_logic_vector(31 downto 0);-- 2 32 bits of input
			input1 : in std_logic_vector(31 downto 0);
			output : out std_logic_vector(31 downto 0)-- 32 bits of output
		);
	end component;
	
	component shl32
		port(
			input0 : in std_logic_vector(31 downto 0);-- 2 32 bits of input
			input1 : in std_logic_vector(31 downto 0);
			output : out std_logic_vector(31 downto 0)-- 32 bits of output
		);
	end component;
	
	component ror32
		PORT
		(
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component rol32
		PORT
		(
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component neg32
		port(
			input: in std_logic_vector(31 downto 0);-- 2 32 bits of input
			output : out std_logic_vector(31 downto 0)-- 32 bits of output
		);
	end component;
	
	component alu
		port(
			input0 : in std_logic_vector(31 downto 0);-- 2 32 bits of input
			input1 : in std_logic_vector(31 downto 0);
			opInput : in std_logic_vector(4 downto 0);-- opcode input
			overflow : out std_logic;-- Overflow out
			output : out std_logic_vector(63 downto 0)-- 32 bits of output
		);
	end component;
	
	component aluPath
		port(
			clk : in std_logic;
			clr : in std_logic;
			yIn : in std_logic;
			zIn : in std_logic;
			input0 : in std_logic_vector(31 downto 0);-- 2 32 bits of input
			input1 : in std_logic_vector(31 downto 0);-- 2 32 bits of input
			IncPC	 : in std_logic;
			opInput : in std_logic_vector(4 downto 0);-- opcode input
			overflow : out std_logic;-- Overflow out
			outputHi	 : out std_logic_vector(31 downto 0);-- 32 bits of output hi
			outputLow : out std_logic_vector(31 downto 0)-- 32 bits of output lo
		);
	end component;
	
end package;