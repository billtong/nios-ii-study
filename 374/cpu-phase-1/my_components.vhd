LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE my_components IS

COMPONENT decoder_32to5
	PORT(
		d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux_32to1
	PORT(
		d00, d01, d02, d03, d04, d05, d06, d07, d08, d09, 
		d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, 
		d20, d21, d22, d23, d24, d25, d26, d27, d28, d29,
		d30, d31	: IN STD_LOGIC_VECTOR(31 DOWNTO 0)	:=	(others=>'0');	-- 32 input
		s	:	IN STD_LOGIC_VECTOR(4 DOWNTO 0);	-- 5-bit encode control
		q	: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)	-- 1 output
	);
END COMPONENT;

COMPONENT register32
	PORT(
		d	: IN STD_LOGIC_VECTOR(31 DOWNTO 0) :=	(others=>'0');	-- input D, the
		clr	:	IN STD_LOGIC;	-- clear
		clk	:	IN STD_LOGIC;	-- clock
		en	:	IN STD_LOGIC;	-- write/enable
		q	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output Q
	);
END COMPONENT;

COMPONENT mem_reg
	PORT(
		bus_data	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	-- input D, the
		clr	:	IN STD_LOGIC;	-- clear
		clk	:	IN STD_LOGIC;	-- clock
		en	:	IN STD_LOGIC;	-- write/enable
		m_data	:	IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		read_in	:	IN	STD_LOGIC;	-- 0 from bus out; 1 from mem data;
		q	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output Q
	);
END COMPONENT;
END PACKAGE;
