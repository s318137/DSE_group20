LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- This TB is in that case both a testbench proving the abilities
-- And a development bench destined to create what is expected


ENTITY mem32_tb IS
END mem32_tb;

ARCHITECTURE test OF mem32_tb IS

	COMPONENT mem32 IS
	PORT(
		DIN : IN SIGNED(7 DOWNTO 0);
		CS : IN STD_LOGIC;
		COUNT : IN UNSIGNED(9 DOWNTO 0); 
		CLK : IN STD_LOGIC;
		WR : IN STD_LOGIC;
		RD : IN STD_LOGIC;
		ADDR_A : OUT UNSIGNED(9 DOWNTO 0);
		Aout, Bout, Cout, Dout : OUT SIGNED(7 DOWNTO 0)
	);	
	END COMPONENT;
	
	-- Even though this component fetchs an other memory, it is not used as it could
	
	-- SIGNALS
	-- As it is quite a complex component, descriptive names are used
		-- IN
		SIGNAL Data : SIGNED(7 DOWNTO 0) := "00000000";
		SIGNAL Selection : STD_LOGIC := '1';
		SIGNAL Count : UNSIGNED(9 DOWNTO 0) := (others => '0');
		SIGNAL CLK : STD_LOGIC;
		SIGNAL Writ : STD_LOGIC := '1'; -- COMPLEMENTED INPUT
		SIGNAL Reed : STD_LOGIC := '1';
		
		-- OUT
		SIGNAL Address_out : UNSIGNED(9 DOWNTO 0);
		SIGNAL A, B, C, D : SIGNED(7 DOWNTO 0);
		
	
BEGIN

uut : mem32 PORT MAP(
	DIN => Data,
	CS => Selection,
	COUNT => Count,
	CLK => CLK,
	WR => Writ,
	RD => Reed,
	ADDR_A => Address_out,
	Aout => A,
	Bout => B,
	Cout => C, 
	Dout => D
);

PROCESS
BEGIN

	wait for 100 ns;
	wait;



END PROCESS;
END test;