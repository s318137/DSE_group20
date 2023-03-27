LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY 4bit_RCA IS
	PORT(
		A, B : IN UNSIGNED(3 DOWNTO 0);
		Ci : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S : OUT UNSIGNED(3 DOWNTO 0)
	     );
END 4bit_RCA;

ARCHITECTURE rca OF 4bit_RCA IS
SIGNAL C : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
SIGNAL S_buff : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
BEGIN
PROCESS
BEGIN --PROCESS

f_a0 : full_adder PORT MAP(A=>A(0), B=>B(0), Ci=>Ci,C(0)=>Co , S(0)=>S_buff);
f_a1 : full_adder PORT MAP(A=>A(1), B=>B(1), Ci=>C(0),C(1)=>Co , S(1)=>S_buff);
f_a2 : full_adder PORT MAP(A=>A(2), B=>B(2), Ci=>C(1),C(2)=>Co , S(2)=>S_buff);
f_a3 : full_adder PORT MAP(A=>A(3), B=>B(3), Ci=>C(2),Co=>Co, S(3)=>S_buff);

OVERFLOW <= '1' WHEN (Co='1') ELSE '0';
S <= to_signed(S_buff);

END PROCESS;
END rca;