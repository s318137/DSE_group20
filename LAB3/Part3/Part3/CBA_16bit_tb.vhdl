LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CBA_16bit_tb IS
END CBA_16bit_tb;

ARCHITECTURE test OF CBA_16bit_tb IS

	COMPONENT CarryBypassAdder_16bit IS
		PORT(
		A_reg, B_reg : IN SIGNED(15 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT SIGNED(15 DOWNTO 0)
	     );
	END COMPONENT;
	
	--Init signals
	SIGNAL A : SIGNED(15 DOWNTO 0) := (others=>'0');
	SIGNAL B : SIGNED(15 DOWNTO 0) := (others=>'0');
	SIGNAL S : SIGNED(15 DOWNTO 0);
	SIGNAL C : STD_LOGIC := '0';
	SIGNAL V_FLAG : STD_LOGIC;

BEGIN
	uut: CarryBypassAdder_16bit PORT MAP(
	A_reg => A,
	B_reg => B,
	S_reg => S,
	Ci_in => C,
	OVERFLOW => V_FLAG
	);

PROCESS
BEGIN
	
	--Sum of 2 positives without carry
	A <= (0 => '1', others => '0');
	B <= (1 => '1', others => '0');
	C <= '0';
	-- S = 0011
	wait for 100 ns;
	
	--With carry
	A <= (0 => '1', others => '0');
	B <= (1 => '1', others => '0');
	C <= '1';
	-- S = 0100
	wait for 100 ns;
	
	--Sum of 1 neg + 1 pos without carry
	A <= (0 => '1', others => '0');
	B <= (1 => '1', 3=> '1', others => '0');
	C <= '0';
	-- S = 0011
	wait for 100 ns;
	
	--With carry
	A <= (0 => '1', others => '0');
	B <= (1 => '1', 3=> '1', 15=>'1', others => '0');
	C <= '1';
	-- S = 0100
	wait for 100 ns;
	
	--Sum of 2 negatives without carry
	A <= (1 => '1', 15=>'1', others => '0');
	B <= (1 => '1', 3=> '1', 15=>'1', others => '0');
	C <= '0';
	-- S = 0011
	wait for 100 ns;
	
	--With carry
	A <= (1 => '1', 3=> '1', 15=>'1', others => '0');
	B <= (1 => '1', 3=> '1', 15=>'1',others => '0');
	C <= '1';
	-- S = 0100
	wait for 100 ns;
	
	wait;

END PROCESS;	
END test;