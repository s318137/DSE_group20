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

SIGNAL A, B, C, D : SIGNED(7 DOWNTO 0) := (others => '0');
--SIGNAL AddrN : SIGNED(10 DOWNTO 0) := (others => '0'); -- if AddrN is signed
SIGNAL AddrN : INTEGER;
SIGNAL AddrA_out : SIGNED(10 DOWNTO 0); 



BEGIN
PROCESS(CLK)
BEGIN
	IF (WR = '0' AND CS = '1') THEN
	FOR j IN 0 TO 3 LOOP

	--AddrN <= SIGNED('0' & STD_LOGIC_VECTOR(COUNT(9 DOWNTO 0))); --expand by concatenation to keep data and transform into signed
	AddrN <= (4 + to_integer(COUNT)); -- This is to prevent int 32 bit neg overflow
	-- Transforming unsigned to a vector allows the & op. and gives the possibility to cast into SIGNED type
		
		IF ((AddrN - j) < 4) THEN --the interest of the expansion, to -n the address

			mem_data(j) <= x"00"; --if the index is negative, mem32(j) = 0

		ELSE
			
			AddrA_out <= to_signed(to_integer(COUNT - j), (AddrA_out'LENGTH)); --intermediate signal
			ADDR_A <= UNSIGNED(STD_LOGIC_VECTOR(AddrA_out(9 DOWNTO 0))); --driving the address in order to fetch things from memA
			-- Tricking vhdl with STD_LOGIC_VECTOR

			IF (CLK'EVENT AND CLK='1') THEN --waiting clock update (because change of memory access is clock based)

				mem_data(j) <= DIN; --will copy what is given to him

			ELSE

				mem_data(j) <= mem_data(j); --while it is not clock updated, memory stays the same

			END IF;

		END IF;

	END LOOP;
	END IF;
END PROCESS;

PROCESS(CLK) -- output
BEGIN
		IF (RD = '1' AND CS='1') THEN
			Aout <= mem_data(0);
			Bout <= mem_data(1);
			Cout <= mem_data(2);
			Dout <= mem_data(3);
			
		ELSE
			Aout <= (others => '0');
			Bout <= (others => '0');
			Cout <= (others => '0');
			Dout <= (others => '0');
			
		END IF;
END PROCESS;

END Behaviour;