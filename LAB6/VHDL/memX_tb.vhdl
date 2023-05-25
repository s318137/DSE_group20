LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- This TB is in that case both a testbench proving the abilities
-- And a development bench destined to create what is expected


ENTITY memX_tb IS
END memX_tb;

ARCHITECTURE test OF memX_tb IS

	COMPONENT memX IS
	PORT(
		DIN : IN SIGNED(7 DOWNTO 0);
		ADDR : IN UNSIGNED(9 DOWNTO 0);
		CS : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		WR : IN STD_LOGIC;
		RD : IN STD_LOGIC;
		DOUT : OUT SIGNED(7 DOWNTO 0)
	);	
	END COMPONENT;
	
	-- Even though this component fetchs an other memory, it is not used as it could
	
	-- SIGNALS
	-- As it is quite a complex component, descriptive names are used
		-- IN
		SIGNAL Data : SIGNED(7 DOWNTO 0) := "00000000";
		SIGNAL Selection : STD_LOGIC := '1';
		SIGNAL Count : UNSIGNED(9 DOWNTO 0) := (others => '0');
		SIGNAL CLK : STD_LOGIC := '0';
		SIGNAL Writ : STD_LOGIC := '1'; -- COMPLEMENTED INPUT
		SIGNAL Reed : STD_LOGIC := '1';
		
		-- OUT
		SIGNAL Dout: SIGNED(7 DOWNTO 0);
		
	
BEGIN

uut : memX PORT MAP(
	DIN => Data,
	ADDR => Count,
	CS => Selection,
	CLK => CLK,
	WR => Writ,
	RD => Reed,
	DOUT => Dout
);

PROCESS
BEGIN
	Writ <= '0';
	Reed <= '0';
	Data <= (0 => '1', others => '0');
	
	
	CLK <= '1';
	wait for 10 ns;
	CLK <= '0';
	wait for 10 ns;
	
	wait for 1 ps;
	Reed <= '1';
	
	CLK <= '1';
	wait for 10 ns;
	CLK <= '0';
	wait for 10 ns;
	
	wait for 10 ns;
	wait;



END PROCESS;
END test;