LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--In terms of memory, it is the same logic as memX
-- But it gains a fetch system

ENTITY mem32 IS
	PORT(
		DIN : IN SIGNED(7 DOWNTO 0);
		CS : IN STD_LOGIC;
		COUNT : IN UNSIGNED(9 DOWNTO 0); 
		CLK : IN STD_LOGIC;
		WR : IN STD_LOGIC;
		RD : IN STD_LOGIC;
		FULL : OUT STD_LOGIC;
		ADDR_A : OUT UNSIGNED(9 DOWNTO 0);
		Aout, Bout, Cout, Dout : OUT SIGNED(7 DOWNTO 0) --4x8 output signals
	);	
END mem32;


ARCHITECTURE Behaviour OF mem32 IS
TYPE mem_array IS ARRAY (0 TO 3) OF SIGNED(7 DOWNTO 0);
-- b"U....U" for binary format; x"UU" for hex

SIGNAL mem_data : mem_array :=(
   x"00",x"00",x"00",x"00"-- 0x00: 
);

SIGNAL A, B, C, D : SIGNED(7 DOWNTO 0);
--SIGNAL AddrN : SIGNED(10 DOWNTO 0) := (others => '0'); -- if AddrN is signed
SIGNAL AddrN : INTEGER := 0;
SIGNAL AddrA_out : SIGNED(9 DOWNTO 0) := (others => '0'); 
SIGNAL fetch_j : INTEGER := 0;
SIGNAL j : INTEGER := 0;

	
SIGNAL memAdd : STD_LOGIC := '0';
--Output signals
SIGNAL AddrA_trans : SIGNED(9 DOWNTO 0);
SIGNAL FULL_out : STD_LOGIC;
SIGNAL FETCH_fin : STD_LOGIC := '0';


BEGIN
	
PROCESS
-- fething and writing process
-- PROCESS cycle : Beginning => End => Beginning => ....
-- It is exploited here	
BEGIN
	-- reset
	j <= 0;
	FETCH_fin <= '0'; --fetch_finished
	AddrN <= (3 + to_integer(COUNT)); -- (j < 0) does not equal negative int, rather (2^32 -1) - 1
	-- There is only 3 negative case possible, as such +3 
	
	-- No loop statement
	-- any <sensitivity_list> process (if, loop, while) DOES NOT support any WAIT statements;
	
	WAIT ON CLK;
	
	IF ((AddrN - j) < 3) THEN -- Below 0+3
	
			mem_data(j) <= x"00"; --0 instead of the data
			memAdd <= '1';
			--report "add done as case mem_data(j) = 0x'00'" ;
		
	ELSE 
			mem_data(j) <= DIN;
			memAdd <= '1';
			--report "add done as data, case mem_data(j) = DIN";			
	END IF;
	WAIT UNTIL (memAdd ='1'); 
	--report "memAdd";
	memAdd <= '0';
	
	j <= j+1;
	AddrA_out <= to_signed(AddrN - j, (AddrA_out'LENGTH));
	WAIT FOR 0.5 ns; -- time to settle for both the mem32 and memX component
	--report "cycle =" & integer'image(j);
	
	--Exact same if case as before
	IF ((AddrN - j) < 3) THEN
	
			mem_data(j) <= x"00";
			memAdd <= '1';
			--report "add done as case mem_data(j) = 0x'00'" ;
		
	ELSE 
			mem_data(j) <= DIN;
			memAdd <= '1';
			--report "add done as data, case mem_data(j) = DIN";			--typecast to get it right
		 --will copy what is given to him
	END IF;
	
	WAIT UNTIL (memAdd ='1');
	report "memAdd";
	memAdd <= '0';
	
	j <= j+1;
	AddrA_out <= to_signed(AddrN - j, (AddrA_out'LENGTH));
	WAIT FOR 0.5 ns;

	--Exact same if case as before
	IF ((AddrN - j) < 3) THEN
	
			mem_data(j) <= x"00";
			memAdd <= '1';
			--report "add done as case mem_data(j) = 0x'00'" ;
		
	ELSE 
			mem_data(j) <= DIN;
			memAdd <= '1';
			--report "add done as data, case mem_data(j) = DIN";			--typecast to get it right
		 --will copy what is given to him
	END IF;
	
	WAIT UNTIL (memAdd ='1');
	--report "memAdd";
	memAdd <= '0';
	
	j <= j+1;
	AddrA_out <= to_signed(AddrN - j, (AddrA_out'LENGTH));
	WAIT FOR 0.5 ns;

	--Exact same if case as before
	IF ((AddrN - j) < 3) THEN
	
			mem_data(j) <= x"00";
			memAdd <= '1';
			--report "add done as case mem_data(j) = 0x'00'" ;
		
	ELSE 
			mem_data(j) <= DIN;
			memAdd <= '1';
			--report "add done as data, case mem_data(j) = DIN";			--typecast to get it right
		 --will copy what is given to him
	END IF;
	
	WAIT UNTIL (memAdd ='1');
	--report "memAdd";
	memAdd <= '0';
	
	AddrA_out <= to_signed(AddrN - j, (AddrA_out'LENGTH));
	FETCH_fin <= '1';
	WAIT FOR 0.5 ns;

END PROCESS;

-- Signal to allow the adder to add
PROCESS 
BEGIN
	-- as default, done = 0
	FULL_out <= '0';
	
	WAIT ON FETCH_fin; -- when updated (computation completed) : 
	
	FULL_out <= '1'; --done up for 2 ns, then back to 0
	
	WAIT FOR 2 ns;
	-- in practice, a 2 ns uptime
END PROCESS;


-- Output assignments
A <= mem_data(0) WHEN (RD = '1' AND CS='1') ELSE
	 (others => '0'); -- ELSE {(others => '0')}; is not to have U bits
B <= mem_data(1) WHEN (RD = '1' AND CS='1') ELSE
	 (others => '0');
C <= mem_data(2) WHEN (RD = '1' AND CS='1') ELSE
	 (others => '0');
D <= mem_data(3) WHEN (RD = '1' AND CS='1') ELSE
	 (others => '0');

-- Can't assign the WHEN ELSE case directly to a OUT signal	
Aout <= A;
Bout <= B;
Cout <= C;
Dout <= D;

FULL <= FULL_out;

-- 
AddrA_trans <= (others => '0') WHEN ((AddrN- j) < 3) ELSE
			   AddrA_out;

ADDR_A <= UNSIGNED(STD_LOGIC_VECTOR(AddrA_trans(9 DOWNTO 0))); --driving the address in order to fetch things from memA

END Behaviour;
