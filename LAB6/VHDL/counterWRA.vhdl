LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- This counter is a full adaptation of LAB4/Part3
-- https://github.com/s318137/DSE_group20/blob/main/LAB4/Part3/part3.vhd#L3

-- The counter uses signed numbers

ENTITY counterWRA IS
	PORT (
		CLK, CsA, WrA : IN std_logic;
		CNTA : BUFFER unsigned(9 DOWNTO 0) -- CouNTA 
	);
END counterWRA;

ARCHITECTURE behavior OF counterWRA IS
	
	BEGIN
		PROCESS (CLK, WrA)
			BEGIN

				IF (WrA = '0') THEN --When WrA is not activated, then no counting
					IF (CLK'event AND CLK = '1') THEN 
						IF ((CsA = '1') AND (WrA = '0')) THEN
							CNTA <= CNTA + 1;
						END IF;
					END IF;
				ELSE
					CNTA <= (others => '0');
				END IF;

		END PROCESS;
		
END behavior;