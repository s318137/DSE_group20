LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RCA_4bit IS
	PORT(
		A_reg, B_reg : IN SIGNED(3 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT SIGNED(3 DOWNTO 0)
	     );
END RCA_4bit;

ARCHITECTURE rca OF RCA_4bit IS

CONSTANT ONE : SIGNED(A_reg'RANGE) := (0 => '1', others => '0');

COMPONENT full_adder IS
	PORT(
		A, B, Ci : IN STD_LOGIC;
		Co, S : OUT STD_LOGIC
	     );
END COMPONENT;

SIGNAL S_buff : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL C1, C2, C3 : STD_LOGIC;
SIGNAL A_comp : SIGNED(3 DOWNTO 0);
SIGNAL B_comp : SIGNED(3 DOWNTO 0);


BEGIN

A_comp <= (not(A_reg)+ONE) WHEN ((B_reg(3) = '1') AND (A_reg(3) = '1')) ELSE A_reg; -- sum of complementaries if both negatives
B_comp <= (not(B_reg)+ONE) WHEN ((B_reg(3) = '1') AND (A_reg(3) = '1')) ELSE B_reg; -- sum of complementaries if both negatives

--Complementation if negatives


fa_0 : full_adder PORT MAP (A => A_comp(0), B => B_comp(0), Ci => Ci_in, Co => C1, S => S_buff(0));

fa_1 : full_adder PORT MAP (A => A_comp(1), B => B_comp(1), Ci => C1, Co => C2, S => S_buff(1));

fa_2 : full_adder PORT MAP (A => A_comp(2), B => B_comp(2), Ci => C2, Co => C3, S => S_buff(2));

fa_3 : full_adder PORT MAP (A => A_comp(3), B => B_comp(3), Ci => C3, Co =>OVERFLOW, S => S_buff(3));



S_reg <= (not(signed(S_buff))+ONE) WHEN (B_reg(3) = '1') AND (A_reg(3) = '1') ELSE signed(S_buff) ; -- complement of the sum if both negatives


END rca;
