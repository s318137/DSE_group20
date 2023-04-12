LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY comparator_32b IS
	PORT (
		input, ref : IN unsigned(31 DOWNTO 0);
		output : OUT std_logic
	);
END comparator_32b;

ARCHITECTURE behavior OF comparator_32b IS

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