LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part3_tb IS
END Part3_tb;

ARCHITECTURE test_onehotmachine OF Part3_tb IS

	COMPONENT Part3 IS
		PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
	END COMPONENT;
	
	--Test signals
	
	SIGNAL SW : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	SIGNAL ClockD : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	SIGNAL LED : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	
	BEGIN

		uut: Part3 PORT MAP(
			SW => SW,
			KEY => ClockD,
			LEDR => LED
		);
			
		PROCESS
			BEGIN

				-- Reset to kick off
				SW(0) <= '0';
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				WAIT FOR 1 ps;
				
				-- Series of 0
				
				SW(0) <= '1';
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				WAIT FOR 1 ps;
				
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				WAIT FOR 1 ps;
				
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				WAIT FOR 1 ps;
				
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				WAIT FOR 1 ps;
				
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				-- Overlapping of result + one 0
				
				WAIT FOR 1 ps;
				
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				-- Breaking, to B
				WAIT FOR 1 ps;
				
				SW(1) <= '1';
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				WAIT FOR 1 ps;
				
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				WAIT FOR 1 ps;
				
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				WAIT FOR 1 ps;
				
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				WAIT FOR 1 ps;
				
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';
				
				-- Overlapping of result + one 1
				
				WAIT FOR 1 ps;
				
				WAIT FOR 8 ns;
				ClockD(1) <= '1';
				WAIT FOR 2 ns;
				ClockD(1) <= '0';

				WAIT;

		END PROCESS;
		
END test_onehotmachine;