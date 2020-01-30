-- --------------------------------------------------
-- vhdl file of a 32 to 1 multiplux testbench
-- --------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_32to1_tb IS
END mux_32to1_tb;

ARCHITECTURE mux_32to1_tb_arch OF MUX_32to1_tb IS
	-- component declaration of the Unit Under Test (UUT)
	COMPONENT mux_32to1 PORT
	(
		d00, d01, d02, d03, d04, d05, d06, d07, d08, d09, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	-- 32 input
		s_tb	:	IN STD_LOGIC_VECTOR(4 DOWNTO 0);	-- 5-bit encode control
		q	: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)	-- 1 output
	);
	END COMPONENT mux_32to1;
	-- inputs
	SIGNAL d00_tb, d01_tb, d02_tb, d03_tb, d04_tb, d05_tb, d06_tb, d07_tb, d08_tb, d09_tb, d10_tb, d11_tb, d12_tb, d13_tb, d14_tb, d15_tb, d16_tb, d17_tb, d18_tb, d19_tb, d20_tb, d21_tb, d22_tb, d23_tb, d24_tb, d25_tb, d26_tb, d27_tb, d28_tb, d29_tb,d30_tb, d31_tb	:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= (others => '0');
	SIGNAL s_tb	:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:=	(others => '0');
	-- outputs
	SIGNAL q_tb	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
	-- instantiate the Unit Under Test (UUT)
	uut1	:	mux_32to1 PORT MAP	(d00_tb, d01_tb, d02_tb, d03_tb, d04_tb, d05_tb, d06_tb, d07_tb, d08_tb, d09_tb, d10_tb, d11_tb, d12_tb, d13_tb, d14_tb, d15_tb, d16_tb, d17_tb, d18_tb, d19_tb, d20_tb, d21_tb, d22_tb, d23_tb, d24_tb, d25_tb, d26_tb, d27_tb, d28_tb, d29_tb, d30_tb, d31_tb, s_tb, q_tb);
	
	-- stimulus process
	stim_proc : process
	BEGIN
		-- hold reset state for 100 ns.
			wait for 100 ns;
		d00_tb	<=	x"0000_0000"; d01_tb	<=	x"0000_0001"; d02_tb	<=	x"0000_0002"; d03_tb	<=	x"0000_0003"; d04_tb	<=	x"0000_0004"; d05_tb	<=	x"0000_0005"; d06_tb	<=	x"0000_0006"; d07_tb	<=	x"0000_0007"; d08_tb	<=	x"0000_0008"; d09_tb	<=	x"0000_0009";
		d10_tb	<=	x"0000_0010"; d11_tb	<=	x"0000_0011"; d12_tb	<=	x"0000_0012"; d13_tb	<=	x"0000_0013"; d14_tb	<=	x"0000_0014"; d15_tb	<=	x"0000_0015"; d16_tb	<=	x"0000_0016"; d17_tb	<=	x"0000_0017"; d18_tb	<=	x"0000_0018"; d19_tb	<=	x"0000_0019";
		d20_tb	<=	x"0000_0020"; d21_tb	<=	x"0000_0021"; d22_tb	<=	x"0000_0022"; d23_tb	<=	x"0000_0023"; d24_tb	<=	x"0000_0024"; d25_tb	<=	x"0000_0025"; d26_tb	<=	x"0000_0026"; d27_tb	<=	x"0000_0027"; d28_tb	<=	x"0000_0028"; d29_tb	<=	x"0000_0029";
		d30_tb	<=	x"0000_0030"; d31_tb	<=	x"0000_0031";
		s_tb <= "00000";	-- 0_0000
			wait for 100 ns;
		s_tb <= "00001";	-- 0_0001
			wait for 100 ns;
		s_tb <= "00010";	--	0_0010
			wait for 100 ns;
		s_tb <= "00011";	--	0_0011
			wait for 100 ns;
		s_tb <= "00100";	-- 0_0100
			wait for 100 ns;
		s_tb <= "00101";	-- 0_0101
			wait for 100 ns;
		s_tb <= "00110";	-- 0_0110
			wait for 100 ns;
		s_tb <= "00111";	-- 0_0111
			wait for 100 ns;
		s_tb <= "01000";	-- 0_1000
			wait for 100 ns;
		s_tb <= "01001";	-- 0_1001
			wait for 100 ns;
		s_tb <= "01010";	-- 0_1010
			wait for 100 ns;
		s_tb <= "01011";	-- 0_1011
			wait for 100 ns;
		s_tb <= "01100";	-- 0_1100
			wait for 100 ns;
		s_tb <= "01101";	-- 0_1101
			wait for 100 ns;
		s_tb <= "01110";	-- 0_1110
			wait for 100 ns;
		s_tb <= "01111";	-- 0_1111
			wait for 100 ns;
		s_tb <= "10000";	-- 1_0000
			wait for 100 ns;
		s_tb <= "10001";	-- 1_0001
			wait for 100 ns;
		s_tb <= "10010";	--	1_0010
			wait for 100 ns;
		s_tb <= "10011";	--	1_0011
			wait for 100 ns;
		s_tb <= "10100";	-- 1_0100
			wait for 100 ns;
		s_tb <= "10101";	-- 1_0101
			wait for 100 ns;
		s_tb <= "10110";	-- 1_0110
			wait for 100 ns;
		s_tb <= "10111";	-- 1_0111
			wait for 100 ns;
		s_tb <= "11000";	-- 1_1000
			wait for 100 ns;
		s_tb <= "11001";	-- 1_1001
			wait for 100 ns;
		s_tb <= "11010";	-- 1_1010
			wait for 100 ns;
		s_tb <= "11011";	-- 1_1011
			wait for 100 ns;
		s_tb <= "11100";	-- 1_1100
			wait for 100 ns;
		s_tb <= "11101";	-- 1_1101
			wait for 100 ns;
		s_tb <= "11110";	-- 1_1110
			wait for 100 ns;
		s_tb <= "11111";	-- 1_1111
				wait;
	END process stim_proc;	
END mux_32to1_tb_arch;