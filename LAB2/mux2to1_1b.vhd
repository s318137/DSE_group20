LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux2to1_1b IS
	port (a,b,sel : in std_logic;
		y : out std_logic
		);
	END mux2to1_1b;
	
ARCHITECTURE mux OF mux2to1_1b IS
SIGNAL y_buff : STD_LOGIC;
BEGIN
	y_buff <= a WHEN (sel ='0') ELSE b;
	y <= y_buff;
END mux;
