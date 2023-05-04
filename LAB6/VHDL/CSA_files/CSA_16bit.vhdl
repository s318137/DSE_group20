LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CSA_16bit IS
	PORT(
		A_reg, B_reg : IN SIGNED(15 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT SIGNED(15 DOWNTO 0)
	     );
END CSA_16bit;

ARCHITECTURE rca OF CSA_16bit IS

CONSTANT ONE : SIGNED(A_reg'RANGE) := (0 => '1', others => '0');

COMPONENT RCA_4bit IS
	PORT(
		A_reg, B_reg : IN SIGNED(3 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT SIGNED(3 DOWNTO 0)
	     );
END COMPONENT;

COMPONENT mux2to1_1b IS
	port (a,b,sel : in std_logic;
		y : out std_logic);
END COMPONENT;

SIGNAL S_buff_path0 : SIGNED(15 DOWNTO 0);
SIGNAL S_buff_path1 : SIGNED(15 DOWNTO 0);
SIGNAL S_buff : SIGNED(15 DOWNTO 0);
SIGNAL Cs : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL C1, C2, C3 : STD_LOGIC;
SIGNAL A_comp : SIGNED(15 DOWNTO 0);
SIGNAL B_comp : SIGNED(15 DOWNTO 0);


BEGIN
--Complementation if negatives
A_comp <= (not(A_reg)+ONE) WHEN ((B_reg(15) = '1') AND (A_reg(15) = '1')) ELSE A_reg; -- sum of complementaries if both negatives
B_comp <= (not(B_reg)+ONE) WHEN ((B_reg(15) = '1') AND (A_reg(15) = '1')) ELSE B_reg; -- sum of complementaries if both negatives

--Stage 3-0
fa_00 : RCA_4bit PORT MAP (A_reg => A_comp(3 DOWNTO 0), B_reg => B_comp(3 DOWNTO 0), Ci_in => '0', OVERFLOW => Cs(0), S_reg => S_buff_path0(3 DOWNTO 0));
fa_01 : RCA_4bit PORT MAP (A_reg => A_comp(3 DOWNTO 0), B_reg => B_comp(3 DOWNTO 0), Ci_in => '1', OVERFLOW => Cs(1), S_reg => S_buff_path1(3 DOWNTO 0));
	--Selection
mux1 : mux2to1_1b PORT MAP(a => Cs(0), b => Cs(1), sel => Ci_in, y => C1);
S_buff(3 DOWNTO 0) <= S_buff_path0(3 DOWNTO 0) WHEN C1='0' ELSE S_buff_path1(3 DOWNTO 0); --Choice of S 3-0

--Stage 7-4
fa_10 : RCA_4bit PORT MAP (A_reg => A_comp(7 DOWNTO 4), B_reg => B_comp(7 DOWNTO 4), Ci_in => '0', OVERFLOW => Cs(2), S_reg => S_buff_path0(7 DOWNTO 4));
fa_11 : RCA_4bit PORT MAP (A_reg => A_comp(7 DOWNTO 4), B_reg => B_comp(7 DOWNTO 4), Ci_in => '1', OVERFLOW => Cs(3), S_reg => S_buff_path1(7 DOWNTO 4));
	--Selection
mux2 : mux2to1_1b PORT MAP(a => Cs(2), b => Cs(3), sel => C1, y => C2);
S_buff(7 DOWNTO 4) <= S_buff_path0(7 DOWNTO 4) WHEN C1='0' ELSE S_buff_path1(7 DOWNTO 4); --Choice of S 3-0

--Stage 11-8
fa_20 : RCA_4bit PORT MAP (A_reg => A_comp(11 DOWNTO 8), B_reg => B_comp(11 DOWNTO 8), Ci_in => '0', OVERFLOW => Cs(4), S_reg => S_buff_path0(11 DOWNTO 8));
fa_21 : RCA_4bit PORT MAP (A_reg => A_comp(11 DOWNTO 8), B_reg => B_comp(11 DOWNTO 8), Ci_in => '1', OVERFLOW => Cs(5), S_reg => S_buff_path1(11 DOWNTO 8));
	--Selection
mux3 : mux2to1_1b PORT MAP(a => Cs(4), b => Cs(5), sel => C2, y => C3);
S_buff(11 DOWNTO 8) <= S_buff_path0(11 DOWNTO 8) WHEN C1='0' ELSE S_buff_path1(11 DOWNTO 8); --Choice of S 3-0

--Stage 15-12
fa_30 : RCA_4bit PORT MAP (A_reg => A_comp(15 DOWNTO 12), B_reg => B_comp(15 DOWNTO 12), Ci_in => '0', OVERFLOW =>Cs(6), S_reg => S_buff_path0(15 DOWNTO 12));
fa_31 : RCA_4bit PORT MAP (A_reg => A_comp(15 DOWNTO 12), B_reg => B_comp(15 DOWNTO 12), Ci_in => '1', OVERFLOW =>Cs(7), S_reg => S_buff_path1(15 DOWNTO 12));
	--Selection
mux4 : mux2to1_1b PORT MAP(a => Cs(6), b => Cs(7), sel => C3, y => OVERFLOW);
S_buff(14 DOWNTO 12) <= S_buff_path0(14 DOWNTO 12) WHEN C1='0' ELSE S_buff_path1(14 DOWNTO 12); --Choice of S 3-0

S_buff(15) <='0' WHEN ((B_reg(15) = '1') AND (A_reg(15) = '1')) ELSE
			 '1' WHEN ((B_reg(15) = '1') XOR (A_reg(15) = '1')) ELSE
			 '0' WHEN ((B_reg(15) = '0') AND (A_reg(15) = '0'));

S_reg <= (not(signed(S_buff))+ONE) WHEN (B_reg(15) = '1') AND (A_reg(15) = '1') ELSE signed(S_buff) ; -- complement of the sum if both negatives


END rca;
