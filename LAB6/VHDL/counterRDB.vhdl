LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- This counter is a full adaptation of LAB4/Part3
-- https://github.com/s318137/DSE_group20/blob/main/LAB4/Part3/part3.vhd#L3

-- The counter uses signed numbers

ENTITY counterRDB IS
	PORT (
		CLK, CsB, WrB : IN std_logic;
		CNTB : BUFFER unsigned(9 DOWNTO 0) -- CouNTB
	);
END counterRDB;

ARCHITECTURE behavior OF counterRDB IS
	
	BEGIN
		PROCESS (CLK, WrB)
			BEGIN

				IF (WrB = '1') THEN --When WrB is activated, then no counting
					IF (CLK'event AND CLK = '1') THEN 
						IF ((CsB = '1') AND (WrB = '1')) THEN
							CNTB <= CNTB + 1;
						END IF;
					END IF;
				ELSE
					CNTB <= (others => '0');
				END IF;

		END PROCESS;
		
END behavior;