LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY counter_4b IS
	PORT (
		clk,en,rst : IN std_logic;
		output : BUFFER unsigned(3 DOWNTO 0)
	);
END counter_4b;

ARCHITECTURE behavior OF counter_4b IS
	
	BEGIN
		PROCESS (clk)
			BEGIN

			IF (clk'event AND clk = '1') THEN
				IF (en = '1' AND rst = '1') THEN
					output <= output + 1;
				ELSIF (rst = '0') THEN
					output <= x"0";
				END IF;
			END IF;

		END PROCESS;
END behavior;