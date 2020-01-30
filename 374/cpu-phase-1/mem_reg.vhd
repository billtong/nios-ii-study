LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY work;


ENTITY mem_reg IS 
	PORT (
		bus_data	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	-- input D, the
		clr	:	IN STD_LOGIC;	-- clear
		clk	:	IN STD_LOGIC;	-- clock
		en	:	IN STD_LOGIC;	-- write/enable
		m_data	:	IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		read_in	:	IN	STD_LOGIC;	-- 0 from bus out; 1 from mem data;
		q	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output Q
	);
END ENTITY mem_reg;

ARCHITECTURE behavioral OF mem_reg IS
COMPONENT register32
	PORT(clr : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 en : IN STD_LOGIC;
		 d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;
SIGNAL md_mux_output	:	STD_LOGIC_VECTOR(31 DOWNTO 0);	
BEGIN
	process(read_in, bus_data, m_data)
	begin
		if (read_in = '0') then
			md_mux_output <= bus_data; 
		else	-- read_in = 1
			md_mux_output <= m_data;
		end if;
	end process;
	reg : register32 PORT MAP (clr, clk, en, md_mux_output, q);
END behavioral;	
	