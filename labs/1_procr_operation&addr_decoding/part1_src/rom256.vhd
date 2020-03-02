-- ------------------------------------------------------
-- rom256.vhd: implements 256-byte (64-word) ROM memory;
--             a byte address is accepted, but bits 1..0
--             are not used, so true byte addressability
--             is not supported in this simplified memory
--             that functions combinationally to support
--             single-cycle accesses
-- 
-- Naraig Manjikian
-- August 2012
-- revised September 2019
-- ------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- ------------------------------------------------------------------

entity rom256 is
  port (
    cs         : in std_logic;
    addr_in    : in std_logic_vector(7 downto 0);
    data_out   : out std_logic_vector(31 downto 0)
  );
end entity;

-- ------------------------------------------------------------------

architecture behavior of rom256 is

-- define a new type for an array of 256 bytes / 4 = 64 words
type word_array_type is array (0 to 63) of std_logic_vector(31 downto 0);

-- define an instance of 64-word array with specified values
signal storage : word_array_type :=
(
  --00000000 <_start>:
  X"00400144",  --        movi    at,5
  X"00440015",  --        stw     at,4096(zero)
  X"00400404",  --        movi    at,16
  X"00440115",  --        stw     at,4100(zero)

  --00000010 <loop>:
  X"00440017",  --        ldw     at,4096(zero)
  X"08400144",  --        addi    at,at,5
  X"00440015",  --        stw     at,4096(zero)
  X"00440117",  --        ldw     at,4100(zero)
  X"08400404",  --        addi    at,at,16
  X"00440115",  --        stw     at,4100(zero)
  X"003ff906",  --        br      10 <loop>

  --0000002c <_end>:
  X"003fff06",  --        br      2c <_end>
  others => (others => '0') -- fill remainder with X"00000000"
);

-- define an internal signal that is the integer value of
--  the bit vector provided as the address input
signal address_index : integer;


begin         -- start of architecture body

-- convert address bit vector to integer value using upper 6 bits
--   as *word* index into 64-word array

address_index <= to_integer (unsigned (addr_in(7 downto 2)));

-- use the integer index to access the desired word in the array,
--  or produce X"00000000" as output when not selected

data_out <=   storage(address_index) when (cs = '1')
         else (others => '0');

end architecture;
