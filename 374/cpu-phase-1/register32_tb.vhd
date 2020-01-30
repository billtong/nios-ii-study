-- --------------------------------------------------
-- vhdl file of a 32-bit register testbench
-- --------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register32_tb IS
	GENERIC (CLK_PERIOD	:time	:= 10 ns);
END register32_tb;

ARCHITECTURE register32_tb_arch OF register32_tb IS
-- component instantiation of register32's DUT(design under test)
COMPONENT register32
	PORT
	(
		d	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	-- input D, the
		clr	:	IN STD_LOGIC;	-- clear
		clk	:	IN STD_LOGIC;	-- clock
		en	:	IN STD_LOGIC;	-- write/enable
		q	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output Q
	);
END COMPONENT register32;

-- input signals
SIGNAL clr_tb	:	std_logic	:=	'0';
SIGNAL clk_tb	:	std_logic	:=	'0';
SIGNAL en_tb	:	std_logic	:=	'0';
SIGNAL d_tb	:	std_logic_vector(31 DOWNTO 0)	:=	(others=>'0');
-- output signals
SIGNAL q_tb	:	std_logic_vector(31 DOWNTO 0);

BEGIN
	-- port mapping between DUT and the testbench signals
	DUT1	:	register32 PORT MAP (d_tb, clr_tb, clk_tb, en_tb, q_tb);
	-- clock process definitions
	clk_process	:	PROCESS
	BEGIN
		clk_tb	<=	'1';
		wait for CLK_PERIOD/2;
		clk_tb	<=	'0';
		wait for CLK_PERIOD/2;
	END PROCESS clk_process;
	
	-- stimulus process
	sim_process	:	PROCESS
	BEGIN
		-- test enable input
		d_tb	<=	x"0000_0001";
		en_tb	<= '1';
			wait for CLK_PERIOD;
		d_tb	<=	x"0000_0002";
			wait for CLK_PERIOD;
		d_tb	<=	x"0000_0003";
			wait for CLK_PERIOD;
		-- test clear input
		clr_tb	<=	'1';
			wait for CLK_PERIOD;
		clr_tb	<=	'0';
			wait;
	END PROCESS sim_process;
END register32_tb_arch;