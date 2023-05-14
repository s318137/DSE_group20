LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--comp_filter for complete filter
-- This is the component merging every minor component to execute the filtering process

ENTITY comp_filter IS
	PORT(
	
	);
END comp_filter;

--A structural way is prefered to test individually each critical components
ARCHITECTURE structure OF comp_filter IS

	COMPONENT roller IS
	PORT(
		A, B, C, D : IN SIGNED(7 DOWNTO 0);
		W, X, Y, Z : OUT SIGNED(7 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT memFetchA IS
	PORT(
		CLK : IN STD_LOGIC;
		X : IN SIGNED(7 DOWNTO 0);
		START : IN STD_LOGIC;
		RDA : IN STD_LOGIC;
		A_N : OUT SIGNED(7 DOWNTO 0)
	);	
	END COMPONENT;
	
	-- Here lies component mem32
	COMPONENT mem32 IS
	PORT(
	
	);
	END COMPONENT;
	
	COMPONENT adder IS
	PORT(
		A, B, C, D : IN SIGNED(7 DOWNTO 0); --4 8bits inputs
		ADONE : OUT STD_LOGIC; --Adder done, for counter
		AOUT : OUT SIGNED(7 DOWNTO 0) -- Output
		);
	END COMPONENT;
	
	COMPONENT counterOutput IS
	PORT (
		CLK, DONE, START : IN std_logic;
		CNTA : BUFFER unsigned(10 DOWNTO 0); -- CouNTA 
		FDONE : OUT STD_LOGIC
	);
	END COMPONENT;
	
BEGIN




END structure;