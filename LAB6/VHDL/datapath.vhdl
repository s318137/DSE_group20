LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--Entire datapath
--"componized"



ENTITY datapath IS
	PORT(
	
	);
END datapath;


--On the architecture :
--	3 main logical components, the 2 counters and the filter
-- To adhere to vhdl code standards, 2 multiplexers are also used

ARCHITECTURE Complete_Structure OF datapath IS

	COMPONENT comp_filter IS
	PORT(
	
	);
	END COMPONENT;

	COMPONENT counterRDB IS
	PORT (
		CLK, CsB, WrB : IN std_logic;
		CNTB : BUFFER unsigned(10 DOWNTO 0) -- CouNTB
	);
	END COMPONENT;
	
	COMPONENT counterRDB IS
	PORT (
		CLK, CsA, WrA : IN std_logic;
		CNTA : BUFFER unsigned(10 DOWNTO 0) -- CouNTA 
	);
	END COMPONENT;
	
	COMPONENT muxAddrX is
	port (a,b : IN UNSIGNED(9 DOWNTO 0);
		  sel : in std_logic;
		  y : OUT UNSIGNED(9 DOWNTO 0));
	end COMPONENT;
	
BEGIN



END Complete_Structure;