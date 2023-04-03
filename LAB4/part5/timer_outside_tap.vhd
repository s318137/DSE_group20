LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity timer_outside_tap is
port (clk,en,rst : in std_logic;
		ref : in unsigned(31 downto 0);
		display_out : out std_logic_vector(0 to 6)
		);
end timer_outside_tap;

architecture structure of timer_outside_tap is
component hex_decoder IS
port (input : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(0 to 6)
		);
END component;

component comparator_4b is
port (input, ref : in unsigned(3 downto 0);
		output : out std_logic);
end component;

component counter_4b is
port (clk,en,rst : in std_logic;
		output : buffer unsigned(3 downto 0)
		);
end component;

component pulse_outside_tap is
port (clk,en,rst : in std_logic;
		pulse_out : out std_logic;
		ref : in unsigned(31 downto 0)
		);
end component;
signal counter_rst,pulse_out,comp_out : std_logic;
signal counter_out : unsigned(3 downto 0);
begin
pulse : pulse_outside_tap port map(clk,en,rst,pulse_out,ref);
counter : counter_4b port map(clk,pulse_out,counter_rst,counter_out);
counter_rst <= not(comp_out) and rst;
comp : comparator_4b port map(counter_out,"1010",comp_out);
decoder : hex_decoder port map(std_logic_vector(counter_out),display_out);
end structure;