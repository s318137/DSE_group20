--This is code of hello_part, renamed.
--Table for characters c2 c1 c0 = 'character' = 'binary rep'
-- 0 0 0 => H = "1001000"
-- 0 0 1 => E = "0110000"
-- 0 1 0 => L = "1110001"
-- 0 1 1 => O = "0000001" 
-- 1 0 0 => C = "0110001"
-- 1 0 1 => P = "0011000"
-- 1 1 0 => F = "0111000"


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY char_7seg IS
	port (c : in std_logic_vector(2 downto 0);
		display : out std_logic_vector(0 to 6)
		);
END char_7seg;

ARCHITECTURE Behavior OF char_7seg IS
BEGIN
	display <= "1001000" WHEN (c = "000") ELSE
	"0110000" WHEN (c = "001") ELSE
	"1110001" WHEN (c = "010") ELSE
	"0000001" WHEN (c = "011") ELSE
	"0110001" WHEN (c = "100") ELSE
	"0011000" WHEN (c = "101") ELSE
	"0111000" WHEN (c = "110");
	
END Behavior;
