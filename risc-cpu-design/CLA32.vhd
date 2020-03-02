library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.my_components.all;

entity CLA32 is port (
	x   : in  std_logic_vector(31 downto 0);
	y   : in  std_logic_vector(31 downto 0);
   c0  : in  std_logic;
	c32 : out std_logic;
	s : out std_logic_vector(31 downto 0)
);
end entity;

architecture bhv of CLA32 is
signal xlo, ylo, slo, xhi, yhi, shi:	std_logic_vector(15 downto 0);
signal c16lo, c16hi: std_logic;
begin
xlo <= x(15 downto 0);
ylo <= y(15 downto 0);
xhi <= x(15 downto 0);
yhi <= y(15 downto 0); 
aluCLAlo	:	CLA32 port map (xlo, ylo, c0, c16lo, slo);
aluCLAhi	:	CLA32 port map (xhi, yhi, c16lo, c16hi, shi);
c32 <= c16hi;
s(15 downto 0) <= slo;
s(31 downto 16) <= shi;
end architecture;

