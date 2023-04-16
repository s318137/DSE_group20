

	LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part2_tb IS
END Part2_tb;

ARCHITECTURE test_onehotmachine OF Part2_tb IS

	COMPONENT Part2 IS
		PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		KEY1 : IN STD_LOGIC; 
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
	END COMPONENT;
	
	--Test signals
	
	SIGNAL SW : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	SIGNAL ClockD : STD_LOGIC := '0';
	SIGNAL LED : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	
BEGIN
	uut: Part2 PORT MAP(
	SW => SW,
	KEY1 => ClockD,
	LEDR => LED
	);
	
PROCESS
BEGIN

	-- Reset to kick off
	SW(0) <= '0';
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	wait for 1 ps;
	
	-- Series of 0
	
	SW(0) <= '1';
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	wait for 1 ps;
	
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	wait for 1 ps;
	
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	wait for 1 ps;
	
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	wait for 1 ps;
	
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	-- Overlapping of result + one 0
	
	wait for 1 ps;
	
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	-- Breaking, to B
	wait for 1 ps;
	
	SW(1) <= '1';
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	wait for 1 ps;
	
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	wait for 1 ps;
	
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	wait for 1 ps;
	
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	wait for 1 ps;
	
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	-- Overlapping of result + one 1
	
	wait for 1 ps;
	
	wait for 8 ns;
	ClockD <= '1';
	wait for 2 ns;
	ClockD <= '0';
	
	
	wait;



END PROCESS;	
END test_onehotmachine;
