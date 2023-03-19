LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shifter IS
	PORT ( input : IN STD_LOGIC_VECTOR(14 downto 0);
		sel: IN STD_LOGIC_VECTOR(2 downto 0);
		output : OUT STD_LOGIC_VECTOR(14 downto 0));
END shifter;

ARCHITECTURE Behavior OF shifter IS
. . . code not shown
END Behavior;
