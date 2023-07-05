LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY hello_part IS
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0); --defined to read when needed
		C0, C1, C2 : INOUT STD_LOGIC;
		HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6));
	END hello_part;
	
ARCHITECTURE display OF hello_part IS
BEGIN
	C0 <= SW(0);
	C1 <= SW(1);
	C2 <= SW(2);
	HEX0 <= "1111110" WHEN (C1 = '1') AND (C0 = '1') ELSE -- O displayed
			"0001110" WHEN (C1 = '1') AND (C0 = '0') ELSE -- L displayed
			"1001111" WHEN (C1 = '0') AND (C0 = '1') ELSE -- E displayed
			"0110111"; -- H displayed by default
END display;