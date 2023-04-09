LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RCA_16bit IS
	PORT(
		A_reg, B_reg : IN SIGNED(15 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT SIGNED(15 DOWNTO 0)
	     );
END RCA_16bit;

ARCHITECTURE rca OF RCA_16bit IS

CONSTANT ONE : SIGNED(A_reg'RANGE) := (0 => '1', others => '0');

COMPONENT RCA_4bit IS
	PORT(
		A_reg, B_reg : IN SIGNED(3 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT SIGNED(3 DOWNTO 0)
	     );
END COMPONENT;

SIGNAL S_buff : SIGNED(15 DOWNTO 0);
SIGNAL C1, C2, C3 : STD_LOGIC;
SIGNAL A_comp : SIGNED(15 DOWNTO 0);
SIGNAL B_comp : SIGNED(15 DOWNTO 0);


BEGIN

A_comp <= (not(A_reg)+ONE) WHEN ((B_reg(15) = '1') AND (A_reg(15) = '1')) ELSE A_reg; -- sum of complementaries if both negatives
B_comp <= (not(B_reg)+ONE) WHEN ((B_reg(15) = '1') AND (A_reg(15) = '1')) ELSE B_reg; -- sum of complementaries if both negatives

--Complementation if negatives


fa_0 : RCA_4bit PORT MAP (A_reg => A_comp(3 DOWNTO 0), B_reg => B_comp(3 DOWNTO 0), Ci_in => Ci_in, OVERFLOW => C1, S_reg => S_buff(3 DOWNTO 0));

fa_1 : RCA_4bit PORT MAP (A_reg => A_comp(7 DOWNTO 4), B_reg => B_comp(7 DOWNTO 4), Ci_in => C1, OVERFLOW => C2, S_reg => S_buff(7 DOWNTO 4));

fa_2 : RCA_4bit PORT MAP (A_reg => A_comp(11 DOWNTO 8), B_reg => B_comp(11 DOWNTO 8), Ci_in => C2, OVERFLOW => C3, S_reg => S_buff(11 DOWNTO 8));

fa_3 : RCA_4bit PORT MAP (A_reg => A_comp(15 DOWNTO 12), B_reg => B_comp(15 DOWNTO 12), Ci_in => C3, OVERFLOW =>OVERFLOW, S_reg => S_buff(15 DOWNTO 12));



S_reg <= (not(signed(S_buff))+ONE) WHEN (B_reg(15) = '1') AND (A_reg(15) = '1') ELSE signed(S_buff) ; -- complement of the sum if both negatives


END rca;