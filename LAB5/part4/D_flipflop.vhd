LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY D_flipflop IS
	PORT (
		d, clk, rst : IN std_logic;
		q : OUT std_logic
	);
END D_flipflop;

ARCHITECTURE behavior OF D_flipflop IS

	BEGIN
		PROCESS (clk) 
			BEGIN

				IF (clk'event AND clk = '1') THEN
					IF (rst = '1') THEN
						q <= d;
					ELSE
						q <= '0';
					END IF;
				END IF;

		END PROCESS;
END behavior;