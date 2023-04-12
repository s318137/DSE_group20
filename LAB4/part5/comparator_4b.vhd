LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY comparator_4b IS
	PORT (
		input, ref : IN unsigned(3 DOWNTO 0);
		output : OUT std_logic
	);
END comparator_4b;

ARCHITECTURE behavior OF comparator_4b IS

	BEGIN
		PROCESS (input)
			BEGIN

				IF (input >= ref) THEN 
					output <= '1';
				ELSE 
					output <= '0';
				END IF;

		END PROCESS;

END behavior;