LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY max_3b IS
PORT (input1,input2 : IN unsigned(2 DOWNTO 0);
		output : OUT unsigned(2 downto 0)
		);
END max_3b;

architecture behavior of max_3b is
begin
process (input1,input2)
begin
output <= input1;
if (input2 > input1) then
output <= input2;
end if;
end process;
end behavior;