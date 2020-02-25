library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity boothMul is
	port(
		input0 : in std_logic_vector(31 downto 0);
		input1 : in std_logic_vector(31 downto 0);
		output : out std_logic_vector(63 downto 0)
	);
end entity;

architecture booth_logic of boothMul is
begin
boothMul : process(input0, input1)
variable sum : signed(63 downto 0) := (others => '0');
variable M : signed(63 downto 0);
variable q : signed(32 downto 0);
	begin
	M := resize(signed(input1),  M'length);
	q(0) := '0';
	q(32 downto 1) := signed(input0);
	for i in 0 to 31 loop
		if(q(0) = '0' and q(1) = '1') then
			sum := sum - (M sll i);
		elsif(q(0) = '1' and q(1) = '0') then
			sum := sum + (M sll i);
		end if;
		q := q srl 1;
	end loop;
	output <= std_logic_vector(sum);
	sum := (others => '0');
	end process;
end architecture;
