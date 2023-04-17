LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part2 IS
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);	
END Part2;

ARCHITECTURE onehot OF Part2 IS

	COMPONENT flipflop IS
		PORT (
			D, Clock, Resetn : IN STD_LOGIC;
			Q : OUT STD_LOGIC
			);
	END COMPONENT;

	--Signals
	SIGNAL OneHot : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000"; --A as default
	SIGNAL A_up, B_up, C_up, D_up, E_up, F_up, G_up, H_up, I_up : STD_LOGIC; --Logical conditions, as logical statements are not usable in PORT MAP
	SIGNAL Q_A : STD_LOGIC;
	SIGNAL W : STD_LOGIC;
	
BEGIN

W <= SW(1);

A_up <= '1' WHEN ((SW(0)='0')) ELSE '0';
B_up <= '1' WHEN (((W = '0' AND OneHot = "000000000") OR -- A
				   (W = '0' AND OneHot = "000100001") OR -- F
				   (W = '0' AND OneHot = "001000001") OR -- G 
				   (W = '0' AND OneHot = "010000001") OR -- H
				   (W = '0' AND OneHot = "100000001"))) ELSE '0'; -- I

C_up <= '1' WHEN ((W = '0' AND OneHot = "000000011")) ELSE '0';

D_up <= '1' WHEN ((W = '0' AND OneHot = "000000101")) ELSE '0';

E_up <= '1' WHEN (((W = '0' AND OneHot = "000001001") OR (W = '0' AND OneHot = "000010001"))) ELSE '0';

F_up <= '1' WHEN (((W = '1' AND OneHot = "000000000") OR -- A
				   (W = '1' AND OneHot = "000000011") OR -- B
				   (W = '1' AND OneHot = "000000101") OR -- C
				   (W = '1' AND OneHot = "000001001") OR -- D
				   (W = '1' AND OneHot = "000010001"))) ELSE '0'; -- E
				   
G_up <= '1' WHEN ((W = '1' AND OneHot = "000100001")) ELSE '0';

H_up <= '1' WHEN ((W = '1' AND OneHot = "001000001")) ELSE '0';

I_up <= '1' WHEN (((W = '1' AND OneHot = "010000001") OR (W = '1' AND OneHot = "100000001"))) ELSE '0';

fA : flipflop PORT MAP(D => A_up, Clock => KEY(1), Resetn => '1', Q => Q_A);
OneHot(0) <= not(Q_A);
fB : flipflop PORT MAP(D => B_up, Clock => KEY(1), Resetn => SW(0), Q => OneHot(1));
fC : flipflop PORT MAP(D => C_up, Clock => KEY(1), Resetn => SW(0), Q => OneHot(2));

fD : flipflop PORT MAP(D => D_up, Clock => KEY(1), Resetn => SW(0), Q => OneHot(3));
fE : flipflop PORT MAP(D => E_up, Clock => KEY(1), Resetn => SW(0), Q => OneHot(4));
fF : flipflop PORT MAP(D => F_up, Clock => KEY(1), Resetn => SW(0), Q => OneHot(5));

fG : flipflop PORT MAP(D => G_up, Clock => KEY(1), Resetn => SW(0), Q => OneHot(6));
fH : flipflop PORT MAP(D => H_up, Clock => KEY(1), Resetn => SW(0), Q => OneHot(7));
fI : flipflop PORT MAP(D => I_up, Clock => KEY(1), Resetn => SW(0), Q => OneHot(8));

LEDR(0) <= '1' WHEN (OneHot = "000010001" OR OneHot = "100000001") ELSE '0';


 
END onehot;