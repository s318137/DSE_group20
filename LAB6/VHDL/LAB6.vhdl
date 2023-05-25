LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LAB6 IS
	PORT(
	START : IN STD_LOGIC;
	DataIN : IN SIGNED(7 DOWNTO 0);
	
	CLK : IN STD_LOGIC;
	DONE : OUT STD_LOGIC;
	DataOUT : OUT SIGNED(7 DOWNTO 0)
	);
END LAB6;

ARCHITECTURE full OF LAB6 IS
	
	COMPONENT datapath IS
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
	END COMPONENT;
	
	COMPONENT FilterCU IS
		PORT(
		START : IN STD_LOGIC; 
		CLK : IN STD_LOGIC;
		FDONE : IN STD_LOGIC;
		CNTA, CNTB, COUNT : IN UNSIGNED(9 DOWNTO 0);
		DONE : OUT STD_LOGIC;
		RdA, RdB : OUT STD_LOGIC;
		WrA, WrB : OUT STD_LOGIC;
		CsA, CsB : OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT memX IS
		PORT(
		DIN : IN SIGNED(7 DOWNTO 0);
		ADDR : IN UNSIGNED(9 DOWNTO 0);
		CS : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		WR : IN STD_LOGIC;
		RD : IN STD_LOGIC;
		DOUT : OUT SIGNED(7 DOWNTO 0)
		);
	END COMPONENT;
	
--SIGNAL
--Addresses
SIGNAL AddrA, AddrB : UNSIGNED(9 DOWNTO 0) := (others => '0');

-- Wr
SIGNAL WrA, WrB : STD_LOGIC;

--Data
SIGNAL Data2Filter, Data2Store : SIGNED(7 DOWNTO 0);

--Selection
SIGNAL CsA, CsB : STD_LOGIC;

-- Read
SIGNAL RdA, RdB : STD_LOGIC;

--Filter done filtering
SIGNAL FilterDone : STD_LOGIC;

BEGIN

ControlUnit : FilterCU PORT MAP(START => START,
								CLK => CLK,
								FDONE => FilterDone,
								CNTA => AddrA,
								CNTB => AddrB,
								COUNT => AddrB,
								DONE => DONE,
								RdA => RdA,
								RdB => RdB,
								WrA => WrA,
								WrB => WrB,
								CsA => CsA,
								CsB => CsB);	

D1 : datapath PORT MAP(CSA => CsA,
					   CSB => CsB,
					   RDA => RdA,
					   RDB => RdB,
					   WRA => WrA,
					   WRB => WrB,
					   CLK => CLK,
					   START => START,
					   Sign2A => Data2Filter,
					   FDONE => FilterDone,
					   Sign2B => Data2Store,
					   ADDR_Ad => AddrA,
					   ADDR_Bd => AddrB);

memA : memX PORT MAP(DIN => DataIN,
					 ADDR => AddrA,
					 CS => CsA,
					 CLK => CLK,
					 WR => WrA,
					 RD => RdA,
					 DOUT => Data2Filter);

memB : memX PORT MAP(DIN => Data2Store,
					 ADDR => AddrB,
					 CS => CsB,
					 CLK => CLK,
					 WR => WrB,
					 RD => RdB,
					 DOUT => DataOUT);
					 


END full;
