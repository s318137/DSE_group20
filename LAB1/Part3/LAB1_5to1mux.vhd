-- CODE BASED ON LAB1_multiplex1(_tb).vhdl

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY LAB1_5to1mux IS
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0); --defined to read when needed
		X, Y, W, U, V : INOUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		S0, S1, S2 : INOUT STD_LOGIC;
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); --defined to read when needed
		M : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
	END LAB1_5to1mux;

ARCHITECTURE mult_5to1 OF LAB1_5to1mux IS
	SIGNAL M_buff : STD_LOGIC_VECTOR(2 DOWNTO 0); --buffer signal
	BEGIN
	S0 <= SW(8); 
	S1 <= SW(7);
	S2 <= SW(6);
	X <= SW(2 DOWNTO 0);
	Y <= SW(5 DOWNTO 3);
	-- forced values asked
	W <= "101";
	U <= "010";
	V <= "111";
	-- Multiple "when <condition> else" cases to compute the 5 possible combinations
	M_buff <= U WHEN (S0 = '0') AND (S1 = '0') ELSE
		  V WHEN (S0 = '1') AND (S1 = '0') ELSE
		  W WHEN (S0 = '0') AND (S1 = '1') ELSE
		  X WHEN (S0 = '1') AND (S1 = '1') ELSE
		  Y WHEN (S2 = '1'); --Overrides other connections
	-- Deliver of M_buff to values
	M <= M_buff;
	LEDR(2 DOWNTO 0) <= M_buff;

END mult_5to1;