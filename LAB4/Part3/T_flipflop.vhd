LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY T_flipflop IS
	PORT (
		Clk, T ,clr: IN STD_LOGIC;
		Q : BUFFER STD_LOGIC
	);
END T_flipflop;

ARCHITECTURE behavior OF T_flipflop IS

	BEGIN
		PROCESS (clk,clr)
			BEGIN
			
				IF (clr = '1') THEN
					IF (Clk'event AND clk = '1') THEN
						IF (T = '1') THEN
							Q <= NOT(Q);
						END IF;
					END IF;
				ELSE
					Q <= '0';
				END IF;
				
		END PROCESS;

END behavior;
