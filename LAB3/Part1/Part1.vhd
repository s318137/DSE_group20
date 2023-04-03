LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part1 IS
	PORT(
		CLK, 
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

	COMPONENT regn IS
		GENERIC (N :integer:=4);
		PORT (R : IN SIGNED(N-1 DOWNTO 0);
		Clock, Resetn : IN STD_LOGIC;
		Q : OUT SIGNED(N-1 DOWNTO 0));
	END COMPONENT;

	COMPONENT flipflop IS
		PORT (D, Clock, Resetn : IN STD_LOGIC;
		Q : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT overflow IS
		PORT(
			carry : IN STD_LOGIC;
			OV : OUT UNSIGNED(7 DOWNTO 0)
			);
		END COMPONENT;

	COMPONENT Part3 IS
		PORT (sw : IN std_logic_vector(3 DOWNTO 0);
		hex1,hex0 : OUT STD_LOGIC_VECTOR(0 TO 6)
		);
	END COMPONENT;

	SIGNAL A_display : SIGNED(3 DOWNTO 0);
	SIGNAL B_display : SIGNED(3 DOWNTO 0);
	SIGNAL S_mem : SIGNED(3 DOWNTO 0);
	SIGNAL S_display : SIGNED(3 DOWNTO 0);
	SIGNAL adder_carry : STD_LOGIC; 
	SIGNAL FLAG : UNSIGNED(7 DOWNTO 0); 

BEGIN

regnA : regn PORT MAP(R=>signed(SW(3 DOWNTO 0)), Clock => KEY0, Resetn => KEY1, Q=>A_display);

regnB : regn PORT MAP(R=>signed(SW(7 DOWNTO 4)), Clock => KEY0, Resetn => KEY1, Q=>B_display);

RCA_01 : RCA_4bit PORT MAP(
							A_reg => signed(A_display),
							B_reg => signed(B_display),
							Ci_in => SW(9),
							OVERFLOW => adder_carry,
							S_reg => S_mem)
							;

ff_carry : flipflop PORT MAP(D => adder_carry, Clock => KEY0, Resetn => KEY1, Q=> LEDR(9));

regnS : regn PORT MAP(R=>S_mem, Clock => KEY0, Resetn => KEY1, Q=>S_display);

ov1 : overflow PORT MAP(carry => adder_carry, OV => FLAG);



A_disp : Part3 PORT MAP(sw => STD_LOGIC_VECTOR(A_display), hex1 => HEX1, hex0 => HEX0);
B_disp : Part3 PORT MAP(sw => STD_LOGIC_VECTOR(B_display), hex1 => HEX3, hex0 => HEX2);
S_disp : Part3 PORT MAP(sw => STD_LOGIC_VECTOR(S_display), hex1 => HEX5, hex0 => HEX4);


END struct;