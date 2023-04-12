LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part4 IS
	PORT (
		sw : IN std_logic_vector(9 DOWNTO 0);
		CLOCK_50 : IN std_logic;
		hex0 : OUT std_logic_vector(0 TO 6)
	);
END part4;

ARCHITECTURE structure OF part4 IS

	COMPONENT timer_outside_tap IS
		PORT (
			clk, en, rst : IN std_logic;
			ref : IN unsigned(31 DOWNTO 0);
			display_out : OUT std_logic_vector(0 TO 6)
		);
	END COMPONENT;

	BEGIN --sw 0 is reset signal, active low
		timer : timer_outside_tap PORT MAP (clock_50, '1', sw(0), x"02FAF07F", hex0);

end structure;