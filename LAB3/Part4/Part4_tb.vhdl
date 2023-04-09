LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part4_tb IS
END Part4_tb;

ARCHITECTURE test OF Part4_tb IS

	COMPONENT Part4 IS
		PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		HEX0, HEX1, HEX2, HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;
	
	--Init signals
	SIGNAL switches : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL h0, h1, h2, h3 : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN
	uut: Part4 PORT MAP(
	SW => switches,
	HEX0 => h0,
	HEX1 => h1, 
	HEX2 => h2,
	HEX3 => h3
	);

PROCESS
BEGIN
	
--Calculus given as an example
	switches(7 DOWNTO 0) <= "10111100";
	--Expected S = 1 0000 1 00
	wait for 10 ns;
	switches(7 DOWNTO 0) <= "10001000";
	wait for 10 ns;
	wait;

END PROCESS;	
END test;