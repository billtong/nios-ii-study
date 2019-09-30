-- ------------------------------------------------------
-- ram8.vhd: implements 8-byte (2-word) writable memory;
--           a byte address is accepted, but bits 1..0
--           are not used, so true byte addressability
--           is not supported in this simplified memory;
--           storage is provided by two 32-bit registers
--
-- Naraig Manjikian
-- September 2019
-- ------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.my_components.all;

-- ------------------------------------------------------------------

entity ram8 is
  port (
    clk        : in std_logic;
    reset_n    : in std_logic;
    cs         : in std_logic;
    we         : in std_logic;
    addr_in    : in std_logic_vector(2 downto 0);
    data_in    : in std_logic_vector(31 downto 0);
    data_out   : out std_logic_vector(31 downto 0)
  );
end entity;

-- ------------------------------------------------------------------

architecture behavior of ram8 is

-- signals for 32-bit output for each word location
signal word0, word1 : std_logic_vector(31 downto 0);

-- signal for output of storage
signal ram_out : std_logic_vector(31 downto 0);

-- signals for selecting and write-enabling each word location
signal sel, en : std_logic_vector(1 downto 0);


begin  -- start of architecture body

-- define individual write-enable signals based on decoder outputs

en(0) <= (not addr_in(2)) and we;
en(1) <=      addr_in(2)  and we;

-- instantiate registers to hold data for the locations in this memory
--   with each register having its dedicated write-enable input,
--   and separate data output for possible selection external entity output,
--   but all using the same external data input

word0_reg : reg32 port map (clk, reset_n, en(0), data_in, word0);
word1_reg : reg32 port map (clk, reset_n, en(1), data_in, word1);

-- 2-to-1 mux to choose between the two words using addr. bit 2

ram_out <=   word0 when (addr_in(2) = '0')
        else word1; -- when (addr_in(2) = '1')

-- define external output from entity when active and not performing a write,
--   otherwise provide X"00000000" as output

data_out <=   ram_out when (cs = '1' and we = '0')
         else (others => '0');
		
end architecture;
