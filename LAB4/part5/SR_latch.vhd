LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY SR_latch IS
	PORT (
		s, r, rst : IN std_logic;
		output : OUT std_logic
	);
END SR_latch;

ARCHITECTURE behavior OF SR_latch IS

	BEGIN
		PROCESS (s, r, rst)
			BEGIN

				IF (rst = '1') THEN
					IF (s = '1') THEN
						output <= '1';
					ELSIF (r = '1') THEN
						output <= '0';
					END IF;
				ELSE 
					output <= '0';
				END IF;

		END PROCESS;

END behavior;