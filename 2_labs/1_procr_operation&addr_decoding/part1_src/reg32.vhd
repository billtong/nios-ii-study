-- ------------------------------------------------------
-- reg32.vhd: code for a 32-bit register with load enable
--
-- Naraig Manjikian
-- February 2012
-- ------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- ------------------------------------------------------

entity reg32 is
  port (
    clk     : in std_logic;
    reset_n : in std_logic;
    en      : in std_logic;
    d       : in std_logic_vector(31 downto 0);
    q       : out std_logic_vector(31 downto 0)
  );
end entity;

-- ------------------------------------------------------

architecture behavior of reg32 is
begin
  process (clk, reset_n)
    begin
      if (reset_n = '0') then
        q <= (others => '0');
      elsif (rising_edge(clk)) then
        if (en = '1') then
          q <= d;
        end if;
      end if;
    end process;  
end architecture;
