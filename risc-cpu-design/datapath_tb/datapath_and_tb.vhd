-- --------------------------------------------------
-- vhdl test bench file of and/or/add/sub/div/mul/ror/rol/shr/shl instructions
-- --------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity datapath_and_tb is
end;

architecture logic of datapath_and_tb is
-- input
signal clk_tb : std_logic;
signal clr_tb : std_logic;
signal IncPC_tb	: std_logic;
signal MDRRead_tb	: std_logic;
signal aluOp		: std_logic_vector(4 downto 0); -- aluOp
signal encoderIn_tb	: std_logic_vector(31 downto 0);
signal RegEnable_tb	: std_logic_vector(31 downto 0);
signal Mdatain_tb	:	std_logic_vector(31 downto 0);
-- output
signal BusMuxOut_tb, HIout_tb, LOout_tb, IRout_tb	:	std_logic_vector(31 downto 0);
signal Zout_tb	:	std_logic_vector(63 downto 0);
signal R2out_tb			: std_logic_vector(31 downto 0);
signal R4out_tb			: std_logic_vector(31 downto 0);
signal R5out_tb			: std_logic_vector(31 downto 0);
type	state is(default, Reg_load1a, Reg_load1b, Reg_load2a, Reg_load2b, Reg_load3a, Reg_load3b, T0, T1, T2, T3, T4, T5, T6);
signal	present_state: State := default;

component datapath
	PORT (
		clk			: in std_logic;
		---- phase one control signals ----
		internalEncoderIn	: in std_logic_vector(31 downto 0);
		internalRegEnableIn : in std_logic_vector(31 downto 0);
		Mdatain	: in std_logic_vector(31 downto 0);
		MDRRead	: in std_logic;
		aluOp		: in std_logic_vector(4 downto 0);
		IncPC		: in std_logic;
		---- Outputports for testing purposes ----
		BusMuxOut	: out std_logic_vector(31 downto 0);
		R2out			: out std_logic_vector(31 downto 0);
		R4out			: out std_logic_vector(31 downto 0);
		R5out			: out std_logic_vector(31 downto 0);
		HIout			: out std_logic_vector(31 downto 0);
		LOout			: out std_logic_vector(31 downto 0);
		IRout			: out std_logic_vector(31 downto 0);
		Zout			: out std_logic_vector(63 downto 0)
	);
end component;

begin
datapathTest : datapath port map (clk_tb, encoderIn_tb, RegEnable_tb, Mdatain_tb, MDRRead_tb, aluOp, IncPC_tb, BusMuxOut_tb,
	R2out_tb, R4out_tb, R5out_tb,
	HIout_tb, LOout_tb, IRout_tb, Zout_tb);

clk_process: process
begin
	clk_tb <= '1', '0' after 10 ns;
	wait for 20 ns;
end process clk_process;

