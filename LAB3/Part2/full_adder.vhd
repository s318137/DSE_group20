LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY full_adder IS
	PORT(
		A, B, Ci : IN STD_LOGIC;
		Co, S : INOUT STD_LOGIC
	     );
END full_adder;

ARCHITECTURE adding OF full_adder IS
SIGNAL S_buff, Co_buff : STD_LOGIC;
BEGIN
	Co_buff <= '1' WHEN ((B='1') AND (A='1')) or ((Ci='1') and (A='1')) or ((Ci='1') and (B='1')) ELSE '0';
	S_buff <= '1' WHEN (((Co='1') XOR (B='1')) AND (A='1')) ELSE '0';

	Co <= Co_buff;
	S <= S_buff;
END adding;
