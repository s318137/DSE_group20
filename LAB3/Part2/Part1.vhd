LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part1 IS
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		KEY0, KEY1 : IN STD_LOGIC; 
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6);
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
		
END Part1;

ARCHITECTURE struct OF Part1 IS

	COMPONENT RCA_4bit IS
		PORT(
			A_reg, B_reg : IN SIGNED(3 DOWNTO 0);
			Ci_in : IN STD_LOGIC;
			OVERFLOW : OUT STD_LOGIC;
			S_reg : OUT SIGNED(3 DOWNTO 0)
			);
	END COMPONENT;

	COMPONENT Part3 IS
		PORT (sw : IN std_logic_vector(3 DOWNTO 0);
		hex1,hex0 : OUT STD_LOGIC_VECTOR(0 TO 6)
		);
	END COMPONENT;

	SIGNAL A_display : STD_LOGIC_VECTOR(3 DOWNTO 0) := SW(3 DOWNTO 0);
	SIGNAL B_display : STD_LOGIC_VECTOR(3 DOWNTO 0) := SW(7 DOWNTO 4);
	SIGNAL S_display : SIGNED(3 DOWNTO 0) := "0000";

BEGIN

RCA_01 : RCA_4bit PORT MAP(
							A_reg => signed(A_display),
							B_reg => signed(B_display),
							Ci_in => SW(9),
							OVERFLOW => LEDR(9),
							S_reg => S_display)
							;

A_disp : Part3 PORT MAP(sw => A_display, hex1 => HEX1, hex0 => HEX0);
B_disp : Part3 PORT MAP(sw => B_display, hex1 => HEX3, hex0 => HEX2);
S_disp : Part3 PORT MAP(sw => STD_LOGIC_VECTOR(S_display), hex1 => HEX5, hex0 => HEX4);


END struct;