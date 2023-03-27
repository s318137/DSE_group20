LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity part2_2 is
port (sw : in std_logic_vector(9 downto 0);
		key : in std_logic_vector(3 downto 0);
		hex0,hex1,hex2,hex3 : out std_logic_vector(0 to 6)
		);
end part2_2;

architecture structure of part2_2 is
component hex_decoder is
port (input : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(0 to 6)
		);
end component;

component part2_1 is
port (clk,rst,en : in std_logic;
		output : buffer std_logic_vector(15 downto 0);
		tap_out : out std_logic
		);
end component;
signal counter_out : std_logic_vector(15 downto 0);
signal tap : std_logic;
begin
counter : part2_1 port map(key(0),sw(0),sw(1),counter_out,tap);
dec1 : hex_decoder port map(counter_out(15 downto 12),hex3);
dec2 : hex_decoder port map(counter_out(11 downto 8),hex2);
dec3 : hex_decoder port map(counter_out(7 downto 4),hex1);
dec4 : hex_decoder port map(counter_out(3 downto 0),hex0);
end structure;