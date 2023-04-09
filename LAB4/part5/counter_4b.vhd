LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity counter_4b is
port (clk,en,rst : in std_logic;
		output : buffer unsigned(3 downto 0)
		);
end counter_4b;

architecture behavior of counter_4b is
begin
process (clk)
begin
if (clk'event and clk = '1') then
	if (en = '1' and rst = '1') then
		output <= output + 1;
	elsif (rst = '0') then
		output <= x"0";
	end if;
end if;
end process;
end behavior;