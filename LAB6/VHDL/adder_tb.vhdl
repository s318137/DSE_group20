LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder_tb IS
END adder_tb;

ARCHITECTURE test OF adder_tb IS

	COMPONENT adder IS
	PORT(
		A, B, C, D : IN SIGNED(7 DOWNTO 0); --4 8bits inputs
		ADONE : OUT STD_LOGIC; --Adder done, for counter
		AOUT : OUT SIGNED(7 DOWNTO 0) -- Output
		);
	END COMPONENT;
	
	--signals
	SIGNAL A, B, C, D : SIGNED(7 DOWNTO 0) := (others => '0');
	SIGNAL done : STD_LOGIC;
	SIGNAL OUTPUT : SIGNED(7 DOWNTO 0);
	
BEGIN
	uut: adder PORT MAP(
	A => A,
	B => B,
	C => C, 
	D => D,
	ADONE => done,
	AOUT => OUTPUT
	);
	
PROCESS
BEGIN

	--All positive
	A <= "00000001";
	B <= "00000010";
	C <= "00000100";
	D <= "00001000";
	
	wait for 100 ns;
	
	--All negative
	A <= "10000001";
	B <= "10000001";
	C <= "11111011";
	D <= "10000000";
	
	wait for 100 ns;
	
	--MIXED
	A <= "00000100";
	B <= "00000010";
	C <= "10000001";
	D <= "10000010";
	
	wait for 100 ns;
	
	--Saturated
	A <= "00110100";
	B <= "01100010";
	C <= "10001011";
	D <= "11110000";
	
	wait for 100 ns;
	wait;

END PROCESS;	
END test;