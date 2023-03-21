-- CODE BASED ON LAB1_multiplex1_tb.vhdl

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY LAB1_5to1mux_tb IS
END LAB1_5to1mux_tb;

ARCHITECTURE tb2_bh OF LAB1_5to1mux_tb IS

	COMPONENT LAB1_5to1mux IS
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0); --defined to read when needed
		X, Y, W, U, V : INOUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		S0, S1, S2 : INOUT STD_LOGIC;
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); --defined to read when needed
		M : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
	END COMPONENT;

	--Inputs needed
	SIGNAL SW : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	SIGNAL X, Y : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL S0 : STD_LOGIC := '0';
	SIGNAL S1 : STD_LOGIC := '0';
	SIGNAL S2 : STD_LOGIC := '0';
	--Outputs needed
	SIGNAL LEDR : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000"; --simulation only
	SIGNAL M : STD_LOGIC_VECTOR(2 DOWNTO 0);
	
BEGIN
	uut : LAB1_5to1mux PORT MAP(
		SW => SW,
        X => X,
        Y => Y,
        S0 => S0,
		S1 => S1,
		S2 => S2,
        LEDR => LEDR,
        M => M
	);

PROCESS
BEGIN
	--TEST OF X, Y
	SW(2 DOWNTO 0) <= "110"; --Y = 110
	SW(5 DOWNTO 3) <= "011"; --X = 011
	WAIT FOR 100 ns;

	--TEST SW => S(0-2)
	SW(8) <= '1';
	WAIT FOR 100 ns;
	SW(7) <= '1';
	WAIT FOR 100 ns;
	SW(6) <= '1';
	WAIT FOR 100 ns;	

	-- TEST M=U=010
	SW(8 DOWNTO 6) <= "000";
	WAIT FOR 100 ns;

	-- TEST M=V=111
	SW(8 DOWNTO 6) <= "100";
	WAIT FOR 100 ns;

	-- TEST M=W=101
	SW(8 DOWNTO 6) <= "010";
	WAIT FOR 100 ns;

	-- TEST M=X=010
	SW(8 DOWNTO 6) <= "110";
	WAIT FOR 100 ns;

	-- TEST M=Y=010
	SW(8 DOWNTO 6) <= "001";
	WAIT FOR 100 ns;
	WAIT;



END PROCESS;
END tb2_bh;