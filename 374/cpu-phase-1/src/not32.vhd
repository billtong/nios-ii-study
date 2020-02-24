library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity not32 is
	port(
		-- 2 32 bits of input
		input: in std_logic_vector(31 downto 0);
		-- 32 bits of output
		output : out std_logic_vector(31 downto 0)
	);
end entity;

architecture logic of not32 is

begin

output <= not input;

end architecture;