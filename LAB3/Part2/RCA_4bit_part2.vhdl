LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RCA_4bit_part2 IS
	PORT(
		A_reg, B_reg : IN SIGNED(3 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		ADD_SUB : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT SIGNED(3 DOWNTO 0)
	     );
END RCA_4bit_part2;

ARCHITECTURE rca2 OF RCA_4bit_part2 IS

COMPONENT full_adder IS
	PORT(
		A, B, Ci : IN STD_LOGIC;
		Co, S : OUT STD_LOGIC
	     );
END COMPONENT;

SIGNAL S_buff : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
SIGNAL C_buff : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"; -- 
SIGNAL A_comp : SIGNED(3 DOWNTO 0) := A_reg;
SIGNAL B_comp : SIGNED(3 DOWNTO 0) := B_reg;

BEGIN
PROCESS
BEGIN --PROCESS
--Complementation if negatives
A_comp <= ((-A_comp)+1) WHEN ((B_reg(3) = '1') AND (A_reg(3) = '1')); -- sum of complementaries if both negatives
B_comp <= ((-B_comp)+1) WHEN ((B_reg(3) = '1') AND (A_reg(3) = '1')); -- sum of complementaries if both negatives

B_comp <= ((-B_comp)+1) WHEN (ADD_SUB = '1'); --Complement when asked

fa_0 : full_adder PORT MAP (A => A_comp(0), B => B_comp(0), Ci => Ci_in, Co => C_buff(0), S => S_buff(0));

fa_1 : full_adder PORT MAP (A => A_comp(1), B => B_comp(1), Ci => C_buff(0), Co => C_buff(1), S => S_buff(1));

fa_2 : full_adder PORT MAP (A => A_comp(2), B => B_comp(2), Ci => C_buff(1), Co => C_buff(2), S => S_buff(2));

fa_3 : full_adder PORT MAP (A => A_comp(3), B => B_comp(3), Ci => C_buff(2), Co => C_buff(3), S => S_buff(3));

OVERFLOW <= C_buff(3);

S_reg <= ((-signed(S_buff))+1) WHEN (B_reg(3) = '1') AND (A_reg(3) = '1') ELSE signed(S_buff) ; -- complement of the sum if both negatives

END PROCESS;
END rca2;