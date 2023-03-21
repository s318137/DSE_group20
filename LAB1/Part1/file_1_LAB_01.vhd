LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- Simple module that connects
-- the SW switches to the LEDR lights

ENTITY file_1_LAB_01 IS
		PORT ( sw : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
				 LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)); -- red LEDs
END file_1_LAB_01;

ARCHITECTURE Behavior OF file_1_LAB_01 IS
BEGIN
	LEDR <= sw;
END Behavior;