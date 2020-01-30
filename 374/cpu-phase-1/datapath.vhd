LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
USE work.my_components.ALL;
ENTITY datapath IS 
	PORT
	(
		clear :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC;
		R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in	:  IN  STD_LOGIC;
		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out	:	IN STD_LOGIC;
		HIin, HIout :  IN  STD_LOGIC;
		LOin, LOout :  IN  STD_LOGIC;
		Zlowin, Zlowout :  IN  STD_LOGIC;
		Zhighin, Zhighout :  IN  STD_LOGIC;
		MDRin, MDRout :  IN  STD_LOGIC; 
		PCin ,PCout :  IN  STD_LOGIC;
		InPortin, InPortout :  IN  STD_LOGIC;
		Cin, Cout :  IN  STD_LOGIC;
		MDRreadin :  IN  STD_LOGIC;
		Yin :  IN  STD_LOGIC;
		OutPortin :  IN  STD_LOGIC;
		MARin :  IN  STD_LOGIC;
		IRin :  IN  STD_LOGIC;
		Mdatain :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END datapath;

ARCHITECTURE behavioral OF datapath IS 
-- bus mux signals
SIGNAL	BusMuxIn_HI :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	BusMuxIn_InPort :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	BusMuxIn_LO :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	BusMuxIn_MDR :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	BusMuxIn_PC :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	BusMuxIn_Z_high, BusMuxIn_Z_low :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	C_sign_extended :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	BusMuxOut :  STD_LOGIC_VECTOR(31 DOWNTO 0);
-- bus decoder signals
SIGNAL	out_control_signals :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	control_signal_decode :  STD_LOGIC_VECTOR(4 DOWNTO 0);
-- i/o signals
SIGNAL	IO_to_InPort :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	OutPort_to_IO :  STD_LOGIC_VECTOR(31 DOWNTO 0);
-- IR register signals
SIGNAL	IR_data_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	MAR_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);


-- ALU registers
SIGNAL	Y_data_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
-- bus decoder instantiation
b2v_BusDecoder : decoder_32to5 PORT MAP(out_control_signals, control_signal_decode);
-- bus bux
b2v_BusMux : mux_32to1 PORT MAP(
	d00 => BusMuxIn_R0, d01 => BusMuxIn_R1, d02 => BusMuxIn_R2, d03 => BusMuxIn_R3, d04 => BusMuxIn_R4, d05 => BusMuxIn_R5, d06 => BusMuxIn_R6, d07 => BusMuxIn_R7,
	d08 => BusMuxIn_R8, d09 => BusMuxIn_R9, d10 => BusMuxIn_R10, d11 => BusMuxIn_R11, d12 => BusMuxIn_R12, d13 => BusMuxIn_R13, d14 => BusMuxIn_R14, d15 => BusMuxIn_R15,
	d16 => BusMuxIn_HI, d17 => BusMuxIn_LO, 
	d18 => BusMuxIn_Z_high, d19 => BusMuxIn_Z_low,
	d20 => BusMuxIn_PC,
	d21 => BusMuxIn_MDR,
	d22 => BusMuxIn_InPort,
	d23 => C_sign_extended,
	s => control_signal_decode,
	q => BusMuxOut
);

