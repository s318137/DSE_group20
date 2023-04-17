LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity part5 IS 
	PORT (
		clock_50 : IN std_logic;
		ledr : OUT std_logic_vector(9 DOWNTO 0);
		sw : IN std_logic_vector(9 DOWNTO 0);
		key : IN std_logic_vector(3 DOWNTO 0);
		hex0,hex1,hex2,hex3 : OUT std_logic_vector(0 TO 6)
	);
END part5;

ARCHITECTURE structure OF part5 IS

	COMPONENT timer_outside_tap IS
		PORT (
			clk, en, rst : IN std_logic;
			ref : IN unsigned(31 DOWNTO 0);
			display_out : OUT std_logic_vector(0 TO 6)
		);
	END COMPONENT;

	COMPONENT SR_latch IS
		PORT (
			s, r, rst : IN std_logic;
			output : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT pulse_outside_tap IS
		PORT (
			clk, en, rst : IN std_logic;
			pulse_out : OUT std_logic;
			ref : IN unsigned(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT comparator_32b IS 
		PORT (
			input, ref : IN unsigned(31 DOWNTO 0);
			output : OUT std_logic
		);
	END COMPONENT;

	COMPONENT counter_32b IS
		PORT (
			rst, clk, en: IN STD_LOGIC; 
			output : BUFFER unsigned(31 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL timer_en, pulse_out, pulse_en, comparator_out, sr_out, sr_in : std_logic;
	SIGNAL counter_out, comparator_ref : unsigned(31 DOWNTO 0);

	BEGIN

		comparator_ref(31 DOWNTO 8) <= (OTHERS => '0');
		comparator_ref(7 DOWNTO 0) <= unsigned(sw(7 DOWNTO 0));

		sr_in <= NOT(key(3));

		timer1 : timer_outside_tap PORT MAP (clock_50, timer_en, key(0), x"0000C34F", hex0);
		timer2 : timer_outside_tap PORT MAP (clock_50, timer_en, key(0), x"0007A11F", hex1);
		timer3 : timer_outside_tap PORT MAP (clock_50, timer_en, key(0), x"004C4B3F", hex2);
		timer4 : timer_outside_tap PORT MAP (clock_50, timer_en, key(0), x"02FAF07F", hex3);

		pulse1 : pulse_outside_tap PORT MAP (clock_50, pulse_en, key(0),pulse_out, x"0000C34F");

		counter1 : counter_32b PORT MAP (key(0), clock_50, pulse_out, counter_out);
		
		comparator1 : comparator_32b PORT MAP (counter_out, comparator_ref, comparator_out);
		
		latch : SR_latch PORT MAP (sr_in, '0', key(0), sr_out);
		
		timer_en <= NOT(sr_out) AND comparator_out;
		
		pulse_en <= NOT(comparator_out);
		
		ledr(0) <= timer_en;

END structure;