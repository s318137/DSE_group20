LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity comparator_4b is
port (input, ref : in unsigned(3 downto 0);
		output : out std_logic);
end comparator_4b;

architecture behavior of comparator_4b is
begin
process (input)
begin
if (input >= ref) then 
	output <= '1';
else 
	output <= '0';
end if;
end process;
end behavior;