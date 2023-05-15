LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--comp_filter for complete filter
-- This is the component merging every minor component to execute the filtering process

ENTITY comp_filter IS
	PORT(
	CLK : IN STD_LOGIC;
	START : IN STD_LOGIC;

	FiltDone : OUT STD_LOGIC;
	COUNT : OUT UNSIGNED(9 DOWNTO 0);
	FiltOut : OUT SIGNED(7 DOWNTO 0);
	);
END comp_filter;

--A structural way is prefered to test individually each critical component
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
		CNTA : BUFFER unsigned(9 DOWNTO 0); -- CouNTA 
		FDONE : OUT STD_LOGIC
	);
	END COMPONENT;
	
--SIGNALS

--Roller/Shifter centered signals
SIGNAL mem2rolA, mem2rolB, mem2rolC, mem2rolD : SIGNED(7 DOWNTO 0) := (others => '0');
SIGNAL rol2addA, rol2addB, rol2addC, rol2addD : SIGNED(7 DOWNTO 0) := (others => '0');

--Counter signals
SIGNAL Adone : STD_LOGIC := '0';

--Output
SIGNAL AddOut : SIGNED(7 DOWNTO 0);
SIGNAL CountOut : UNSIGNED(9 DOWNTO 0);
SIGNAL FiltDone : STD_LOGIC;

BEGIN
--=>
memFetchA : memFetchA PORT MAP(CLK => CLK, );

mem32 : mem32 PORT MAP(CLK => CLK, );

rolshift : roller PORT MAP(A => mem2rolA,
						   B => mem2rolB,
						   C => mem2rolC,
						   D => mem2rolD,
						   W => rol2addA,
						   X => rol2addB,
						   Y => rol2addC,
						   Z => rol2addD);

adder : adder PORT MAP(A => rol2addA,
					   B => rol2addB,
					   C => rol2addC,
					   D => rol2addD,
					   ADONE => Adone,
					   AOUT => AddOut);

counterOutput : counterOutput PORT MAP(CLK => CLK,
									   DONE => Adone,
									   START => START,
									   CNTA => CountOut,
									   FDONE => FiltDone);


--Output assignment

FiltOut = AddOut;
COUNT = CountOut;
FiltDone = FiltDone;

END structure;