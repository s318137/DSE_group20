LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity part2_tb is
end part2_tb;

ARCHITECTURE part2_test OF part2_tb IS

	COMPONENT part2
	PORT(SW : in std_logic_vector(9 downto 0);
		HEX0,HEX1,HEX2,HEX3,HEX4 : out std_logic_vector(0 to 6)
		);
	END COMPONENT; 
	
	--init
	SIGNAL SW : STD_LOGIC_VECTOR(9 downto 0) := "0000000000";
	SIGNAL HEX0 : STD_LOGIC_VECTOR(0 TO 6) := "0000000";
	SIGNAL HEX1 : STD_LOGIC_VECTOR(0 TO 6) := "0000000";
	SIGNAL HEX2 : STD_LOGIC_VECTOR(0 TO 6) := "0000000";
	SIGNAL HEX3 : STD_LOGIC_VECTOR(0 TO 6) := "0000000";
	SIGNAL HEX4 : STD_LOGIC_VECTOR(0 TO 6) := "0000000";
	
BEGIN
	uut: part2 PORT MAP(
	SW => SW,
	HEX0 => HEX0,
	HEX1 => HEX1,
	HEX2 => HEX2,
	HEX3 => HEX3,
	HEX4 => HEX4
	);
	
PROCESS
BEGIN
	--Test of choice
	-- HELLO
	SW(1 downto 0) <= "00";
	WAIT FOR 100 ns;
	
	--CEPPO
	SW(1 downto 0) <= "01";
	WAIT FOR 100 ns;
	--CELLO
	SW(1 downto 0) <= "10";
	WAIT FOR 100 ns;
	--FEPPO
	SW(1 downto 0) <= "11";
	WAIT FOR 100 ns;
	
	--SHIFTER TEST
	-- FEPPO is kept
	-- 001 => 1st shift
	SW(4 downto 2) <= "001";
	WAIT FOR 100 ns;
	
	-- 001 => 2nd shift
	SW(4 downto 2) <= "010";
	WAIT FOR 100 ns;
	
	-- 001 => 3rd shift
	SW(4 downto 2) <= "011";
	WAIT FOR 100 ns;
	
	-- 001 => 4th shift
	SW(4 downto 2) <= "100";
	WAIT FOR 100 ns;
	
	-- 001 => no shift
	SW(4 downto 2) <= "001";
	WAIT FOR 100 ns;

END PROCESS;
END part2_test;