
FOR j IN 0 TO 3 LOOP

	--AddrN <= SIGNED('0' & STD_LOGIC_VECTOR(COUNT(9 DOWNTO 0))); --expand by concatenation to keep data and transform into signed
	AddrN <= (4 + to_integer(COUNT));
	fetch_j <= j;
	report "j=" & integer'image(j); 	-- This is to prevent int 32 bit neg overflow
	-- Transforming unsigned to a vector allows the & op. and gives the possibility to cast into SIGNED type
		
		IF ((AddrN - j) < 4) THEN --the interest of the expansion, to -n the address

			mem_data(j) <= x"00"; --if the index is negative, mem32(j) = 0

		ELSE
			
			AddrA_out <= to_signed(to_integer(COUNT - j), (AddrA_out'LENGTH)); --intermediate signal
			
			-- Tricking vhdl with STD_LOGIC_VECTOR

			IF (CS = '1') THEN --waiting clock update (because change of memory access is clock based)
				IF (not(WR) = '1' AND RD='0') THEN
			
					mem_data(j) <= DIN; --typecast to get it right
		
				END IF; --will copy what is given to him

			ELSE

				mem_data(j) <= mem_data(j); --while it is not clock updated, memory stays the same

			END IF;

		END IF;
	wait until (CLK'EVENT);
	END LOOP;

-- 2ieme partie
	
	
	IF (CS = '1' AND WR = '0' AND RD='0') THEN
		IF ((AddrN - j) < 4) THEN
	
			mem_data(j) <= x"00";
			memAdd <= '1';
		
		ELSE 
			mem_data(j) <= DIN;
			memAdd <= '1';			--typecast to get it right
		 --will copy what is given to him
		END IF;
	END IF;
	
	WAIT ON memAdd;
	
	memAdd <= '0';
	
	j <= j+1;
	AddrA_out <= to_signed(to_integer(COUNT - j), (AddrA_out'LENGTH));
	WAIT FOR 1 ns;
	
	IF (CLK'EVENT AND CLK='1' AND CS = '1' AND WR = '0' AND RD='0') THEN
		IF ((AddrN - j) < 4) THEN
	
			mem_data(j) <= x"00";
			memAdd <= '1';
		
		ELSE 
			mem_data(j) <= DIN; 
			memAdd <= '1';
			--typecast to get it right
			--will copy what is given to him
		END IF;
	END IF;
	
	WAIT ON memAdd;
	
	memAdd <= '0';
	
	j <= j+1;
	AddrA_out <= to_signed(to_integer(COUNT - j), (AddrA_out'LENGTH));
	WAIT FOR 1 ns;
	
	IF (CLK'EVENT AND CLK='1' AND CS = '1' AND WR = '0' AND RD='0') THEN
		IF ((AddrN - j) < 4) THEN
	
			mem_data(j) <= x"00";
			memAdd <= '1';
		
		ELSE 
			mem_data(j) <= DIN; 
			memAdd <= '1';
			--typecast to get it right
			--will copy what is given to him
		END IF;
	END IF;
	
	WAIT ON memAdd;
	
	memAdd <= '0';
	
	j <= j+1;
	AddrA_out <= to_signed(to_integer(COUNT - j), (AddrA_out'LENGTH));
	WAIT FOR 1 ns;
	