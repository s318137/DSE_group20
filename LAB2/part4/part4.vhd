LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY part4 IS
PORT (sw : in std_logic_vector(9 downto 0);
		hex0,hex1 : out std_logic_vector(0 to 6)
		);
END part4;

architecture structure of part4 is

component comparator_6b is
PORT (v : IN UNSIGNED(5 DOWNTO 0);
		m : IN unsigned(5 DOWNTO 0);
		y : OUT STD_LOGIC);
end component;

component priority_encoder is
PORT (input : IN std_logic_vector(0 to 7);
		is_valid : out std_logic;
		output : out std_logic_vector(2 downto 0)
		);
end component;

component sub is
PORT (input,a : IN unsigned(5 DOWNTO 0);
		output : OUT unsigned(5 downto 0)
		);
end component;

component mux8to1_6b is
port (sel : in std_logic_vector(2 downto 0);
		a,b,c,d,e,f,g,h : in std_logic_vector(5 downto 0);
		y : out std_logic_vector(5 downto 0));
end component;

component decimal_decoder is
port (c : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(0 to 6)
		);
end component;

signal comp_out : std_logic_vector(0 to 7);
signal priority_out : std_logic_vector(2 downto 0);
signal nc : std_logic;
signal sub_out : unsigned(47 downto 0);
signal hex0_in,hex1_in : std_logic_vector(5 downto 0);

begin

hex1_in(5 downto 3) <= "000";
hex1_in(2 downto 0) <= priority_out;
sub_out(47 downto 42) <= unsigned(sw(5 downto 0));
sub_out(5 downto 0) <= "000000";
comp_out(0) <= '1';
comp_out(7) <= '0';

comp0 : comparator_6b port map(m => "001001", v => unsigned(sw(5 downto 0)), y => comp_out(1));
comp1 : comparator_6b port map(m => "010011", v => unsigned(sw(5 downto 0)), y => comp_out(2));
comp2 : comparator_6b port map(m => "011101", v => unsigned(sw(5 downto 0)), y => comp_out(3));
comp3 : comparator_6b port map(m => "100111", v => unsigned(sw(5 downto 0)), y => comp_out(4));
comp4 : comparator_6b port map(m => "110001", v => unsigned(sw(5 downto 0)), y => comp_out(5));
comp5 : comparator_6b port map(m => "111011", v => unsigned(sw(5 downto 0)), y => comp_out(6));
priority0 : priority_encoder port map(input => comp_out, is_valid => nc, output => priority_out);
sub0 : sub port map(a => "001010", input => unsigned(sw(5 downto 0)), output => sub_out(41 downto 36));
sub1 : sub port map(a => "010100", input => unsigned(sw(5 downto 0)), output => sub_out(35 downto 30));
sub2 : sub port map(a => "011110", input => unsigned(sw(5 downto 0)), output => sub_out(29 downto 24));
sub3 : sub port map(a => "101000", input => unsigned(sw(5 downto 0)), output => sub_out(23 downto 18));
sub4 : sub port map(a => "110010", input => unsigned(sw(5 downto 0)), output => sub_out(17 downto 12));
sub5 : sub port map(a => "111100", input => unsigned(sw(5 downto 0)), output => sub_out(11 downto 6));
mux0 : mux8to1_6b port map(a => std_logic_vector(sub_out(47 downto 42)), b => std_logic_vector(sub_out(41 downto 36)),
		 c => std_logic_vector(sub_out(35 downto 30)), d => std_logic_vector(sub_out(29 downto 24)), e => std_logic_vector(sub_out(23 downto 18)),
		 f => std_logic_vector(sub_out(17 downto 12)), g => std_logic_vector(sub_out(11 downto 6)), h => std_logic_vector(sub_out(5 downto 0)),
		 sel => priority_out, y => hex0_in);
dec0 : decimal_decoder port map(c => hex0_in(3 downto 0), output => hex0);
dec1 : decimal_decoder port map(c => hex1_in(3 downto 0), output => hex1);
end structure;