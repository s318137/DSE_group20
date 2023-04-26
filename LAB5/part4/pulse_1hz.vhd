LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY pulse_1hz IS
	PORT (
		clk, s_rst: IN std_logic;
		pulse_out: OUT std_logic
	);
END pulse_1hz;

ARCHITECTURE behavior OF pulse_1hz IS

	SIGNAL count : unsigned(27 DOWNTO 0);
	SIGNAL int_rst : std_logic;

	BEGIN

		pulse_out <= int_rst;

		--as the counter approaces the value it resets in the next clock rise
		PROCESS (count)
			BEGIN

				IF (count = x"2FAF07F") THEN
					int_rst <= '1';
				ELSE
					int_rst <= '0';
				END IF;

		END PROCESS;

		--counter
		PROCESS (clk)
			BEGIN
				
				IF (clk'event AND clk = '1') THEN
					IF (s_rst = '1' AND int_rst = '0') THEN
						count <= count + 1;
					ELSE
						count <= (others => '0');
					END IF;
				END IF;

		END PROCESS;

END behavior;