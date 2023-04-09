LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part3_CSA_16bit_tb IS
END Part3_CSA_16bit_tb;

ARCHITECTURE test OF Part3_CSA_16bit_tb IS

	COMPONENT Part3_CSA_16bit IS
		PORT(
		A_16bit, B_16bit : IN SIGNED(15 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		KEY0, KEY1 : IN STD_LOGIC; 
		Co: OUT STD_LOGIC;
		S_16b : OUT SIGNED(15 DOWNTO 0)
		);
	END COMPONENT;
	
	--Init signals
	SIGNAL A : SIGNED(15 DOWNTO 0) := (others => '0');
	SIGNAL B : SIGNED(15 DOWNTO 0) := (others => '0');
	SIGNAL Clock, Resetn : STD_LOGIC;

	SIGNAL S : SIGNED(15 DOWNTO 0);
	SIGNAL Ci : STD_LOGIC := '0';
	SIGNAL C : STD_LOGIC := '0';

BEGIN
	uut: Part3_CSA_16bit PORT MAP(
	A_16bit => A,
	B_16bit => B,
	Ci_in => Ci,
	KEY0 => Resetn,
	KEY1 => Clock,
	Co => C,
	S_16b => S
	);

PROCESS
BEGIN
	
	A <= (0 => '1', others => '0');
	B <= (1 => '1', others => '0');
	Clock <= '1';
	wait for 5 ns; --wait time for regisry update
	Clock <= '0'; 
	wait for 45 ns; 
	
	--Neg + Neg
	A <= (15 => '1', 0 => '1', others => '0');
	B <= (15 => '1', 1 => '1', others => '0');
	Clock <= '1';
	wait for 5 ns; --wait time for regisry update
	Clock <= '0'; 
	wait for 45 ns;
	
	wait;
	
	wait;

END PROCESS;	
END test;