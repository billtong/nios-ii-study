library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.my_components.all;

entity myBus is
	PORT (
		muxIn0		: in std_logic_vector (31 downto 0);
		muxIn1		: in std_logic_vector (31 downto 0);
		muxIn2		: in std_logic_vector (31 downto 0);
		muxIn3		: in std_logic_vector (31 downto 0);
		muxIn4		: in std_logic_vector (31 downto 0);
		muxIn5		: in std_logic_vector (31 downto 0);
		muxIn6		: in std_logic_vector (31 downto 0);
		muxIn7		: in std_logic_vector (31 downto 0);
		muxIn8		: in std_logic_vector (31 downto 0);
		muxIn9		: in std_logic_vector (31 downto 0);
		muxIn10		: in std_logic_vector (31 downto 0);
		muxIn11		: in std_logic_vector (31 downto 0);
		muxIn12		: in std_logic_vector (31 downto 0);
		muxIn13		: in std_logic_vector (31 downto 0);
		muxIn14		: in std_logic_vector (31 downto 0);
		muxIn15		: in std_logic_vector (31 downto 0);
		muxIn16		: in std_logic_vector (31 downto 0);
		muxIn17		: in std_logic_vector (31 downto 0);
		muxIn18		: in std_logic_vector (31 downto 0);
		muxIn19		: in std_logic_vector (31 downto 0);
		muxIn20		: in std_logic_vector (31 downto 0);
		muxIn21		: in std_logic_vector (31 downto 0);
		muxIn22		: in std_logic_vector (31 downto 0);
		muxIn23		: in std_logic_vector (31 downto 0);
		muxIn24		: in std_logic_vector (31 downto 0);
		muxIn25		: in std_logic_vector (31 downto 0);
		muxIn26		: in std_logic_vector (31 downto 0);
		muxIn27		: in std_logic_vector (31 downto 0);
		muxIn28		: in std_logic_vector (31 downto 0);
		muxIn29		: in std_logic_vector (31 downto 0);
		muxIn30		: in std_logic_vector (31 downto 0);
		muxIn31		: in std_logic_vector (31 downto 0);
		encoderIn	: in std_logic_vector(31 downto 0);
		BusMuxOut	: out std_logic_vector(31 downto 0)
	);
end entity;

----------------------------------------------------------------

architecture logic of myBus is



signal BusSel : std_logic_vector(4 downto 0);

---- Default ----
--signal defaultSig : UNSIGNED(31 downto 0) := (others => 'X'); 
signal defaultSig : std_logic_vector(31 downto 0);

begin

---- Instantiate Encoder and Mux ----
BusEncoder : encoder32 port map (encoderIn, BusSel);

BusMux : lpm_mux0 port map (muxIn0, muxIn1, muxIn2, muxIn3, muxIn4, muxIn5, muxIn6, muxIn7, muxIn8, muxIn9, muxIn10, muxIn11, muxIn12, muxIn13,
muxIn14, muxIn15, muxIn16, muxIn17, muxIn18, muxIn19, muxIn20, muxIn21, muxIn22, muxIn23, muxIn24, muxIn25, muxIn26, muxIn27, muxIn28, muxIn29, muxIn30, muxIn31, BusSel, BusMuxOut);

end architecture;