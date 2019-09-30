-- ------------------------------------------------------
-- system.vhd: top-level entity incorporating an instance
-- of a processor and storage for code/data;
-- output signals allow for observation of operation
--
-- Naraig Manjikian
-- February 2012
-- revised September 2019
-- ------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- provides declarations for components used inside this entity
use work.my_components.all;

-- ------------------------------------------------------

entity system is
  port (
    clk             : in std_logic;
    reset_n         : in std_logic;
    ifetch_out      : out std_logic;
    mem_addr_out    : out std_logic_vector(31 downto 0);
    data_from_procr : out std_logic_vector(31 downto 0);
    data_to_procr   : out std_logic_vector(31 downto 0);
    mem_read        : out std_logic;
    mem_write       : out std_logic;
    rom_active      : out std_logic;
    ram_active      : out std_logic
  );
end entity;

-- ------------------------------------------------------

architecture synth of system is

-- address from processor
signal internal_addr : std_logic_vector(31 downto 0);

-- signal asserted from processor in cycle where a write is to be performed
signal internal_write : std_logic;

-- data from processor that is destined to a memory device
signal data_to_mem: std_logic_vector(31 downto 0);

-- data from memory that is destined to the processor
signal data_from_mem : std_logic_vector(31 downto 0);

-- individual chip-select signals for memory devices for convenience
signal ram_select, rom_select : std_logic;

-- data outputs from individual memory devices
signal ram_data_out, rom_data_out : std_logic_vector(31 downto 0);


begin  -- start of architecture body

-- instantiate the processor; map its ports to toplevel and internal signals

the_processor : processor
  port map (
    clk          => clk,
    reset_n      => reset_n,
    mem_addr_out => internal_addr,
    mem_data_out => data_to_mem,
    mem_data_in  => data_from_mem,
    mem_read     => mem_read,
    mem_write    => internal_write,
    ifetch_out   => ifetch_out
  );

-- address decoding blocks for each memory use appropriate upper bits
--   based on memory size to match pattern for starting address

-- RAM start is 0x00001000 so upper 32 - 3 = 29 bits are all zero
--   *except* original addr bit 12 (thirteenth, or tenth with 29 bits)
ram_select <=   '1'  when (internal_addr(31 downto 3) =
                           "00000000000000000001000000000")
           else '0';

-- ROM start is 0x00000000 so upper 32 - 8 = 24 bits are 0x000000
rom_select <=   '1'  when (internal_addr(31 downto 8) =
                           X"000000")
           else '0';

-- instantiate the 256-byte ROM;
--   8 address bits are provided, but it is not byte-addressable;
--   the upper 6 of these bits select one of the 64 words

the_rom : rom256
  port map (
    cs       => rom_select,
	 addr_in  => internal_addr(7 downto 0),
	 data_out => rom_data_out
  );

-- instantiate the 8-byte RAM;
--   3 address bits are provided, but it is not byte-addressable;
--   the upper 1 of these 3 bits select one of the 2 words

the_ram : ram8
  port map (
    clk      => clk,
	 reset_n  => reset_n,
	 cs       => ram_select,
	 we       => internal_write,
	 addr_in  => internal_addr(2 downto 0),
	 data_in  => data_to_mem,
	 data_out => ram_data_out
  );

-- because all of the addressable devices above have been designed
--  to always provide X"00000000" as output when not selected, it is possible
--  to simply OR together all of the device outputs; at most one of them
--  will have any logic-1 bits that, when ORed with all-zero outputs from
--  all of the non-selected devices, will appear in the final output value

data_from_mem <= rom_data_out or ram_data_out;  -- vectors are ORed bit by bit

-- finally, make signal assignments for the remaining toplevel ports
--  to allow the internal behavior to be observed

data_from_procr <= data_to_mem;
mem_addr_out    <= internal_addr;
mem_write       <= internal_write;
data_to_procr   <= data_from_mem;
rom_active      <= rom_select;
ram_active      <= ram_select;

end architecture;
