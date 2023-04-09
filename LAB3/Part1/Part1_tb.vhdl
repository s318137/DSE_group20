LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part1_tb IS
END Part1_tb;

ARCHITECTURE test OF Part1_tb IS

	COMPONENT Part1 IS
		PORT( 
			SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			KEY0, KEY1 : IN STD_LOGIC; 
			HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6);
			LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
	END COMPONENT;
	
	--Init signals
	--Input signals
	SIGNAL S_test : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
	SIGNAL Clock : STD_LOGIC := '0';
	SIGNAL H1, H2, H3, H4, H5, H6 : STD_LOGIC_VECTOR(0 TO 6);
	SIGNAL Resetn : STD_LOGIC;
	SIGNAL led : STD_LOGIC_VECTOR(9 DOWNTO 0); 
	

BEGIN
	uut: Part1 PORT MAP(
	SW => S_test,
	KEY0 => Resetn, 
	KEY1 => Clock,
	HEX0 => H1, 
	HEX1 => H2, 
	HEX2 => H3, 
	HEX3 => H4,
	HEX4 => H5, 
	HEX5 => H6,
	LEDR => led
	);

PROCESS
BEGIN
	
	-- The adder circuit is thorougly tested in RCA_4bit_tb
	-- Here, only the circuit connections are tested.
	
	--Pos+Pos
	S_test(7 DOWNTO 4) <= "0011";
	S_test(3 DOWNTO 0) <= "0001";
	Clock <= '1';
	wait for 1 ns; --wait time for regisry update
	Clock <= '0'; 
	wait for 99 ns; 
	
	--Neg + Neg
	S_test(7 DOWNTO 4) <= "1111";
	S_test(3 DOWNTO 0) <= "1111"; 
	Clock <= '1';
	wait for 1 ns; --wait time for regisry update
	Clock <= '0'; 
	wait for 99 ns;
	
	wait;

END PROCESS;	
END test;