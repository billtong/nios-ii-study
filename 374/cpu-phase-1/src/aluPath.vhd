library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use ieee.numeric_std.all;

use work.my_components.all;

entity aluPath is
	port(
		clk : in std_logic;
		clr : in std_logic;
		yIn : in std_logic;
		zIn : in std_logic;
		-- 2 32 bits of input
		input0 : in std_logic_vector(31 downto 0);
		input1 : in std_logic_vector(31 downto 0);
		IncPC	 : in std_logic;
		-- opcode input
		opInput : in std_logic_vector(4 downto 0);
		-- Overflow out
		overflow : out std_logic;
		-- 32 bits of output
		outputHi	 : out std_logic_vector(31 downto 0);
		outputLow : out std_logic_vector(31 downto 0)
	);
end entity;

architecture logic of aluPath is

signal yOut : std_logic_vector(31 downto 0);
signal toZ	: std_logic_vector(63 downto 0);
signal aluOut : std_logic_vector(63 downto 0);
signal PCAdd : std_logic_vector(63 downto 0);

begin

Y		: reg32 port map(clk, clr, yIn, input0, yOut);
Z		: reg64 port map(clk, clr, zIn, toZ, outputHi, outputLow);
aluInstance 	: alu port map (yOut, input1, opInput, overflow, aluOut);

PCAdd(31 downto 0) <= std_logic_vector(unsigned(input0) + 1);
PCAdd(63 downto 32) <= (others => '0');

toZ <= aluOut when IncPC = '0' else
	PCAdd; -- when IncPC = '1'

end architecture;