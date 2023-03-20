LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity shifter_15in_3b is
port (sel : in std_logic;
		input : in std_logic_vector(14 downto 0);
		output : out std_logic_vector(14 downto 0)
		);
end shifter_15in_3b;

architecture structure of shifter_15in_3b is
component shifter_15in_1b is
port (sel : in std_logic;
		input : in std_logic_vector(14 downto 0);
		output : out std_logic_vector(14 downto 0)
		);
end component;

signal out1,out2 : std_logic_vector(14 downto 0);

begin
sh0: shifter_15in_1b port map(sel => sel, input => input, output => out1);
sh1: shifter_15in_1b port map(sel => sel, input => out1, output => out2);
sh2: shifter_15in_1b port map(sel => sel, input => out2, output => output);
end structure;