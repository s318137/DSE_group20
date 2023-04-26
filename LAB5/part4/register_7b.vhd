LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_7b IS
	PORT (
		load_in : IN std_logic_vector(0 TO 6);
		output : OUT std_logic_vector(0 TO 6);
		clk, load_en, rst : IN std_logic
	);
END register_7b;

ARCHITECTURE behavior OF register_7b IS

	BEGIN
		PROCESS (clk) 
			BEGIN

				IF (clk'event AND clk = '1') THEN
					IF (rst = '1') THEN
						IF (load_en = '1') THEN
							output <= load_in;
						END IF;
					else
						output <= (others => '1');
					END IF;
				END IF;

		END PROCESS;

END behavior;