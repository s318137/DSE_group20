LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity part2 is
port (SW : in std_logic_vector(9 downto 0);
		HEX0,HEX1,HEX2,HEX3,HEX4 : out std_logic_vector(0 to 6)
		);
end part2;

architecture structure of part2 is

	component mux_3bit_5to1 is
	port (sel0,sel1 : in std_logic;
		a,b,c,d : in std_logic_vector(14 downto 0);
		y : out std_logic_vector(14 downto 0));
	end component;

	component shifter is
	port (in0,in1,in2 : in std_logic;
		input : in std_logic_vector(14 downto 0);
		output : out std_logic_vector(14 downto 0)
		);
	end component;

	component char_7seg is
	port (c : in std_logic_vector(2 downto 0);
		display : out std_logic_vector(0 to 6)
		);
	end component;

signal out1,out2 : std_logic_vector(14 downto 0);

begin
mux0 : mux_3bit_5to1 port map (sel0 => sw(0),sel1 => sw(1),a => "000001010010011",b => "100001101101011",c => "100001010010011",d => "110001101101011",y => out1);
shi0 : shifter port map (in0 => sw(2),in1 => sw(3),in2 => sw(4),input => out1, output => out2);
dec0 : char_7seg port map (out2(2 downto 0),HEX0);
dec1 : char_7seg port map (out2(5 downto 3),HEX1);
dec2 : char_7seg port map (out2(8 downto 6),HEX2);
dec3 : char_7seg port map (out2(11 downto 9),HEX3);
dec4 : char_7seg port map (out2(14 downto 12),HEX4);
end structure;