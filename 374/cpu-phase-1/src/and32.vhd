library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity and32 is
	port(
		input0 : in std_logic_vector(31 downto 0);	-- 32 bits of input1
		input1 : in std_logic_vector(31 downto 0);	-- 32 bits of input2
		output : out std_logic_vector(31 downto 0)	-- 32 bits of output
	);
end entity;

architecture logic of and32 is
begin
output <= input0 and input1;
end architecture;
