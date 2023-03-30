LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--Entirely the same RCA, but using STD_LOGIC_VECTOR instead of SIGNED

ENTITY RCA_4bit_p4 IS
	PORT(
		A_reg, B_reg : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	     );
END RCA_4bit_p4;

ARCHITECTURE rca OF RCA_4bit_p4 IS

CONSTANT ONE : STD_LOGIC_VECTOR(A_reg'RANGE) := (0 => '1', others => '0');

COMPONENT full_adder IS
	PORT(
		A, B, Ci : IN STD_LOGIC;
		Co, S : OUT STD_LOGIC
	     );
END COMPONENT;

SIGNAL S_buff : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL C1, C2, C3 : STD_LOGIC;
SIGNAL A_comp : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL B_comp : STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN

A_comp <= A_reg;
B_comp <= B_reg;

fa_0 : full_adder PORT MAP (A => A_comp(0), B => B_comp(0), Ci => Ci_in, Co => C1, S => S_buff(0));

fa_1 : full_adder PORT MAP (A => A_comp(1), B => B_comp(1), Ci => C1, Co => C2, S => S_buff(1));

fa_2 : full_adder PORT MAP (A => A_comp(2), B => B_comp(2), Ci => C2, Co => C3, S => S_buff(2));

fa_3 : full_adder PORT MAP (A => A_comp(3), B => B_comp(3), Ci => C3, Co =>OVERFLOW, S => S_buff(3));



S_reg <= S_buff ; -- NO complementation is done, as STD_LOGIC_VECTOR is used


END rca;
