LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part3_CSA_16bit IS
	PORT(
		A_16bit, B_16bit : IN SIGNED(15 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		KEY0, KEY1 : IN STD_LOGIC; 
		Co: OUT STD_LOGIC;
		S_16b : OUT SIGNED(15 DOWNTO 0)
		);
END Part3_CSA_16bit;

ARCHITECTURE struct02 OF Part3_CSA_16bit IS

	COMPONENT CSA_16bit IS
		PORT(
		A_reg, B_reg : IN SIGNED(15 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT SIGNED(15 DOWNTO 0)
	     );
	END COMPONENT;
	
	COMPONENT regn IS
		GENERIC (N :integer:=16);
		PORT (R : IN SIGNED(N-1 DOWNTO 0);
		Clock, Resetn : IN STD_LOGIC;
		Q : OUT SIGNED(N-1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT flipflop IS
		PORT (D, Clock, Resetn : IN STD_LOGIC;
		Q : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT overflow IS
		PORT(
			carry : IN STD_LOGIC;
			OV : OUT UNSIGNED(7 DOWNTO 0)
			);
	END COMPONENT;

	SIGNAL A_display : SIGNED(15 DOWNTO 0);
	SIGNAL B_display : SIGNED(15 DOWNTO 0);
	SIGNAL S_mem : SIGNED(15 DOWNTO 0);
	SIGNAL S_display : SIGNED(15 DOWNTO 0);
	SIGNAL adder_carry : STD_LOGIC; 
	SIGNAL FLAG : UNSIGNED(7 DOWNTO 0); 


BEGIN

--A series of 4bit RCAs with a ripple carry between them

rA : regn PORT MAP(R=>A_16bit, Clock => KEY1, Resetn => KEY0, Q=>A_display);

rB : regn PORT MAP(R=>B_16bit, Clock => KEY1, Resetn => KEY0, Q=>B_display);

RCA : CSA_16bit PORT MAP(
							A_reg => A_display,
							B_reg => B_display,
							Ci_in => Ci_in,
							OVERFLOW => adder_carry,
							S_reg => S_display)
							;

ff_carry : flipflop PORT MAP(D => adder_carry, Clock => KEY1, Resetn => KEY0, Q=>Co);

regnS : regn PORT MAP(R=>S_display, Clock => KEY1, Resetn => KEY0, Q=>S_16b);

ov1 : overflow PORT MAP(carry => adder_carry, OV => FLAG);


END struct02;