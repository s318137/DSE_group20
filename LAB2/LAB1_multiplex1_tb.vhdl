LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY LAB1_multiplex1_tb IS
END LAB1_multiplex1_tb;

ARCHITECTURE tb_bh OF LAB1_multiplex1_tb IS

	COMPONENT LAB1_multiplex1
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0); --defined to read when needed
		X, Y : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		S : INOUT STD_LOGIC;
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); --defined to read when needed
		M : out STD_LOGIC_VECTOR(3 DOWNTO 0));
	END COMPONENT;
	
	--Init
	--Inputs needed
	SIGNAL SW : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	SIGNAL X : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL Y : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL S : STD_LOGIC := '0';
	-- Outputs received
	SIGNAL LEDR : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL M : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
BEGIN
	uut : LAB1_multiplex1 PORT MAP(
		SW => SW,
        X => X,
        Y => Y,
        S => S,
        LEDR => LEDR,
        M => M
		);

PROCESS
BEGIN
	-- TEST S
	SW(8) <= '1'; -- S = 1
	wait for 100 ns;
	
	-- TEST SW0-3 => LED0-3 AND S=0
	SW(8) <= '0';
	SW(3 DOWNTO 0) <= "1011"; 
	wait for 100 ns; 
	-- TEST SW0-3 => LED0-3 AND S=1
	SW(8) <= '1';
	SW(3 DOWNTO 0) <= "1101"; 
	wait for 100 ns; 
	
	-- TEST SW4-7 => LED4-7 AND S=0
	SW(8) <= '0';
	SW(7 DOWNTO 4) <= "1011"; 
	wait for 100 ns; 
	-- TEST SW4-7 => LED4-7 AND S=1
	SW(8) <= '1';
	SW(7 DOWNTO 4) <= "1101"; 
	wait for 100 ns; 
		
	-- TEST ALL IN ONCE
	SW(8) <= '0';
	SW(7 DOWNTO 0) <= "11111111";
	wait for 100 ns;
	
	SW(8) <= '1';
	wait for 100 ns;


END PROCESS;
END tb_bh;