LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity pulse_outside_tap is
port (clk,en,rst : in std_logic;
		pulse_out : out std_logic;
		ref : in unsigned(31 downto 0)
		);
end pulse_outside_tap;

architecture structure of pulse_outside_tap is
component counter_32b is
port (rst,clk,en: IN STD_LOGIC; 
      output : buffer unsigned(31 downto 0)
		);
end component;
component comparator_32b is
port (input,ref : in unsigned(31 downto 0);
		output : out std_logic
		);
end component;

signal counter_rst,comp_out : std_logic;
signal counter_out : unsigned(31 downto 0);

begin
counter : counter_32b port map (counter_rst,clk,en,counter_out);
comparator : comparator_32b port map(counter_out,ref,comp_out);
counter_rst <= not(comp_out) and rst;
pulse_out <= comp_out;
end structure;