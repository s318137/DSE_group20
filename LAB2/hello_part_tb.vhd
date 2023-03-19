LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY hello_part_tb IS
END hello_part_tb;

ARCHITECTURE display_test OF hello_part_tb IS

	COMPONENT hello_part
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0); --defined to read when needed
		C0, C1, C2 : INOUT STD_LOGIC;
		HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;
	
	--Init
	--Inputs needed
	SIGNAL SW : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	SIGNAL C0 : STD_LOGIC := '0';
	SIGNAL C2 : STD_LOGIC := '0';
	SIGNAL C1 : STD_LOGIC := '0';
	-- Outputs received
	SIGNAL HEX0 : STD_LOGIC_VECTOR(0 TO 6) := "0000000";
	
BEGIN
	uut : hello_part PORT MAP(
		SW => SW,
        C0 => C0,
        C1 => C1,
        C2 => C2,
        HEX0 => HEX0
		);

PROCESS
BEGIN
	--H test (also initial test)
	wait for 100 ns;
	
	-- 0 test
	SW(0) <= '1';
	SW(1) <= '1';
	wait for 100 ns;
	
	-- L test
	SW(0) <= '0';
	SW(1) <= '1';
	wait for 100 ns;
	
	-- E test
	SW(0) <= '1';
	SW(1) <= '0';
	wait for 100 ns;
	wait;

END PROCESS;
END display_test;
