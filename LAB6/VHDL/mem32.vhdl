LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--Simplified, more precise version of memX, dedicated to only 32 bits

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
		Aout, Bout, Cout, Dout : OUT SIGNED(7 DOWNTO 0)
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
	CONSTANT N : INTEGER := 3;
	
SIGNAL memAdd : STD_LOGIC := '0';
SIGNAL AddrA_trans : SIGNED(9 DOWNTO 0);
SIGNAL FULL_out : STD_LOGIC;
SIGNAL FETCH_fin : STD_LOGIC := '0';


BEGIN
	
PROCESS
	
BEGIN
	j <= 0;
	FETCH_fin <= '0';
	AddrN <= (3 + to_integer(COUNT));
	report "j_init =" & integer'image(j);
	report "AddrN =" & integer'image(AddrN);
	
	WAIT ON CLK;
	
	IF ((AddrN - j) < 3) THEN
	
			mem_data(j) <= x"00";
			memAdd <= '1';
			report "add done as case mem_data(j) = 0x'00'" ;
		
	ELSE 
			mem_data(j) <= DIN;
			memAdd <= '1';
			report "add done as data, case mem_data(j) = DIN";			--typecast to get it right
		 --will copy what is given to him
	END IF;
	
	WAIT UNTIL (memAdd ='1');
	report "memAdd";
	memAdd <= '0';
	
	j <= j+1;
	AddrA_out <= to_signed(AddrN - j, (AddrA_out'LENGTH));
	WAIT FOR 0.5 ns;
	report "cycle =" & integer'image(j);
	
	IF ((AddrN - j) < 3) THEN
	
			mem_data(j) <= x"00";
			memAdd <= '1';
			report "add done as case mem_data(j) = 0x'00'" ;
		
	ELSE 
			mem_data(j) <= DIN;
			memAdd <= '1';
			report "add done as data, case mem_data(j) = DIN";			--typecast to get it right
		 --will copy what is given to him
	END IF;
	
	WAIT UNTIL (memAdd ='1');
	report "memAdd";
	memAdd <= '0';
	
	j <= j+1;
	AddrA_out <= to_signed(AddrN - j, (AddrA_out'LENGTH));
	WAIT FOR 0.5 ns;

	
	IF ((AddrN - j) < 3) THEN
	
			mem_data(j) <= x"00";
			memAdd <= '1';
			report "add done as case mem_data(j) = 0x'00'" ;
		
	ELSE 
			mem_data(j) <= DIN;
			memAdd <= '1';
			report "add done as data, case mem_data(j) = DIN";			--typecast to get it right
		 --will copy what is given to him
	END IF;
	
	WAIT UNTIL (memAdd ='1');
	report "memAdd";
	memAdd <= '0';
	
	j <= j+1;
	AddrA_out <= to_signed(AddrN - j, (AddrA_out'LENGTH));
	WAIT FOR 0.5 ns;

	
	IF ((AddrN - j) < 3) THEN
	
			mem_data(j) <= x"00";
			memAdd <= '1';
			report "add done as case mem_data(j) = 0x'00'" ;
		
	ELSE 
			mem_data(j) <= DIN;
			memAdd <= '1';
			report "add done as data, case mem_data(j) = DIN";			--typecast to get it right
		 --will copy what is given to him
	END IF;
	
	WAIT UNTIL (memAdd ='1');
	report "memAdd";
	memAdd <= '0';
	
	AddrA_out <= to_signed(AddrN - j, (AddrA_out'LENGTH));
	WAIT FOR 0.5 ns;

	FETCH_fin <= '1';

END PROCESS;

PROCESS
BEGIN
	-- as default, done = 0
	FULL_out <= '0';
	
	WAIT ON FETCH_fin; -- when updated (computation completed) : 
	
	FULL_out <= '1'; --done up for 2 ns, then back to 0
	
	WAIT FOR 2 ns;
	-- in practice, a 2 ns uptime
END PROCESS;

A <= mem_data(0) WHEN (RD = '1' AND CS='1') ELSE
	 (others => '0');
B <= mem_data(1) WHEN (RD = '1' AND CS='1') ELSE
	 (others => '0');
C <= mem_data(2) WHEN (RD = '1' AND CS='1') ELSE
	 (others => '0');
D <= mem_data(3) WHEN (RD = '1' AND CS='1') ELSE
	 (others => '0');
	
Aout <= A;
Bout <= B;
Cout <= C;
Dout <= D;

FULL <= FULL_out;

AddrA_trans <= (others => '0') WHEN ((AddrN- j) < 3) ELSE
			   AddrA_out;

ADDR_A <= UNSIGNED(STD_LOGIC_VECTOR(AddrA_trans(9 DOWNTO 0))); --driving the address in order to fetch things from memA

END Behaviour;