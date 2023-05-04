LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- This adder will be based on the CSA 16 bit adder.
-- The reason is to easily allow carry adding
-- the shifted/rolled elements will be concatenated following this format :
-- sign & (8 '0') & significative bits.
-- For this design, 3 adders will be used :
-- AdderA => 
--			 AdderC => saturation => output
-- AdderB => 


ENTITY adder IS
	PORT(
		A, B, C, D : IN SIGNED(7 DOWNTO 0); --4 8bits inputs
		ADONE : OUT STD_LOGIC; --Adder done, for counter
		AOUT : OUT SIGNED(7 DOWNTO 0) -- Output
		);
END adder;

ARCHITECTURE adding OF ADDER IS

	COMPONENT CSA_16bit IS
	PORT(
		A_reg, B_reg : IN SIGNED(15 DOWNTO 0);
		Ci_in : IN STD_LOGIC;
		OVERFLOW : OUT STD_LOGIC;
		S_reg : OUT SIGNED(15 DOWNTO 0)
	     );
	END COMPONENT;
	
	--Signals :
		-- Input
		SIGNAL A_16b, B_16b, C_16b, D_16b : SIGNED(15 DOWNTO 0) := (others => '0');
		
		-- 2 intermediate adders
		SIGNAL AddA_out, AddB_out : SIGNED(15 DOWNTO 0) := (others => '0');
		SIGNAL owA, owB : STD_LOGIC := '0';
		
		--Final adder
		SIGNAL AddC_out: SIGNED(15 DOWNTO 0) := (others => '0');
		SIGNAL owC: STD_LOGIC := '0';
		
		--Saturation
		SIGNAL cond_sat127, cond_sat128 : STD_LOGIC := '0';
		SIGNAL sat_out : SIGNED(7 DOWNTO 0);
		
		--Output
		SIGNAL done : STD_LOGIC;
	
BEGIN

-- 8 to 16 bits transformation
A_16b <= A(7) & ("00000000" & A(6 DOWNTO 0)); --A(7) is sign
B_16b <= B(7) & ("00000000" & B(6 DOWNTO 0)); -- & concatenates series of bits into one big series
C_16b <= C(7) & ("00000000" & C(6 DOWNTO 0));
D_16b <= D(7) & ("00000000" & D(6 DOWNTO 0));

-- Intermediate adders
AdderA : CSA_16bit PORT MAP(A_reg => A_16b,
							B_reg => B_16b,
							Ci_in => '0', --No carry originally
							OVERFLOW => owA, --Not possible to overflow, indicates error of '1'
							S_reg => AddA_out);
							
AdderB : CSA_16bit PORT MAP(A_reg => C_16b,
							B_reg => D_16b,
							Ci_in => '0', --No carry originally
							OVERFLOW => owB, --Not possible to overflow, indicates error of '1'
							S_reg => AddB_out);	

--Final Adder							
AdderC : CSA_16bit PORT MAP(A_reg => AddA_out,
							B_reg => AddB_out,
							Ci_in => '0',
							OVERFLOW => owC,
							S_reg => AddC_out);
							
--Saturation
-- Condition
	-- if ANY bits between 14 and 7 (8 bits) are positive, then the value is above 127/-128
	cond_sat127 <= '1' WHEN (((AddC_out(7) = '1') OR --7 is included as it is the 8th bit of value
						   (AddC_out(8) = '1') OR 
						   (AddC_out(9) = '1') OR
						   (AddC_out(10) = '1') OR
						   (AddC_out(11) = '1') OR
						   (AddC_out(12) = '1') OR
						   (AddC_out(13) = '1') OR
						   (AddC_out(14) = '1')) AND --2 group of conditions : positive (b15 ='0') and any bits[7,14] ='1';
						   (AddC_out(15) = '0')) ELSE '0'; --15 is the sign
	
	-- In negative, 0 is significant rather than 1
	-- not(cond_sat127) =/= cond_sat128
	cond_sat128 <= '1' WHEN (((AddC_out(7) = '0') OR --7 is included as it is the 8th bit of value
						   (AddC_out(8) = '0') OR 
						   (AddC_out(9) = '0') OR
						   (AddC_out(10) = '0') OR
						   (AddC_out(11) = '0') OR
						   (AddC_out(12) = '0') OR
						   (AddC_out(13) = '0') OR
						   (AddC_out(14) = '0')) AND --2 group of conditions : positive (b15 ='0') and any bits[7,14] ='1';
						   (AddC_out(15) = '1')) ELSE '0'; --15 is the sign
	
	-- These 2 conditions are mutually exclusive; One cannot be both below -128 and above 127

	
	sat_out <=  "01111111" WHEN (cond_sat127 = '1') ELSE
				"10000000" WHEN (cond_sat128 = '1') ELSE
				(AddC_out(15) & AddC_out(6 DOWNTO 0));
	--done <= '1' WHEN ((cond_sat127'EVENT) OR (cond_sat128'EVENT)) ELSE '0'; 

done <= '1' after 2 ns WHEN ((sat_out(0)'EVENT) OR (cond_sat127'EVENT) OR (cond_sat128'EVENT)) ELSE '0' after 4 ns;

-- Controlled time for done'uptime
ADONE <= done;
AOUT <= sat_out;
END adding;
	
							