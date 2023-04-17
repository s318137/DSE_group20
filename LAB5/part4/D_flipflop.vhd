library ieee;
use ieee.std_logic_1164.all;

entity D_flipflop is
port (d,clk,rst : in std_logic;
		q : out std_logic);
end D_flipflop;

architecture behavior of D_flipflop is
begin
process (clk) 
begin
if (clk'event and clk = '1') then
	if (rst = '1') then
		q <= d;
	else
		q <= '0';
	end if;
end if;
end process;
end behavior;