library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.my_components.all;

entity regMDR is
	port(
		clk, clr, MDR_enable, MDRead : in std_logic;
		MDIn0, MDIn1 : in std_logic_vector(31 downto 0);
		MDOut : out std_logic_vector(31 downto 0)
		);
		-- clock, (active low) reset, and load enable
		--clk, clr, load_en : in std_logic;
		-- 32 bits of input
		--d : in std_logic_vector(31 downto 0);
		-- 32 bits of output
		--q : out std_logic_vector(31 downto 0)

end entity;

architecture logic of regMDR is

signal MDMuxOut : std_logic_vector(31 downto 0);

begin


MDMuxOut <= MDIn0    when MDRead = '0' else
	         MDIn1; -- when MDRead = '1'
		
MDRreg : reg32 port map (clk, clr, MDR_enable, MDMuxOut, MDOut);

end architecture;