LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY LAB1_multiplex1 IS
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0); --defined to read when needed
		X, Y : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		S : INOUT STD_LOGIC;
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); --defined to read when needed
		M : out STD_LOGIC_VECTOR(3 DOWNTO 0));
	END LAB1_multiplex1;
	
ARCHITECTURE mult OF LAB1_multiplex1 IS
SIGNAL M_buff : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
S <= SW(8); 
X <= SW(3 DOWNTO 0);
Y <= SW(7 DOWNTO 4);
M_buff <= X WHEN (S='0') ELSE Y;
M <= M_buff;
LEDR(3 DOWNTO 0) <= M_buff;

END mult;