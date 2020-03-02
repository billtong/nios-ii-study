library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg32 is
	port(
		-- clock, (active low) reset, and load enable
		clk : in std_logic;
		clr : in std_logic;
		load_en : in std_logic;
		-- 32 bits of input
		d : in std_logic_vector(31 downto 0);
		-- 32 bits of output
		q : out std_logic_vector(31 downto 0)
	);
end entity;

architecture logic of reg32 is

begin

reg32 : process(clk, clr)
	begin
		-- if clear is active, set output to 0
		if(clr = '0') then
			q <= (others => '0');
		-- else, if rising edge
		elsif(clk'EVENT and clk = '1') then
			if(load_en = '1') then
				q <= d;
			end if;
		end if;
	end process;
end architecture;