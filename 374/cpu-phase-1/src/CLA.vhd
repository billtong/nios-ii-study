library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CLA is

port(

	x   : in  std_logic_vector(15 downto 0);
	y   : in  std_logic_vector(15 downto 0);
   c0  : in  std_logic;
	c16 : out std_logic;
	s : out std_logic_vector(15 downto 0)

);

end entity;

architecture struct of CLA is

signal c01  : std_logic;
signal c02 : std_logic;
signal c03 : std_logic;
signal c4  : std_logic;
signal c11 : std_logic;
signal cs12  : std_logic; -- c2 in the 2nd 4-bit carry lookahead adder
signal c13  : std_logic;
signal c8  : std_logic;
signal c12 : std_logic;
signal c21  : std_logic;
signal c22 : std_logic;
signal c23 : std_logic;
signal c31 : std_logic;
signal c32 : std_logic;
signal c33 : std_logic;
signal G0  : std_logic;
signal G1  : std_logic;
signal G2  : std_logic;
signal G3  : std_logic;
signal P0  : std_logic;
signal P1  : std_logic;
signal P2  : std_logic;
signal P3  : std_logic;
signal p00  : std_logic;
signal p01  : std_logic;
signal p02  : std_logic;
signal p03  : std_logic;
signal p10  : std_logic;
signal p11  : std_logic;
signal p12  : std_logic;
signal p13  : std_logic;
signal p20  : std_logic;
signal p21  : std_logic;
signal p22  : std_logic;
signal p23  : std_logic;
signal p30  : std_logic;
signal p31  : std_logic;
signal p32  : std_logic;
signal p33  : std_logic;
signal g00  : std_logic;
signal g01  : std_logic;
signal g02  : std_logic;
signal g03  : std_logic;
signal g10  : std_logic;
signal g11  : std_logic;
signal g12  : std_logic;
signal g13  : std_logic;
signal g20  : std_logic;
signal g21  : std_logic;
signal g22  : std_logic;
signal g23  : std_logic;
signal g30  : std_logic;
signal g31  : std_logic;
signal g32  : std_logic;
signal g33  : std_logic;
signal Pout  : std_logic;
signal Gout  : std_logic;

begin

p00 <= x(0) xor y(0);
p01 <= x(1) xor y(1);
p02 <= x(2) xor y(2);
p03 <= x(3) xor y(3);
p10 <= x(4) xor y(4);
p11 <= x(5) xor y(5);
p12 <= x(6) xor y(6); 
p13 <= x(7) xor y(7);
p20 <= x(8) xor y(8);
p21 <= x(9) xor y(9);
p22 <= x(10) xor y(10);
p23 <= x(11) xor y(11);
p30 <= x(12) xor y(12);
p31 <= x(13) xor y(13);
p32 <= x(14) xor y(14);
p33 <= x(15) xor y(15);


g00 <= x(0) and y(0);
g01 <= x(1) and y(1);
g02 <= x(2) and y(2);
g03 <= x(3) and y(3);
g10 <= x(4) and y(4);
g11 <= x(5) and y(5);
g12 <= x(6) and y(6); 
g13 <= x(7) and y(7);
g20 <= x(8) and y(8);
g21 <= x(9) and y(9);
g22 <= x(10) and y(10);
g23 <= x(11) and y(11);
g30 <= x(12) and y(12);
g31 <= x(13) and y(13);
g32 <= x(14) and y(14);
g33 <= x(15) and y(15);


P0 <= p00 and p01 and p02 and p03;
P1 <= p10 and p11 and p12 and p13;
P2 <= p20 and p21 and p22 and p23;
P3 <= p30 and p31 and p32 and p33;

G0 <= (g00 and p01 and p02 and p03) or (g01 and p02 and p03) or (g02 and p03) or g03;
G1 <= (g10 and p11 and p12 and p13) or (g11 and p12 and p13) or (g12 and p13) or g13;
G2 <= (g20 and p21 and p22 and p23) or (g21 and p22 and p23) or (g22 and p23) or g23;
G3 <= (g30 and p31 and p32 and p33) or (g31 and p32 and p33) or (g32 and p33) or g33;

-- 1st 4-bit adder

c01 <= (c0 and p00) or g00;
c02 <= (c0 and p00 and p01) or (g00 and p01) or g01;
c03 <= (c0 and p00 and p01 and p02) or (g00 and p01 and p02) or (g01 and p02) or g02;
s(0) <= p00 xor c0;
s(1) <= p01 xor c01;
s(2) <= p02 xor c02;
s(3) <= p03 xor c03;
-- 2nd 4-bit adder
c11 <= (c4 and p10) or g10;
cs12 <= (c4 and p10 and p11) or (g10 and p11) or g11;
c13 <= (c4 and p10 and p11 and p12) or (g10 and p11 and p12) or (g11 and p12) or g12;
s(4) <= p10 xor c4;
s(5) <= p11 xor c11;
s(6) <= p12 xor cs12;
s(7) <= p13 xor c13;
-- 3rd 4-bit adder
c21 <= (c8 and p20) or g20;
c22 <= (c8 and p20 and p21) or (g20 and p21) or g21;
c23 <= (c8 and p20 and p21 and p22) or (g20 and p21 and p22) or (g21 and p22) or g22;
s(8) <= p20 xor c8;
s(9) <= p21 xor c21;
s(10) <= p22 xor c22;
s(11) <= p23 xor c23;
-- 4th 4-bit adder

c31 <= (c12 and p30) or g30;
c32 <= (c12 and p30 and p31) or (g30 and p31) or g31;
c33 <= (c12 and p30 and p31 and p32) or (g30 and p31 and p32) or (g31 and p32) or g32;
s(12) <= p30 xor c12;
s(13) <= p31 xor c31;
s(14) <= p32 xor c32;
s(15) <= p33 xor c33;

-- 2nd-level carry lookahead

c4 <= (c0 and P0) or G0;
c8 <= (c0 and P0 and P1) or (G0 and P1) or G1;
c12 <= (c0 and P0 and P1 and P2) or (G0 and P1 and P2) or (G1 and P2) or G2;

Pout <= P0 and P1 and P2 and P3;
Gout <=(G0 and P1 and P2 and P3) or (G1 and P2 and P3) or (G2 and P3) or G3;
c16 <= Gout or (Pout and c0);
end architecture;