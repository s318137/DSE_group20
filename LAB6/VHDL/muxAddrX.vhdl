LIBRARY ieee;
USE ieee.std_logic_1164.all;

--remix code of https://github.com/s318137/DSE_group20/blob/main/LAB3/Part1/mux2to1_1b.vhd


entity mux2to1_1b is
	port (a,b : IN UNSIGNED(9 DOWNTO 0);
		  sel : in std_logic;
		  y : OUT UNSIGNED(9 DOWNTO 0));
end mux2to1_1b;



architecture behavior of mux2to1_1b is

begin
process (a,b,sel)
begin
		y <= a;
	if sel = '1' then 
		y <= b;
	end if;
end process;
end behavior;