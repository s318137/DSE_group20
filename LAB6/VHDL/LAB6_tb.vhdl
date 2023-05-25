LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- This TB is in that case both a testbench proving the abilities
-- And a development bench destined to create what is expected


ENTITY LAB6_tb IS
END LAB6_tb;

ARCHITECTURE test OF LAB6_tb IS

	COMPONENT LAB6 IS
	PORT(
	START : IN STD_LOGIC;
	DataIN : IN SIGNED(7 DOWNTO 0);
	
	CLK : IN STD_LOGIC;
	DONE : OUT STD_LOGIC;
	DataOUT : OUT SIGNED(7 DOWNTO 0)
	);
	END COMPONENT;

-- Signal inputs
SIGNAL START : STD_LOGIC := '0';
SIGNAL CLK : STD_LOGIC := '0';
SIGNAL DataIN : SIGNED(7 DOWNTO 0) := "00000001"; -- =/= 0, to see effects
-- outputs
SIGNAL DONE : STD_LOGIC;
SIGNAL DataOUT : SIGNED(7 DOWNTO 0);

SIGNAL j : INTEGER := 0;

	
BEGIN

uut : LAB6 PORT MAP(
	START => START,
	DataIN => DataIN,
	CLK => CLK,
	DONE => DONE,
	DataOUT => DataOUT
	);
	
PROCESS
BEGIN
	START <= '1';
	CLK <= '0';
	
	WAIT FOR 2 ns;
	
	CLK <= '1';
	j <= j+1;
	
	WAIT FOR 2 ns;

END PROCESS;
END test;