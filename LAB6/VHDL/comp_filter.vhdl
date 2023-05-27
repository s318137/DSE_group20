LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--comp_filter for complete filter
-- This is the component merging every minor components to execute the filtering process
-- It is separated in this precise component to stick to the plan given in the assignment

ENTITY comp_filter IS
	PORT(
		CLK : IN STD_LOGIC;
		START : IN STD_LOGIC;
		RDA : IN STD_LOGIC;
		WRA : IN STD_LOGIC;
		CS : IN STD_LOGIC;
		X : IN SIGNED(7 DOWNTO 0);
		Y : OUT SIGNED(7 DOWNTO 0);
		FiltDONE : OUT STD_LOGIC;
		ADDR_A_fetch : OUT UNSIGNED(9 DOWNTO 0);
		COUNT : OUT UNSIGNED(9 DOWNTO 0)
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
		X : IN SIGNED(7 DOWNTO 0);
		START : IN STD_LOGIC;
		RDA : IN STD_LOGIC;
		A_N : OUT SIGNED(7 DOWNTO 0)
	);	
	END COMPONENT;
	
	-- Here lies component mem32
	COMPONENT mem32 IS
	PORT(
		DIN : IN SIGNED(7 DOWNTO 0);
		CS : IN STD_LOGIC;
		COUNT : IN UNSIGNED(9 DOWNTO 0); 
		CLK : IN STD_LOGIC;
		WR : IN STD_LOGIC;
		RD : IN STD_LOGIC;
		FULL : OUT STD_LOGIC;
		ADDR_A : OUT UNSIGNED(9 DOWNTO 0);
		Aout, Bout, Cout, Dout : OUT SIGNED(7 DOWNTO 0)
	);	
	END COMPONENT;
	
	COMPONENT adder IS
	PORT(
		A, B, C, D : IN SIGNED(7 DOWNTO 0); --4 8bits inputs
		ALLOW : IN STD_LOGIC;
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

--memFetch to mem32
SIGNAL AN_val : SIGNED(7 DOWNTO 0);

--Roller/Shifter centered signals
SIGNAL mem2rolA, mem2rolB, mem2rolC, mem2rolD : SIGNED(7 DOWNTO 0) := (others => '0');
SIGNAL rol2addA, rol2addB, rol2addC, rol2addD : SIGNED(7 DOWNTO 0) := (others => '0');

--Adder allow
SIGNAL FULL_ALLOW : STD_LOGIC := '0';

--Counter signals
SIGNAL Adone : STD_LOGIC := '0';


--Output
SIGNAL AddOut : SIGNED(7 DOWNTO 0);
SIGNAL CountOut : UNSIGNED(9 DOWNTO 0);
--SIGNAL FiltDone : STD_LOGIC;	
SIGNAL ADDRA_fetch_out : UNSIGNED(9 DOWNTO 0);


-- Clock
-- Recommended clock is 2 / 4 ns period clock
-- As the mem32 has an hardcoded value for fetching values of 0.5 ns
	
BEGIN
--=>
memFetchA_1 : memFetchA PORT MAP( 
							   X => X,
							   START => START,
							   RDA => RDA,
							   A_N => AN_val);

mem32_1 : mem32 PORT MAP(DIN => AN_val,
					   CS => CS,
					   COUNT => CountOut,
					   CLK => CLK,
					   WR => WRA,
					   RD => RDA,
					   FULL => FULL_ALLOW,
					   ADDR_A => ADDRA_fetch_out,
					   Aout => mem2rolA,
					   Bout => mem2rolB,
					   Cout => mem2rolC,
					   Dout => mem2rolD);

rolshift : roller PORT MAP(A => mem2rolA,
						   B => mem2rolB,
						   C => mem2rolC,
						   D => mem2rolD,
						   W => rol2addA,
						   X => rol2addB,
						   Y => rol2addC,
						   Z => rol2addD);

adder_1 : adder PORT MAP(A => rol2addA,
					   B => rol2addB,
					   C => rol2addC,
					   D => rol2addD,
					   ALLOW => FULL_ALLOW,
					   ADONE => Adone,
					   AOUT => AddOut);

counterOutput_1 : counterOutput PORT MAP(CLK => CLK,
									   DONE => Adone,
									   START => START,
									   CNTA => CountOut,
									   FDONE => FiltDONE);


--Output assignment

ADDR_A_fetch <= ADDRA_fetch_out;
Y <= AddOut;
COUNT <= CountOut;



END structure;