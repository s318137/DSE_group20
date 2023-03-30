LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY full_adder IS
	PORT(
		A, B, Ci : IN STD_LOGIC;
		Co, S : OUT STD_LOGIC
	     );
END full_adder;

ARCHITECTURE adding OF full_adder IS
BEGIN
	S<= A XOR B XOR Ci;
	Co <= (A AND B) OR (Ci AND A) OR (Ci AND B);
END adding;
