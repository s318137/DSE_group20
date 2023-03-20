LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY circuitA IS
PORT (v : IN UNSIGNED(2 DOWNTO 0);
		m : OUT unsigned(2 DOWNTO 0)
		);
END circuitA;

architecture behavior of circuitA is
begin
process (v)
begin
m <= "000";
if (v >= 2) then
m <= v-2;
end if;
end process;
end behavior;