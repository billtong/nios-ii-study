library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity neg32 is
	port(
		-- 2 32 bits of input
		input: in std_logic_vector(31 downto 0);
		-- 32 bits of output
		output : out std_logic_vector(31 downto 0)
	);
end entity;

architecture logic of neg32 is

begin

output <= std_logic_vector(signed(not input) + 1);

end architecture;