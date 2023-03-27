LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity part2_2 is
port (SW : in std_logic_vector(9 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		HEX0,HEX1,HEX2,HEX3 : out std_logic_vector(0 to 6)
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
counter : part2_1 port map(KEY(0),SW(0),SW(1),counter_out,tap);
dec1 : hex_decoder port map(counter_out(15 downto 12),HEX3);
dec2 : hex_decoder port map(counter_out(11 downto 8),HEX2);
dec3 : hex_decoder port map(counter_out(7 downto 4),HEX1);
dec4 : hex_decoder port map(counter_out(3 downto 0),HEX0);
end structure;