LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rank_and IS
	PORT(
		A_reg : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		B : IN STD_LOGIC;
		Y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	     );
END rank_and;

ARCHITECTURE rnk OF rank_and IS

	SIGNAL Y_buff : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	
BEGIN

	Y_buff(0) <= (A_reg(0) AND B);
	Y_buff(1) <= (A_reg(1) AND B);
	Y_buff(2) <= (A_reg(2) AND B);
	Y_buff(3) <= (A_reg(3) AND B);
	Y <= Y_buff;

END rnk; 