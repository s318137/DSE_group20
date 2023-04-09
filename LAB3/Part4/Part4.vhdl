LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part4 IS
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		HEX0, HEX1, HEX2, HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
END Part4;

ARCHITECTURE struct2 OF Part4 IS

	COMPONENT Multiplier IS
		PORT(
		A_reg, B_reg : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S_reg : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	     );
	END COMPONENT;

	COMPONENT hex_display IS
		PORT(
		InValue : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	
	END COMPONENT;


	SIGNAL S_DISPLAY : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL H0, H1, H2, H3 : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN

dispA : hex_display PORT MAP(InValue => SW(3 DOWNTO 0), HEX0 => H0);
dispB : hex_display PORT MAP(InValue => SW(7 DOWNTO 4), HEX0 => H1);

mult : Multiplier PORT MAP(A_reg => SW(3 DOWNTO 0),
						   B_reg => SW(7 DOWNTO 4),
						   S_reg => S_DISPLAY); 


dispS0 : hex_display PORT MAP(InValue => S_DISPLAY(3 DOWNTO 0), HEX0 => H2);
dispS1 : hex_display PORT MAP(InValue => S_DISPLAY(7 DOWNTO 4), HEX0 => H3);

HEX0 <= H0;
HEX1 <= H1;
HEX2 <= H2;
HEX3 <= H3;


END struct2;