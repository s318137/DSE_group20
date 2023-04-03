LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity SR_latch is
port (s,r,rst : in std_logic;
		output : out std_logic);
end SR_latch;

architecture behavior of SR_latch is
begin
process (s,r,rst)
begin
if (rst = '1') then
	if (s = '1') then
		output <= '1';
	elsif (r = '1') then
		output <= '0';
	end if;
else 
	output <= '0';
end if;
end process;
end behavior;