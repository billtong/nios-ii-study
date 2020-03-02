library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.my_components.all;

entity SUB32 is port (
	x   : in  std_logic_vector(31 downto 0);
	y   : in  std_logic_vector(31 downto 0);
   c0  : in  std_logic;
	c32 : out std_logic;
	s : out std_logic_vector(31 downto 0)
);
end entity;

architecture bhv of SUB32 is
signal yc:	std_logic_vector(31 downto 0);
signal c16lo, c16hi: std_logic;
begin
yc <= std_logic_vector(signed(not y) + 1);
aluCLA	: CLA32 port map (x, yc, c0, c32, s);
end architecture;
