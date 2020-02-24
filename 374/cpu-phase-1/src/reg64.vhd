library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg64 is
	port(
		-- clock, (active low) reset, and load enable
		clk, clr, load_en : in std_logic;
		-- 64 bits of input
		d : in std_logic_vector(63 downto 0);
		-- 2 sets of 32 bits of output
		q1 : out std_logic_vector(31 downto 0);
		q0 : out std_logic_vector(31 downto 0)	
	);
end entity;

architecture logic of reg64 is

begin

reg64 : process(clk, clr)
	begin
		-- if clear is active, set output to 0
		if(clr = '0') then
			q1 <= (others => '0');
			q0 <= (others => '0');
		-- else, if rising edge
		elsif(clk'EVENT and clk = '1') then
			if(load_en = '1') then
				q1 <= d(63 downto 32);
				q0 <= d(31 downto 0);
			end if;
		end if;
	end process;
end architecture;