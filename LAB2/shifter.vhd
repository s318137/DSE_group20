LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity shifter is
	port (in0,in1,in2 : in std_logic;
		input : in std_logic_vector(14 downto 0);
		output : out std_logic_vector(14 downto 0)
		);
	end shifter;

architecture structure of shifter is
	component shifter_15in_3b is 
	port (sel : in std_logic;
		input : in std_logic_vector(14 downto 0);
		output : out std_logic_vector(14 downto 0)
		);
	end component;

signal out1,out2,out3,out4,out5,out6 : std_logic_vector(14 downto 0);
begin
sh0 : shifter_15in_3b port map (sel => in0, input => input, output => out1);
sh1 : shifter_15in_3b port map (sel => in1, input => out1, output => out2);
sh2 : shifter_15in_3b port map (sel => in1, input => out2, output => out3);
sh3 : shifter_15in_3b port map (sel => in2, input => out3, output => out4);
sh4 : shifter_15in_3b port map (sel => in2, input => out4, output => out5);
sh5 : shifter_15in_3b port map (sel => in2, input => out5, output => out6);
sh6 : shifter_15in_3b port map (sel => in2, input => out6, output => output);
end structure;