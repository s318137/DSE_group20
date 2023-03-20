LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux2to1_1b is
port (a,b,sel : in std_logic;
		y : out std_logic);
end mux2to1_1b;

architecture behavior of mux2to1_1b is
begin
process (a,b,sel)
begin
y <= a;
if sel = '1' then y <= b;
end if;
end process;
end behavior;