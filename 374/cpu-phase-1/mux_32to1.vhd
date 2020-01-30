-- --------------------------------------------------
-- vhdl file of a 32 to 1 multiplux
-- --------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_32to1 IS PORT
(
	d00, d01, d02, d03, d04, d05, d06, d07, d08, d09, 
	d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, 
	d20, d21, d22, d23, d24, d25, d26, d27, d28, d29,
	d30, d31	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	-- 32 input
	s	:	IN STD_LOGIC_VECTOR(4 DOWNTO 0);	-- 5-bit encode control
	q	: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)	-- 1 output
);
END ENTITY mux_32to1;

ARCHITECTURE behavioral OF mux_32to1 IS
BEGIN
	process(
		d00, d01, d02, d03, d04, d05, d06, d07, d08, d09, 
		d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, 
		d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, 
		d30, d31, s
	)
	BEGIN
		if (s = "00000") then	-- 0_0000=>00
			q	<=	d00;
		elsif (s = "00001") then	-- 0_0001=>01
			q	<= d01;
		elsif (s = "00010") then	-- 0_0010=>02
			q	<= d02;
		elsif (s = "00011") then	-- 0_0011=>03
			q	<= d03;
		elsif (s = "00100") then	-- 0_0100=>04
			q	<= d04;
		elsif (s = "00101") then	-- 0_0101=>05
			q	<= d05;
		elsif (s = "00110") then	-- 0_0110=>06
			q	<= d06;
		elsif (s = "00111") then	-- 0_0111=>07
			q	<= d07;
		elsif (s = "01000") then	-- 0_1000=>08
			q	<= d08;
		elsif (s = "01001") then	-- 0_1001=>09
			q	<= d09;
		elsif (s = "01010") then	-- 0_1010=>10
			q	<= d10;
		elsif (s = "01011") then	-- 0_1011=>11
			q	<= d11;
		elsif (s = "01100") then	-- 0_1100=>12
			q	<= d12;
		elsif (s = "01101") then	-- 0_1101=>13
			q	<= d13;
		elsif (s = "01110") then	-- 0_1110=>14
			q	<= d14;
		elsif (s = "01111") then	-- 0_1111=>15
			q	<= d15;
		elsif (s = "10000") then	-- 1_0000=>16
			q	<= d16;
		elsif (s = "10001") then	-- 1_0001=>17
			q	<= d17;
		elsif (s = "10010") then	-- 1_0010=>18
			q	<= d18;
		elsif (s = "10011") then	-- 1_0011=>19
			q	<= d19;
		elsif (s = "10100") then	-- 1_0100=>20
			q	<= d20;
		elsif (s = "10101") then	-- 1_0101=>21
			q	<= d21;
		elsif (s = "10110") then	-- 1_0110=>22
			q	<= d22;
		elsif (s = "10111") then	-- 1_0111=>23
			q	<= d23;
		elsif (s = "11000") then	-- 1_1000=>24
			q	<= d24;
		elsif (s = "11001") then	-- 1_1001=>25
			q	<= d25;
		elsif (s = "11010") then	-- 1_1010=>26
			q	<= d26;
		elsif (s = "11011") then	-- 1_1011=>27
			q	<= d27;
		elsif (s = "11100") then	-- 1_1100=>28
			q	<= d28;
		elsif (s = "11101") then	-- 1_1101=>29
			q	<= d29;
		elsif (s = "11110") then	-- 1_1110=>30
			q	<= d30;
		elsif (s = "11111") then	-- 1_1111=>31
			q	<= d31;
		else	-- could not happen
			q	<=	(others=>'0');
		end if;
	end process;
END behavioral;
