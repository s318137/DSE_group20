LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--Entire datapath
--"componized"



ENTITY datapath IS
	PORT(
		CSA, CSB : IN STD_LOGIC;
		RDA, RDB : IN STD_LOGIC;
		WRA, WRB : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		
		START : STD_LOGIC;
		
		Sign2A : IN SIGNED(7 DOWNTO 0);
		
		FDONE : OUT STD_LOGIC;
		
		Sign2B : OUT SIGNED(7 DOWNTO 0);
		ADDR_Ad, ADDR_Bd : OUT UNSIGNED(9 DOWNTO 0)
	);
END datapath;


--On the architecture :
--	3 main logical components, the 2 counters and the filter
-- To adhere to vhdl code standards, 2 multiplexers are also used

ARCHITECTURE Complete_Structure OF datapath IS

	COMPONENT comp_filter IS
	PORT(
		CLK : IN STD_LOGIC;
		START : IN STD_LOGIC;
		RDA : IN STD_LOGIC;
		WRA : IN STD_LOGIC;
		CS : IN STD_LOGIC;
		X : IN SIGNED(7 DOWNTO 0);
		Y : OUT SIGNED(7 DOWNTO 0);
		ADDR_A_fetch : OUT UNSIGNED(9 DOWNTO 0);
		FiltDONE : OUT STD_LOGIC;
		COUNT : OUT UNSIGNED(9 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT counterRDB IS
	PORT (
		CLK, CsB, WrB : IN std_logic;
		CNTB : BUFFER unsigned(9 DOWNTO 0) -- CouNTB
	);
	END COMPONENT;
	
	COMPONENT counterWRA IS
	PORT (
		CLK, CsA, WrA : IN std_logic;
		CNTA : BUFFER unsigned(9 DOWNTO 0) -- CouNTA 
	);
	END COMPONENT;
	
	COMPONENT muxAddrX is
	port (a,b : IN UNSIGNED(9 DOWNTO 0);
		  sel : in std_logic;
		  y : OUT UNSIGNED(9 DOWNTO 0));
	end COMPONENT;
	
-- SIGNALS


	-- ADDR_X
	SIGNAL CNTB_out, CNTA_out : UNSIGNED(9 DOWNTO 0);
	SIGNAL ADDR_A_fetch, COUNT : UNSIGNED(9 DOWNTO 0);
	
	--Selectors
	SIGNAL SelA, SelB : STD_LOGIC := '0';
	
	
BEGIN

comp_filter_1 : comp_filter PORT MAP(CLK => CLK,
									 START => START,
									 RDA => RDA,
									 WRA => WRA,
									 CS => CSA,
									 X => Sign2A,
									 Y => Sign2B,
									 ADDR_A_fetch => ADDR_A_fetch,
									 FiltDONE => FDONE,
									 COUNT => COUNT
									 );

counterRDB_1 : counterRDB PORT MAP(CLK => CLK,
								   CsB => CSB,
								   WrB => WRB,
								   CNTB => CNTB_out);

counterWRA_1 : counterWRA PORT MAP(CLK => CLK,
								   CsA => CSA,
								   WrA => WRA,
								   CNTA => CNTA_out);

SelA <= RDA;

SelB <= RDB;

muxAddrA : muxAddrX PORT MAP(a => CNTA_out,
							 b => ADDR_A_fetch,
							 sel => SelA,
							 y => ADDR_Ad);

muxAddrB : muxAddrX PORT MAP(a => COUNT,
							 b => CNTB_out,
							 sel => SelB,
							 y => ADDR_Bd);



END Complete_Structure;
