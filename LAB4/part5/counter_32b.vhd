LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity counter_32b is
port (rst,clk,en: IN STD_LOGIC; 
      output : buffer unsigned(31 downto 0)
		);
end counter_32b;

architecture behavior of counter_32b is
begin
process (clk)
begin
if (clk'event and clk = '1') then
	if (en = '1' and rst = '1') then
		output <= output + 1;
	elsif (rst = '0') then
		output <= x"00000000";
	end if;
end if;
end process;
end behavior;