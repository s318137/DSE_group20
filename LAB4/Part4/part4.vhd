LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity part4 is
port (sw : in std_logic_vector(9 downto 0);
		CLOCK_50 : in std_logic;
		hex0 : out std_logic_vector(0 to 6)
		);
end part4;

architecture structure of part4 is
component timer_outside_tap is
port (clk,en,rst : in std_logic;
		ref : in unsigned(31 downto 0);
		display_out : out std_logic_vector(0 to 6)
		);
end component;
begin --sw 0 is reset signal, active low
timer : timer_outside_tap port map (clock_50,'1',sw(0),x"02FAF07F",hex0);
end structure;