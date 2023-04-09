LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY hex_8bit_display IS
	PORT(
		InValue_8bit : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		HEX0, HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END hex_8bit_display;

ARCHITECTURE disp OF hex_8bit_display IS
	
	COMPONENT hex_display IS
		PORT(
		InValue : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;

BEGIN 

	dispA : hex_display PORT MAP (InValue => InValue_8bit(3 DOWNTO 0), HEX0 => HEX0);
	dispB : hex_display PORT MAP (InValue => InValue_8bit(7 DOWNTO 4), HEX0 => HEX1);

END disp;