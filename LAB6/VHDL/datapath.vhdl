LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--Entire datapath
--"componized"



ENTITY datapath IS
	PORT(
	CsA, CsB : IN STD_LOGIC; 
	WrA, WrB : IN STD_LOGIC;

	AddrA, AddrB : OUT UNSIGNED(9 DOWNTO 0);
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
	
	COMPONENT counterWRA IS
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

--SIGNALS
--Addresses signal for A and B
SIGNAL FiltA : UNSIGNED(9 DOWNTO 0) := (others => '0');
SIGNAL FiltB : UNSIGNED(9 DOWNTO 0) := (others => '0');

SIGNAL countA : UNSIGNED(9 DOWNTO 0) := (others => '0');
SIGNAL countB : UNSIGNED(9 DOWNTO 0) := (others => '0');

SIGNAL AddrA_out, AddrB_out : UNSIGNED(9 DOWNTO 0);

BEGIN
--=>
filter : comp_filter PORT MAP();

-- Counters 
counterWRA : counterWRA PORT MAP(CLK => CLK,
								 CsA => CsA,
								 WrA => WrA,
								 CNTA => countA);

counterRDB : counterRDB PORT MAP(CLK => CLK,
								 CsB => CsB,
								 WrB => WrB,
								 CNTB => countB);


muxA : muxAddrX PORT MAP(a => FiltA,
						 b => countA,
						 sel =>  ,
						 y => AddrA_out);

muxB : muxAddrX PORT MAP(a => FiltB,
						 b => countB,
						 sel => ,
						 y => AddrB_out);

--output assignment

AddrA = AddrA_out;
AddrB = AddrB_out;

END Complete_Structure;