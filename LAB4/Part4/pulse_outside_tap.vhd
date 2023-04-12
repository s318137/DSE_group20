LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY pulse_outside_tap IS
	PORT (
		clk, en, rst : IN std_logic;
		pulse_out : OUT std_logic;
		ref : IN unsigned(31 DOWNTO 0)
	);
END pulse_outside_tap;

ARCHITECTURE structure OF pulse_outside_tap IS

	COMPONENT counter_32b IS
		PORT (
			rst, clk, en: IN STD_LOGIC; 
			output : BUFFER unsigned(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT comparator_32b IS
		PORT (
			input, ref : IN unsigned(31 DOWNTO 0);
			output : OUT std_logic
		);
	END COMPONENT;

	SIGNAL counter_rst,comp_out : std_logic;
	SIGNAL counter_out : unsigned(31 DOWNTO 0);

	BEGIN
		counter : counter_32b PORT MAP (counter_rst, clk, en, counter_out);
		comparator : comparator_32b PORT MAP(counter_out, ref, comp_out);
		counter_rst <= NOT(comp_out) AND rst;
		pulse_out <= comp_out;

END structure;