LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mem_reg_tb IS
	GENERIC (CLK_PERIOD	:time	:= 10 ns);
END mem_reg_tb;

ARCHITECTURE mem_reg_tb_arch OF mem_reg_tb IS
COMPONENT mem_reg IS
PORT (
		bus_data	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	-- input D, the
		clr	:	IN STD_LOGIC;	-- clear
		clk	:	IN STD_LOGIC;	-- clock
		en	:	IN STD_LOGIC;	-- write/enable
		m_data	:	IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		read_in	:	IN	STD_LOGIC;	-- 0 from bus out; 1 from mem data;
		q	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output Q
	);
END COMPONENT mem_reg;

-- input signals
SIGNAL bus_data_tb	:	std_logic_vector(31 DOWNTO 0)	:=	(others=>'0');
SIGNAL m_data_tb	:	std_logic_vector(31 DOWNTO 0)	:=	(others=>'0');
SIGNAL read_in_tb	:	std_logic	:=	'0';
SIGNAL clr_tb	:	std_logic	:=	'0';
SIGNAL clk_tb	:	std_logic	:=	'0';
SIGNAL en_tb	:	std_logic	:=	'0';
-- output signals
SIGNAL q_tb	:	std_logic_vector(31 DOWNTO 0);

BEGIN
	-- port mapping between DUT and the testbench signals
	DUT1	:	mem_reg PORT MAP(bus_data_tb, clr_tb, clk_tb, en_tb, m_data_tb, read_in_tb, q_tb);
	-- clock process definitions
	clk_process	:	PROCESS
	BEGIN
		clk_tb	<=	'1';
		wait for CLK_PERIOD/2;
		clk_tb	<=	'0';
		wait for CLK_PERIOD/2;
	END PROCESS clk_process;

	sim_process	:	PROCESS
	BEGIN
		-- test enable input
		bus_data_tb	<=	x"0000_0001";
		m_data_tb	<=	x"0000_0002";
		en_tb	<= '1';
			wait for CLK_PERIOD;
		read_in_tb	<=	'0';
			wait for CLK_PERIOD;
		-- test read_in input
		read_in_tb	<=	'1';
			wait for CLK_PERIOD;
		read_in_tb	<=	'0';
			wait for CLK_PERIOD;
		-- test clear input
		clr_tb	<=	'1';
			wait for CLK_PERIOD;
		clr_tb	<=	'0';
			wait;
	END PROCESS sim_process;
	
END mem_reg_tb_arch;