process(clk_tb)
begin
	if(clk_tb'EVENT and clk_tb = '1') then
		case present_state is
			when default =>
				present_state <= Reg_load1a;
			when Reg_load1a =>
				present_state <= Reg_load1b;
			when Reg_load1b =>
				present_state <= Reg_load2a;
			when Reg_load2a =>
				present_state <= Reg_load2b;
			when Reg_load2b =>
				present_state <= Reg_load3a;
			when Reg_load3a =>
				present_state <= Reg_load3b;
			when Reg_load3b =>
				present_state <= T0;
			when T0 =>
				present_state <= T1;
			when T1 =>
				present_state <= T2;
			when T2 =>
				present_state <= T3;
			when T3 =>
				present_state <= T4;
			when T4 =>
				present_state <= T5;
			when T5 =>
				present_state <= T6;
			when others =>
		end case;
	end if;
end process;

process (present_state)
begin
	case present_state is
		when default =>
			IncPC_tb <= '0';
			MDRRead_tb <= '0';
			aluOp <= (others => '0');
			Mdatain_tb <= (others => '0');
			encoderIn_tb <= (others => '0');
			RegEnable_tb <= (others => '0');
		when Reg_load1a =>
			Mdatain_tb <= x"00000022";
			MDRRead_tb <= '0', '1' after 10 ns, '0' after 25 ns;
			RegEnable_tb <= (others=>'0'), (20=>'1', others=>'0') after 10 ns, (others=>'0') after 25 ns;	-- MDR load_en
		when Reg_load1b =>
			encoderIn_tb <= (others=>'0'), (21 => '1', others => '0') after 10 ns, (others=>'0') after 25 ns;	-- MDRout encoder
			RegEnable_tb <= (others=>'0'), (2 => '1', others => '0') after 10 ns, (others=>'0') after 25 ns;	-- R2 load_en
		when Reg_load2a =>
			Mdatain_tb <= x"00000024";
			MDRRead_tb <= '0', '1' after 10 ns, '0' after 25 ns;
			RegEnable_tb <= (others=>'0'), (20=>'1', others=>'0') after 10 ns, (others=>'0') after 25 ns;	-- MDRin
		when Reg_load2b =>
			encoderIn_tb <= (others=>'0'), (21 => '1', others => '0')after 10 ns, (others=>'0') after 25 ns;	-- MDRout encoder
			RegEnable_tb <= (others=>'0'), (4 => '1', others => '0')after 10 ns, (others=>'0') after 25 ns;	-- R4 load_en
		when Reg_load3a =>
			Mdatain_tb <= x"00000026";
			MDRRead_tb <= '0', '1' after 10 ns, '0' after 25 ns;
			RegEnable_tb <= (others=>'0'), (20=>'1', others=>'0') after 10 ns, (others=>'0') after 25 ns;	-- MDRin
		when Reg_load3b =>
			encoderIn_tb <= (others=>'0'), (21 => '1', others => '0')after 10 ns, (others=>'0') after 25 ns;	-- MDRout encoder
			RegEnable_tb <= (others=>'0'), (5 => '1', others => '0')after 10 ns, (others=>'0') after 25 ns;	-- R5 load_en
		when T0 =>
			encoderIn_tb <= (20 => '1', others => '0');	-- pc encoder
			RegEnable_tb <= (21 => '1', 23 => '1', others => '0');	-- MAR, Zin
			IncPC_tb <= '1';
		when T1 =>
			encoderIn_tb <= (19 => '1', others => '0'); -- zlow encoder
			RegEnable_tb <= (18 => '1', 20 => '1', others => '0'); -- pc load_en, MDR load_en
			IncPC_tb <= '0';
			MDRRead_tb <= '1';
			Mdatain_tb <= x"4A920000";	-- opcode for “and R5, R2, R4” 
			-- Mdatain_tb <= x"52920000";	-- opcode for “and R5, R2, R4”
			-- Mdatain_tb <= x"1A920000";	-- opcode for “add R5, R2, R4” 
			-- Mdatain_tb <= x"22920000";	-- opcode for “sub R5, R2, R4” 
			-- Mdatain_tb <= x"7A920000";	-- opcode for “and R5, R2, R4” 
			-- Mdatain_tb <= x"7A920000";	-- opcode for “div R5, R2, R4” 
			-- Mdatain_tb <= x"72920000";	-- opcode for “mul R5, R2, R4” 
			-- Mdatain_tb <= x"3A920000";	-- opcode for “ror R5, R2, R4” 
			-- Mdatain_tb <= x"42920000";	-- opcode for “rol R5, R2, R4”
			-- Mdatain_tb <= x"3A920000";	-- opcode for “ror R5, R2, R4” 
			-- Mdatain_tb <= x"32920000";	-- opcode for “shl R5, R2, R4” 
			-- Mdatain_tb <= x"2A920000";	-- opcode for “shr R5, R2, R4” 
		when T2 =>
			MDRRead_tb <= '0';
			Mdatain_tb <= (others => '0');
			encoderIn_tb <= (21 => '1', others => '0');	-- MDR encoder input
			RegEnable_tb <= (19 => '1', others => '0');	-- IR load_en
		when T3 =>
			encoderIn_tb <= (2 => '1', others => '0');	-- R2 encoder input
			RegEnable_tb <= (22 => '1', others => '0');	-- RY load_en
		when T4 =>
			encoderIn_tb <= (4 => '1', others => '0');	-- R4 encoder input
			aluOp <= "00111";	-- and
			-- aluOp_tb <= "01010";	-- or
			-- aluOp_tb <= "00011";	-- add
			-- aluOp_tb <= "00100";	-- sub
			-- aluOp_tb <= "01111";	-- div
			-- aluOp_tb <= "01110";	-- mul
			-- aluOp_tb <= "00111";	-- ror
			-- aluOp_tb <= "01000";	-- rol
			-- aluOp_tb <= "00111";	-- ror
			-- aluOp_tb <= "00110";	-- shl
			-- aluOp_tb <= "00101";	-- shr
			RegEnable_tb <= (23 => '1', others => '0');	-- RZ load_en
		when T5 =>
			encoderIn_tb <= (19 => '1', others => '0');	-- Zlow encoder
			RegEnable_tb <= (5 => '1', 17=>'1', others => '0');	-- R5, LO load_en
		when T6 =>
			encoderIn_tb <= (18 => '1', others => '0');	-- Zhigh encoder
			RegEnable_tb <= (16 => '1', others=>'0');	-- HI load_en
		when others =>
	end case;
end process;
end architecture;