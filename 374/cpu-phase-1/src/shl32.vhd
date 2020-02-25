library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use ieee.numeric_std.all;

entity shl32 is
	port(
		input0 : in std_logic_vector(31 downto 0);	-- 2 32 bits of input
		input1 : in std_logic_vector(31 downto 0);	-- 32 bits of output
		output : out std_logic_vector(31 downto 0)
	);
end entity;

architecture logic of shl32 is
begin
output <= std_logic_vector(shift_left(unsigned(input0), to_integer(signed(input1)))); 
end architecture;
