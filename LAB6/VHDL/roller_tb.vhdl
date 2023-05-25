LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY roller_tb IS
END roller_tb;

ARCHITECTURE test OF roller_tb IS

	COMPONENT roller IS
	PORT(
		A, B, C, D : IN SIGNED(7 DOWNTO 0);
		W, X, Y, Z : OUT SIGNED(7 DOWNTO 0)
		);
	END COMPONENT;
	
	--SIGNALS
	
	--Input
	SIGNAL A_test, B_test, C_test, D_test : SIGNED(7 DOWNTO 0);
	
	--Output
	SIGNAL W_test, X_test, Y_test, Z_test : SIGNED(7 DOWNTO 0);
	
BEGIN
	uut: roller PORT MAP(
	A => A_test,
	B => B_test,
	C => C_test, 
	D => D_test,
	W => W_test,
	X => X_test,
	Y => Y_test, 
	Z => Z_test
	);

PROCESS
BEGIN

	-- the role of this test is to assess if the rolling/ shifting are done correctly
	-- In order to test this, the same entry for every input 
	
	-- Test is 4 = 0b00001000
	A_test <= "00001000";
	B_test <= "00001000";
	C_test <= "00001000";
	D_test <= "00001000";
	wait for 20 ns;
	
	-- Test is 1 = 0b00000001
	A_test <= "00000001";
	B_test <= "00000001";
	C_test <= "00000001";
	D_test <= "00000001";
	wait for 20 ns;
	
	-- Test is -1 = 0b1111 1111
	A_test <= "11111111";
	B_test <= "11111111";
	C_test <= "11111111";
	D_test <= "11111111";
	wait for 20 ns;
	
	-- Test is -128 = 0b1000 0000
	A_test <= "10000000";
	B_test <= "10000000";
	C_test <= "10000000";
	D_test <= "10000000";
	wait for 20 ns;
	wait;
	
END PROCESS;
END test;
	