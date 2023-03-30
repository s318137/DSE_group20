LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RCA_4bit_tb IS
END RCA_4bit_tb;

ARCHITECTURE test OF RCA_4bit_tb IS

	COMPONENT RCA_4bit IS
		PORT(
			A_reg, B_reg : IN SIGNED(3 DOWNTO 0);
			Ci_in : IN STD_LOGIC;
			OVERFLOW : OUT STD_LOGIC;
			S_reg : OUT SIGNED(3 DOWNTO 0)
			);
	END COMPONENT;
	
	--Init signals
	SIGNAL A : SIGNED(3 DOWNTO 0) := "0000";
	SIGNAL B : SIGNED(3 DOWNTO 0) := "0000";
	SIGNAL S : SIGNED(3 DOWNTO 0);
	SIGNAL C : STD_LOGIC := '0';
	SIGNAL V_FLAG : STD_LOGIC;

BEGIN
	uut: RCA_4bit PORT MAP(
	A_reg => A,
	B_reg => B,
	S_reg => S,
	Ci_in => C,
	OVERFLOW => V_FLAG
	);

PROCESS
BEGIN
	
	--Sum of 2 positives without carry
	A <= "0001";
	B <= "0010";
	C <= '0';
	-- S = 0011
	wait for 100 ns;
	
	--With carry
	A <= "0001";
	B <= "0010";
	C <= '1';
	-- S = 0100
	wait for 100 ns;
	
	--Sum of 1 neg + 1 pos without carry
	A <= "0001";
	B <= "1010";
	C <= '0';
	-- S = 0011
	wait for 100 ns;
	
	--With carry
	A <= "0001";
	B <= "1010";
	C <= '1';
	-- S = 0100
	wait for 100 ns;
	
	--Sum of 2 negatives without carry
	A <= "1001";
	B <= "1010";
	C <= '0';
	-- S = 0011
	wait for 100 ns;
	
	--With carry
	A <= "1001";
	B <= "1010";
	C <= '1';
	-- S = 0100
	wait for 100 ns;
	
	wait;

END PROCESS;	
END test;
