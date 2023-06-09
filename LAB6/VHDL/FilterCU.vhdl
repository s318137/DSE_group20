LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- The role of the control unit is to, obviously, control the filter and the memories

ENTITY FilterCU IS
	PORT(
	START : IN STD_LOGIC; 
	CLK : IN STD_LOGIC;
	
	-- Control input used in the control process
	FDONE : IN STD_LOGIC;
	CNTA, CNTB, COUNT : IN UNSIGNED(9 DOWNTO 0);
	
	--DONE signal
	DONE : OUT STD_LOGIC;
	
	--control signals
	RdA, RdB : OUT STD_LOGIC;
	WrA, WrB : OUT STD_LOGIC;
	CsA, CsB : OUT STD_LOGIC
	);
END FilterCU;

ARCHITECTURE controlling OF FilterCU IS

	TYPE State_type IS (STRT, DATA_IN, FILTER, DATA_OUT, DNE);
	SIGNAL Y_Q, Y_D : State_type; -- y_Q is present state, y_D is next state
	SIGNAL Done_out : STD_LOGIC := '0';
	SIGNAL WrA_out, WrB_out : STD_LOGIC := '1'; 
	SIGNAL CsA_out, CsB_out : STD_LOGIC := '0';
	SIGNAL RdA_out, RdB_out : STD_LOGIC;
	
	--The choice of a case system is easy: 
	-- it follows easily the design scheme 
	
	BEGIN

	
		PROCESS (Y_Q) -- state table
			BEGIN
			
				CASE Y_Q IS
					WHEN STRT => 
					
					-- Each of these states change some of the variables
					WrA_out <= '1';
					WrB_out <= '1';
					CsA_out <= '0';
					CsB_out <= '0';
					RdA_out <= '0';
					RdB_out <= '0';
					Done_out <= '0';
					IF (START = '1' AND Done_out = '0') THEN 
						Y_D <= DATA_IN;
					ELSE --Every of these ELSE {'future_state' <= 'current_state'} is to stop any infinite loop
						Y_D <= STRT;
					END IF;
					
					WHEN DATA_IN => 
					WrA_out <= '0';
					CsA_out <= '1';
					IF ((CsA_out = '1') AND (WrA_out = '1') AND (CNTA = "1111111111")) THEN 
						Y_D <= FILTER;
					ELSE 
						Y_D <= DATA_IN;
					END IF;
					
					WHEN FILTER => 
					CsB_out <= '1';
					WrB_out <= '0';
					WrA_out <= '1';
					RdA_out <= '1';
					IF ((CsA_out = '1') AND (CsB_out = '1') AND (WrB_out = '0') AND (COUNT = "1111111111") AND (FDONE = '1')) THEN 
						Y_D <= DATA_OUT;
					ELSE 
						Y_D <= FILTER;
					END IF;
					
					WHEN DATA_OUT => 
					WrB_out <= '1';
					CsA_out <= '0';
					RdA_out <= '0';
					RdB_out <= '1';
					IF ((CNTB = "1111111111") AND (CsA_out = '1') AND (WrB_out = '0')) THEN 
						Y_D <= DNE;
					ELSE 
						Y_D <= DATA_OUT;
					END IF;
					
					WHEN DNE => 
					Done_out <= '1';
					IF ((Done_out = '1')) THEN 
						Y_D <= STRT;
					ELSE 
						Y_D <= DNE;
					END IF;
					
				
				-- other states
				
				END CASE;
		END PROCESS; -- state table

		PROCESS (CLK) -- state flip-flops
			BEGIN
				IF (CLK'EVENT AND CLK = '1') THEN
					Y_Q <= Y_D; --Clock based change of state
				END IF; 
		END PROCESS;
--Output assignments

DONE <= Done_out;
RdA <= RdA_out;
RdB <= RdB_out;
WrA <= WrA_out;
WrB <= WrB_out;
CsA <= CsA_out;
CsB <= CsB_out;

END controlling;