LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CarryBypassAdder_16bit IS
	PORT(
		A_reg, B_reg : IN SIGNED(15 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT SIGNED(15 DOWNTO 0)
	     );
END CarryBypassAdder_16bit;

ARCHITECTURE cba OF CarryBypassAdder_16bit IS

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

SIGNAL S_buff : SIGNED(15 DOWNTO 0);
SIGNAL C1, C2, C3, C4 : STD_LOGIC;
SIGNAL C0_out, C1_out, C2_out, C3_out : STD_LOGIC;
SIGNAL Propag0, Propag1, Propag2, Propag3 : STD_LOGIC;
SIGNAL A_comp : SIGNED(15 DOWNTO 0);
SIGNAL B_comp : SIGNED(15 DOWNTO 0);


BEGIN

A_comp <= (not(A_reg)+ONE) WHEN ((B_reg(15) = '1') AND (A_reg(15) = '1')) ELSE A_reg; -- sum of complementaries if both negatives
B_comp <= (not(B_reg)+ONE) WHEN ((B_reg(15) = '1') AND (A_reg(15) = '1')) ELSE B_reg; -- sum of complementaries if both negatives

--Complementation if negatives

--propagation conditons
Propag0 <= ((A_comp(0) XOR B_comp(0)) AND (A_comp(1) XOR B_comp(1)) AND (A_comp(2) XOR B_comp(2)) AND (A_comp(3) XOR B_comp(3))); -- pi = Ai XOR bi, propag if every propagation is '1'
rca_0 : RCA_4bit PORT MAP (A_reg => A_comp(3 DOWNTO 0), B_reg => B_comp(3 DOWNTO 0), Ci_in => Ci_in, OVERFLOW => C0_out, S_reg => S_buff(3 DOWNTO 0));
mux0 : mux2to1_1b PORT MAP(a => Ci_in, b => C0_out, sel => Propag0, y => C1);


Propag1 <= ((A_comp(4) XOR B_comp(4)) AND (A_comp(5) XOR B_comp(5)) AND (A_comp(6) XOR B_comp(6)) AND (A_comp(7) XOR B_comp(7))); -- pi = Ai XOR bi, propag if every propagation is '1'
rca_1 : RCA_4bit PORT MAP (A_reg => A_comp(7 DOWNTO 4), B_reg => B_comp(7 DOWNTO 4), Ci_in => C1, OVERFLOW => C1_out, S_reg => S_buff(7 DOWNTO 4));
mux1 : mux2to1_1b PORT MAP(a => C1, b => C1_out, sel => Propag1, y => C2);


Propag2 <= ((A_comp(8) XOR B_comp(8)) AND (A_comp(9) XOR B_comp(9)) AND (A_comp(10) XOR B_comp(10)) AND (A_comp(11) XOR B_comp(11))); -- pi = Ai XOR bi, propag if every propagation is '1'
rca_2 : RCA_4bit PORT MAP (A_reg => A_comp(11 DOWNTO 8), B_reg => B_comp(11 DOWNTO 8), Ci_in => C2, OVERFLOW => C2_out, S_reg => S_buff(11 DOWNTO 8));
mux2 : mux2to1_1b PORT MAP(a => C2, b => C2_out, sel => Propag2, y => C3);


Propag3 <= ((A_comp(12) XOR B_comp(12)) AND (A_comp(13) XOR B_comp(13)) AND (A_comp(14) XOR B_comp(14)) AND (A_comp(15) XOR B_comp(15))); -- pi = Ai XOR bi, propag if every propagation is '1'
rca_3 : RCA_4bit PORT MAP (A_reg => A_comp(15 DOWNTO 12), B_reg => B_comp(15 DOWNTO 12), Ci_in => C3, OVERFLOW =>C3_out, S_reg => S_buff(15 DOWNTO 12));
mux3 : mux2to1_1b PORT MAP(a => C3, b => C3_out, sel => Propag3, y => OVERFLOW); --Final carry OVERFLOW decided here 


S_reg <= (not(signed(S_buff))+ONE) WHEN (B_reg(15) = '1') AND (A_reg(15) = '1') ELSE signed(S_buff) ; -- complement of the sum if both negatives


END cba;