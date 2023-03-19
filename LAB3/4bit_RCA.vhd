LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY full_adder IS
	PORT(
		A, B, Ci : IN STD_LOGIC;
		Co, S : INOUT STD_LOGIC
	     );
END full_adder;
