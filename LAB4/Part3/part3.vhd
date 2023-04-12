LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part3 IS
	PORT (
		clk, en, rst : IN std_logic;
		output : BUFFER unsigned(15 DOWNTO 0)
	);
END part3;

ARCHITECTURE behavior OF part3 IS

	BEGIN
		PROCESS (clk, rst)
			BEGIN

				IF (rst = '1' ) THEN
					IF (clk'event AND clk = '1') THEN 
						IF (en = '1') THEN
							output <= output + 1;
						END IF;
					END IF;
				ELSE
					output <= (others => '0');
				END IF;

		END PROCESS;
		
END behavior;