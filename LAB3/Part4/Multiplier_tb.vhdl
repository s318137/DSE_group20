LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Multiplier_tb IS
END Multiplier_tb;

ARCHITECTURE test OF Multiplier_tb IS

	COMPONENT Multiplier IS
		PORT(
			A_reg, B_reg : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			S_reg : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	     );
	END COMPONENT;
	
	--Init signals
	SIGNAL A : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	SIGNAL S : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	uut: Multiplier PORT MAP(
	A_reg => A,
	B_reg => B,
	S_reg => S
	);

PROCESS
BEGIN
	
--Calculus given as an example
	A <= "1100";
	B <= "1011";
	--Expected S = 1 0000 1 00
	
	wait;

END PROCESS;	
END test;