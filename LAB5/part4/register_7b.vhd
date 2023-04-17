library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_7b is
port (load_in : in std_logic_vector(0 to 6);
		output : out std_logic_vector(0 to 6);
		clk,load_en,rst : in std_logic
		);
end register_7b;

architecture behavior of register_7b is
begin
process (clk) 
begin
if (clk'event and clk = '1') then
	if (rst = '1') then
		if (load_en = '1') then
			output <= load_in;
		end if;
	else
		output <= (others => '1');
	end if;
end if;
end process;
end behavior;