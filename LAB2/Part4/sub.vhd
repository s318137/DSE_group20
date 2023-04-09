LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY sub IS
PORT (input,a : IN unsigned(5 DOWNTO 0);
		output : OUT unsigned(5 downto 0)
		);
END sub;

architecture behavior of sub is
begin
process (input)
begin
output <= input - a;
end process;
end behavior;