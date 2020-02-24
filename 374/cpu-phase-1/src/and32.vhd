library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity and32 is
	port(
		-- 2 32 bits of input
		input0 : in std_logic_vector(31 downto 0);
		input1 : in std_logic_vector(31 downto 0);
		-- 32 bits of output
		output : out std_logic_vector(31 downto 0)
	);
end entity;

architecture logic of and32 is

begin

output <= input0 and input1;

end architecture;