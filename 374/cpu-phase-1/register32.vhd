-- --------------------------------------------------
-- vhdl file of a 32-bit register
-- --------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register32 IS PORT (
	d	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	-- input D, the
	clr	:	IN STD_LOGIC;	-- clear
	clk	:	IN STD_LOGIC;	-- clock
	en	:	IN STD_LOGIC;	-- write/enable
	q	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output Q
);
END ENTITY register32;

-- logic of register (flipflop)
ARCHITECTURE behavioral OF register32 IS
BEGIN
	process(clk, clr)
	begin
		if clr = '1' then
			q <= (others=>'0');	-- x"00000000"
		elsif rising_edge(clk) then
			if en = '1' then
				q <= d;
			end if;
		end if;
	end process;
END behavioral;