LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part2_1 IS
	PORT (
		clk, rst, en : IN std_logic;
		output : BUFFER std_logic_vector(15 DOWNTO 0);
		tap_out : OUT std_logic
	);
END part2_1;

ARCHITECTURE structure OF part2_1 IS

	COMPONENT counter_4b_struct IS
		PORT (
			rst, clk, en: IN STD_LOGIC; 
			output : OUT std_logic_vector(3 DOWNTO 0);
			tap_out : OUT std_logic
		);
	END COMPONENT;

	SIGNAL tap1, tap2, tap3 : std_logic;
	SIGNAL IN2, IN3, IN4 : std_logic;

	BEGIN
		IN2 <= tap1 AND output(3);
		IN3 <= tap2 AND output(7);
		IN4 <= tap3 AND output(11);
		count1 : counter_4b_struct PORT MAP (rst,clk,en,output(3 DOWNTO 0),tap1);
		count2 : counter_4b_struct PORT MAP (rst,clk,IN2,output(7 DOWNTO 4),tap2);
		count3 : counter_4b_struct PORT MAP (rst,clk,IN3,output(11 DOWNTO 8),tap3);
		count4 : counter_4b_struct PORT MAP (rst,clk,IN4,output(15 DOWNTO 12),tap_out);

END structure;