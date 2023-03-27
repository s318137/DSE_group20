LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY T_flipflop IS
PORT ( Clk, T ,clr: IN STD_LOGIC;
       Q : buffer STD_LOGIC);
END T_flipflop;

ARCHITECTURE behavior OF T_flipflop IS
BEGIN
process (clk,clr)
begin
if (clr = '1') then
	if (Clk'event and clk = '1') then
		if (T = '1') then
			Q <= not(Q);
		end if;
	end if;
else
	Q <= '0';
end if;
end process;
END behavior;
