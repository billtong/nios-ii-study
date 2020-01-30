-- --------------------------------------------------
-- vhdl file of a 32 to 5 decoder
-- --------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY decoder_32to5 IS PORT
(
	d	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	-- 32-bit code
	s	:	OUT STD_LOGIC_VECTOR(4 DOWNTO 0)	-- 5-bit encode
);
END ENTITY decoder_32to5;

ARCHITECTURE behavioral OF decoder_32to5 IS
BEGIN
	process(d)
	BEGIN
		case d is
		when "10000000000000000000000000000000" => s <= "00000";
		when "01000000000000000000000000000000" => s <= "00001";
		when "00100000000000000000000000000000" => s <= "00010";
		when "00010000000000000000000000000000" => s <= "00011";
		when "00001000000000000000000000000000" => s <= "00100";
		when "00000100000000000000000000000000" => s <= "00101";
		when "00000010000000000000000000000000" => s <= "00110";
		when "00000001000000000000000000000000" => s <= "00111";
		when "00000000100000000000000000000000" => s <= "01000";
		when "00000000010000000000000000000000" => s <= "01001";
		when "00000000001000000000000000000000" => s <= "01010";
		when "00000000000100000000000000000000" => s <= "01011";
		when "00000000000010000000000000000000" => s <= "01100";
		when "00000000000001000000000000000000" => s <= "01101";
		when "00000000000000100000000000000000" => s <= "01110";
		when "00000000000000010000000000000000" => s <= "01111";
		when "00000000000000001000000000000000" => s <= "10000";
		when "00000000000000000100000000000000" => s <= "10001";
		when "00000000000000000010000000000000" => s <= "10010";
		when "00000000000000000001000000000000" => s <= "10011";
		when "00000000000000000000100000000000" => s <= "10100";
		when "00000000000000000000010000000000" => s <= "10101";
		when "00000000000000000000001000000000" => s <= "10110";
		when "00000000000000000000000100000000" => s <= "10111";
		when "00000000000000000000000010000000" => s <= "11000";
		when "00000000000000000000000001000000" => s <= "11001";
		when "00000000000000000000000000100000" => s <= "11010";
		when "00000000000000000000000000010000" => s <= "11011";
		when "00000000000000000000000000001000" => s <= "11100";
		when "00000000000000000000000000000100" => s <= "11101";
		when "00000000000000000000000000000010" => s <= "11110";
		when "00000000000000000000000000000001" => s <= "11111";
		when others => s <= "ZZZZZ";
		end case;
	END process;
END behavioral;