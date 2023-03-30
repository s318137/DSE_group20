LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Multiplier IS
	PORT(
		A_reg, B_reg : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S_reg : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	     );
END Multiplier;

ARCHITECTURE mulX OF Multiplier IS

COMPONENT rank_and IS
	PORT(
		A_reg : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		B : IN STD_LOGIC;
		Y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	     );
END COMPONENT;

COMPONENT RCA_4bit_p4 IS
	PORT(
		A_reg, B_reg : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	     );
END COMPONENT;

--SIGNAL IN
SIGNAL C1, C2, C3 : STD_LOGIC; --Carries between RCAs 
SIGNAL RCA_res1, RCA_res2, RCA_res3 : STD_LOGIC_VECTOR(3 DOWNTO 0); --results of the 3 RCA

--SIGNAL INTERMEDIARY
SIGNAL RCA1_in, RCA2_in, RCA3_in : STD_LOGIC_VECTOR(3 DOWNTO 0);

--SIGNAL OUT
SIGNAL Sum0, Sum1, Sum2, Sum3 : STD_LOGIC_VECTOR(3 DOWNTO 0); --Summands 0-3
SIGNAL S_buff : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN
--Preparing the summands
r0 : rank_and PORT MAP(A_reg => A_reg, B => B_reg(0), Y => Sum0);
r1 : rank_and PORT MAP(A_reg => A_reg, B => B_reg(1), Y => Sum1);
r2 : rank_and PORT MAP(A_reg => A_reg, B => B_reg(2), Y => Sum2);
r3 : rank_and PORT MAP(A_reg => A_reg, B => B_reg(3), Y => Sum3);

--Preparing the inputs for the 3 RCA
RCA1_in(3) <=  '0';
RCA1_in(2 DOWNTO 0) <= Sum0(3 DOWNTO 1);

RCA2_in(3) <= C1;
RCA2_in(2 DOWNTO 0) <= RCA_res1(3 DOWNTO 1);

RCA3_in(3) <= C2;
RCA3_in(2 DOWNTO 0) <= RCA_res2(3 DOWNTO 1);

--Executing the sums
rca1 : RCA_4bit_p4 PORT MAP(A_reg => RCA1_in,
						 B_reg => Sum1,
						 Ci_in => '0',
						 OVERFLOW => C1,
						 S_reg => RCA_res1);
						 
rca2 : RCA_4bit_p4 PORT MAP(A_reg => RCA2_in,
						 B_reg => Sum2,
						 Ci_in => '0',
						 OVERFLOW => C2,
						 S_reg => RCA_res2);
						 
rca3 : RCA_4bit_p4 PORT MAP(A_reg => RCA3_in,
						 B_reg => Sum3,
						 Ci_in => '0',
						 OVERFLOW => C3,
						 S_reg => RCA_res3);
						 
--Frankenstein result
		   
S_buff(7) <= C3;
S_buff(6 DOWNTO 3) <= RCA_res3;
S_buff(2) <= RCA_res2(0);
S_buff(1) <= RCA_res1(0);
S_buff(0) <= Sum0(0);

S_reg <= S_buff;


END mulX;