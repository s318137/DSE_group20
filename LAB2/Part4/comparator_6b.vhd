LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY comparator_6b IS
PORT (v : IN UNSIGNED(5 DOWNTO 0);
		m : IN unsigned(5 DOWNTO 0);
		y : OUT STD_LOGIC);
END comparator_6b;

architecture behavior of comparator_6b is
begin
process (v)
begin
y <= '0';
if (v > m) then
y <= '1';
end if;
end process;
end behavior;