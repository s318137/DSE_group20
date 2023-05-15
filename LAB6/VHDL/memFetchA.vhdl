LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY memFetchA IS
	PORT(
		CLK : IN STD_LOGIC;
		X : IN SIGNED(7 DOWNTO 0);
		START : IN STD_LOGIC;
		RDA : IN STD_LOGIC;
		A_N : OUT SIGNED(7 DOWNTO 0)
	);	
END memFetchA;

ARCHITECTURE fetching OF memFetchA IS

	COMPONENT regn IS
		GENERIC (N :integer:=8);
		PORT (R : IN SIGNED(N-1 DOWNTO 0);
		Clock, Resetn : IN STD_LOGIC;
		Q : OUT SIGNED(N-1 DOWNTO 0));
	END COMPONENT;

	-- SIGNAL 
	--Input
	
	--Register
	SIGNAL regIn : SIGNED(7 DOWNTO 0);
	
	--Output
	SIGNAL A_Nout : SIGNED(7 DOWNTO 0);

BEGIN	
	regIn <= X WHEN(RDA = '1') ELSE
			 "00000000" WHEN (RDA = '0');
	
regA : regn PORT MAP(R=>regIn, Clock => CLK, Resetn => START, Q=>A_Nout);
	

A_N <= A_Nout;

END fetching;