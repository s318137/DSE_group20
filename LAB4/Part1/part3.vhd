LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity part3 is
port (clk,en,rst : in std_logic;
		output : buffer unsigned(15 downto 0));
end part3;

architecture behavior of part3 is
begin
process (clk, rst)
begin

if (rst = '1' ) then
	if (clk'event and clk = '1') then 
		if (en = '1') then
		output <= output + 1;
		end if;
	end if;
else
	output <= (others => '0');
end if;

end process;
end behavior;