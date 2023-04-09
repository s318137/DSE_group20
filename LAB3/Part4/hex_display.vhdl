LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY hex_display IS
	PORT(
		InValue : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END hex_display;

ARCHITECTURE disp OF hex_display IS

	SIGNAL HEX_buff : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";

BEGIN 
	
	HEX_buff <= "0000001" WHEN (InValue = "0000") ELSE
				"1001111" WHEN (InValue = "0001") ELSE
				"0010010" WHEN (InValue = "0010") ELSE
				"1001100" WHEN (InValue = "0011") ELSE 
				
				"1001100" WHEN (InValue = "0100") ELSE
				"0100100" WHEN (InValue = "0101") ELSE
				"0100000" WHEN (InValue = "0110") ELSE
				"0001111" WHEN (InValue = "0111") ELSE
				
				
				"0000000" WHEN (InValue = "1000") ELSE
				"0000100" WHEN (InValue = "1001") ELSE
				"0001000" WHEN (InValue = "1010") ELSE
				"1100000" WHEN (InValue = "1011") ELSE
				
				
				"1110010" WHEN (InValue = "1100") ELSE
				"1000010" WHEN (InValue = "1101") ELSE
				"0110000" WHEN (InValue = "1110") ELSE
				"0111000" WHEN (InValue = "1111");
				

HEX0 <= HEX_buff;				

END disp;