-- processor registers
b2v_R0 : register32 PORT MAP(clr => clear, clk => clock, en => R0in, d => BusMuxOut, q => BusMuxIn_R0);
b2v_R1 : register32 PORT MAP(clr => clear, clk => clock, en => R1in, d => BusMuxOut, q => BusMuxIn_R1);
b2v_R2 : register32 PORT MAP(clr => clear, clk => clock, en => R2in, d => BusMuxOut, q => BusMuxIn_R2);
b2v_R3 : register32 PORT MAP(clr => clear, clk => clock, en => R3in, d => BusMuxOut, q => BusMuxIn_R3);
b2v_R4 : register32 PORT MAP(clr => clear, clk => clock, en => R4in, d => BusMuxOut, q => BusMuxIn_R4);
b2v_R5 : register32 PORT MAP(clr => clear, clk => clock, en => R5in, d => BusMuxOut, q => BusMuxIn_R5);
b2v_R6 : register32 PORT MAP(clr => clear, clk => clock, en => R6in, d => BusMuxOut, q => BusMuxIn_R6);
b2v_R7 : register32 PORT MAP(clr => clear, clk => clock, en => R7in, d => BusMuxOut, q => BusMuxIn_R7);
b2v_R8 : register32 PORT MAP(clr => clear, clk => clock, en => R8in, d => BusMuxOut, q => BusMuxIn_R8);
b2v_R9 : register32 PORT MAP(clr => clear, clk => clock, en => R9in, d => BusMuxOut, q => BusMuxIn_R9);
b2v_R10 : register32 PORT MAP(clr => clear, clk => clock, en => R10in, d => BusMuxOut, q => BusMuxIn_R10);
b2v_R11 : register32 PORT MAP(clr => clear, clk => clock, en => R11in, d => BusMuxOut, q => BusMuxIn_R11);
b2v_R12 : register32 PORT MAP(clr => clear, clk => clock, en => R12in, d => BusMuxOut, q => BusMuxIn_R12);
b2v_R13 : register32 PORT MAP(clr => clear, clk => clock, en => R13in, d => BusMuxOut, q => BusMuxIn_R13);
b2v_R14 : register32 PORT MAP(clr => clear, clk => clock, en => R14in, d => BusMuxOut, q => BusMuxIn_R14);
b2v_R15 : register32 PORT MAP(clr => clear, clk => clock, en => R15in, d => BusMuxOut, q => BusMuxIn_R15);

-- alu
b2v_Y : register32 PORT MAP(clr => clear, clk => clock, en => Yin, d => BusMuxOut);
b2v_Z_high : register32 PORT MAP(clr => clear, clk => clock, en => Zhighin, q => BusMuxIn_Z_high);
b2v_Z_low : register32 PORT MAP(clr => clear, clk => clock, en => Zlowin, q => BusMuxIn_Z_low);
		 
-- PC/IR register
b2v_PC : register32 PORT MAP(clr => clear, clk => clock, en => PCin, d => BusMuxOut, q => BusMuxIn_PC);
b2v_IR : register32 PORT MAP(clr => clear, clk => clock, en => IRin, d => BusMuxOut);

-- memory registers
b2v_MAR : register32 PORT MAP(clr => clear, clk => clock, en => MARin, d => BusMuxOut);
b2v_MDR : mem_reg PORT MAP(clr => clear, clk => clock, en => MDRin, read_in => MDRreadin, bus_data => BusMuxOut, m_data => Mdatain, q => BusMuxIn_MDR);

-- io registers
b2v_InPort : register32 PORT MAP(clr => clear, clk => clock, en => InPortin, q => BusMuxIn_InPort);
b2v_OutPort : register32 PORT MAP(clr => clear, clk => clock, en => OutPortin, d => BusMuxOut);

-- HI/LO register
b2v_LO : register32 PORT MAP(clr => clear, clk => clock, en => LOin, d => BusMuxOut, q => BusMuxIn_LO);
b2v_HI : register32 PORT MAP(clr => clear, clk => clock, en => HIin, d => BusMuxOut, q => BusMuxIn_HI);

-- other registers
b2v_C : register32 PORT MAP(clr => clear, clk => clock, en => Cin, d => BusMuxOut, q => C_sign_extended);

-- assign control signals to the decoder input
out_control_signals(0) <= R0out;
out_control_signals(1) <= R1out;
out_control_signals(2) <= R2out;
out_control_signals(3) <= R3out;
out_control_signals(4) <= R4out;
out_control_signals(5) <= R5out;
out_control_signals(6) <= R6out;
out_control_signals(7) <= R7out;
out_control_signals(8) <= R8out;
out_control_signals(9) <= R9out;
out_control_signals(10) <= R10out;
out_control_signals(11) <= R11out;
out_control_signals(12) <= R12out;
out_control_signals(13) <= R13out;
out_control_signals(14) <= R14out;
out_control_signals(15) <= R15out;
out_control_signals(16) <= HIout;
out_control_signals(17) <= LOout;
out_control_signals(18) <= Zhighout;
out_control_signals(19) <= Zlowout;
out_control_signals(20) <= PCout;
out_control_signals(21) <= MDRout;
out_control_signals(22) <= InPortout;
out_control_signals(23) <= Cout;
END behavioral;