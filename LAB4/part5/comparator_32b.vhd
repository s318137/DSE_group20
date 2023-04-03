LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity comparator_32b is
port (input,ref : in unsigned(31 downto 0);
		output : out std_logic
		);
end comparator_32b;

architecture behavior of comparator_32b is
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