library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity or32 is
	port(
		input0 : in std_logic_vector(31 downto 0);	-- 2 32 bits of input
		input1 : in std_logic_vector(31 downto 0);	-- 32 bits of output
		output : out std_logic_vector(31 downto 0)
	);
end entity;

architecture logic of or32 is
begin
output <= input0 or input1;
end architecture;