LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- This counter is a full adaptation of LAB4/Part3
-- https://github.com/s318137/DSE_group20/blob/main/LAB4/Part3/part3.vhd#L3

-- The counter uses signed numbers

ENTITY counterOutput IS
	PORT (
		CLK, DONE, START : IN std_logic;
		CNTA : BUFFER unsigned(9 DOWNTO 0); -- CouNTA 
		FDONE : OUT STD_LOGIC
	);
END counterOutput;

ARCHITECTURE behavior OF counterOutput IS
	
	--SIGNALS
	SIGNAL FDONE_out : STD_LOGIC := '0';
	
	BEGIN
		PROCESS (CLK, START)
			BEGIN

				IF (START = '0') THEN --When WrA is not activated, then no counting
					IF (CLK'event AND CLK = '1') THEN 
						IF ((DONE = '1') AND (START = '0')) THEN
							IF (CNTA = 1023) THEN
								CNTA <= CNTA; --Won't go further than 1023 (instead of "reseting")
								FDONE_out <= '1';
							ELSE	
								CNTA <= CNTA + 1;
								FDONE_out <= '0';
							END IF;
						END IF;
					END IF;
				ELSE
					CNTA <= (others => '0');
				END IF;

		END PROCESS;
	FDONE <= FDONE_out;
END behavior;