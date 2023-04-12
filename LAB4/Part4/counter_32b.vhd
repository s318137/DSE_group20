LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY counter_32b IS
	PORT (
		rst, clk, en: IN STD_LOGIC; 
		output : BUFFER unsigned(31 DOWNTO 0)
	);
END counter_32b;

ARCHITECTURE behavior OF counter_32b IS

	BEGIN
		PROCESS (clk)
			BEGIN

			IF (clk'event AND clk = '1') THEN
				IF (en = '1' AND rst = '1') THEN
					output <= output + 1;
				ELSIF (rst = '0') THEN
					output <= x"00000000";
				END IF;
			END IF;

		END PROCESS;

END behavior;