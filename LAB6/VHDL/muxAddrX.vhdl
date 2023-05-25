LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

--remix code of https://github.com/s318137/DSE_group20/blob/main/LAB3/Part1/mux2to1_1b.vhd

--As you cannot drive the same signal by 2 different sources in VHDL (rather it does produce X or U values)
--a mux has to be used. Here, they are used for the choice of the source of ADDR_A/B


entity muxAddrX is
	port (a,b : IN UNSIGNED(9 DOWNTO 0);
		  sel : in std_logic;
		  y : OUT UNSIGNED(9 DOWNTO 0));
end muxAddrX;



architecture behavior of muxAddrX is

begin
process (a,b,sel)
begin
		y <= a;
	if sel = '1' then 
		y <= b;
	end if;
end process;
end behavior;