library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulse_1hz is
port (clk,s_rst: in std_logic;
		pulse_out: out std_logic
		);
end pulse_1hz;

architecture behavior of pulse_1hz is

signal count : unsigned(27 downto 0);
signal int_rst : std_logic;

begin
pulse_out <= int_rst;
--as the counter approaces the value it resets in the next clock rise
process (count)
begin
if (count = x"2FAF07F") then
	int_rst <= '1';
else
	int_rst <= '0';
end if;
end process;

--counter
process (clk)
begin
if (clk'event and clk = '1') then
	if (s_rst = '1' and int_rst = '0') then
		count <= count + 1;
	else
		count <= (others => '0');
	end if;
end if;
end process;

end behavior;