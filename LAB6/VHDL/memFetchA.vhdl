LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY memFetchA IS
	PORT(
		X : IN SIGNED(7 DOWNTO 0);
		START : IN STD_LOGIC;
		RDA : IN STD_LOGIC;
		A_N : OUT SIGNED(7 DOWNTO 0)
	);	
END memFetchA;

ARCHITECTURE fetching OF memFetchA IS

	--Output
	SIGNAL A_Nout : SIGNED(7 DOWNTO 0);

BEGIN	
A_Nout <= X WHEN(RDA = '1') ELSE
			 "00000000" WHEN ((RDA = '0') OR (START = '1'));
	


A_N <= A_Nout;

END fetching;