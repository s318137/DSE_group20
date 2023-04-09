LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY overflow IS
	PORT(
		carry : IN STD_LOGIC;
		OV : OUT UNSIGNED(7 DOWNTO 0)
		);
END overflow;

ARCHITECTURE raising OF overflow IS

BEGIN

OV <= "11111111" WHEN (carry='1') ELSE "00000000";

END raising;