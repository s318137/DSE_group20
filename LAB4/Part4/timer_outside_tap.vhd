LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity timer_outside_tap IS
	PORT (
		clk, en, rst : IN std_logic;
		ref : IN unsigned(31 DOWNTO 0);
		display_out : OUT std_logic_vector(0 TO 6)
	);
END timer_outside_tap;

architecture structure of timer_outside_tap IS

	COMPONENT hex_decoder IS
		PORT (
			input : IN std_logic_vector(3 DOWNTO 0);
			output : OUT std_logic_vector(0 TO 6)
			);
	END COMPONENT;

	COMPONENT comparator_4b IS
		PORT (
			input, ref : IN unsigned(3 DOWNTO 0);
			output : OUT std_logic
		);
	END COMPONENT;

	COMPONENT counter_4b IS
		PORT (
			clk, en, rst : IN std_logic;
			output : BUFFER unsigned(3 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT pulse_outside_tap IS
		PORT (
			clk, en, rst : IN std_logic;
			pulse_out : OUT std_logic;
			ref : IN unsigned(31 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL counter_rst,pulse_out,comp_out : std_logic;
	SIGNAL counter_out : unsigned(3 DOWNTO 0);

	BEGIN
		pulse : pulse_outside_tap PORT MAP(clk, en, rst, pulse_out, ref);
		counter : counter_4b PORT MAP(clk, pulse_out, counter_rst, counter_out);
		counter_rst <= NOT(comp_out) AND rst;
		comp : comparator_4b PORT MAP(counter_out, "1010", comp_out);
		decoder : hex_decoder PORT MAP(std_logic_vector(counter_out), display_out);

END structure;