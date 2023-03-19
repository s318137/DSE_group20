LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_3bit_5to1 IS
	PORT ( sel0,sel1 : in std_logic;
		a,b,c,d : in std_logic_vector(14 downto 0);
		y : out std_logic_vector(14 downto 0));
END mux_3bit_5to1;

ARCHITECTURE Behavior OF mux_3bit_5to1 IS
BEGIN
	y <= d WHEN (sel1 = '1') AND (sel0 = '1') ELSE
		 c WHEN (sel1 = '1') AND (sel0 = '0') ELSE 
		 b WHEN (sel1 = '0') AND (sel0 = '1') ELSE 
		 a; -- H displayed by default
END Behavior;

