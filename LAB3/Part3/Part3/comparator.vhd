LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY comparator IS
PORT (v : IN UNSIGNED(3 DOWNTO 0);
		m : IN unsigned(3 DOWNTO 0);
		y : OUT STD_LOGIC);
END comparator;

architecture behavior of comparator is
begin
process (v)
begin
y <= '0';
if (v > m) then
y <= '1';
end if;
end process;
end behavior;