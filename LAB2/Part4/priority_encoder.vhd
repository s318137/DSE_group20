LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY priority_encoder IS
PORT (input : IN std_logic_vector(0 to 7);
		is_valid : out std_logic;
		output : out std_logic_vector(2 downto 0)
		);
END priority_encoder;

architecture structure of priority_encoder is
component mux2to1_3b is
port (sel : in std_logic;
		a,b : in std_logic_vector(2 downto 0);
		y : out std_logic_vector(2 downto 0));
end component;

component max_3b is
PORT (input1,input2 : IN unsigned(2 DOWNTO 0);
		output : OUT unsigned(2 downto 0)
		);
end component;
signal mux_out : unsigned(23 downto 0);
signal max_out0 : unsigned(11 downto 0);
signal max_out1 : unsigned(5 downto 0);
begin
is_valid <= not(input(0)) and not(input(1)) and 
				not(input(2)) and not(input(3)) and 
				not(input(4)) and not(input(5)) and 
				not(input(6)) and not(input(7));
mux0 : mux2to1_3b port map (a => "000",b => "000",sel => input(0),unsigned(y) => mux_out(23 downto 21));
mux1 : mux2to1_3b port map (a => "000",b => "001",sel => input(1),unsigned(y) => mux_out(20 downto 18));
mux2 : mux2to1_3b port map (a => "000",b => "010",sel => input(2),unsigned(y) => mux_out(17 downto 15));
mux3 : mux2to1_3b port map (a => "000",b => "011",sel => input(3),unsigned(y) => mux_out(14 downto 12));
mux4 : mux2to1_3b port map (a => "000",b => "100",sel => input(4),unsigned(y) => mux_out(11 downto 9));
mux5 : mux2to1_3b port map (a => "000",b => "101",sel => input(5),unsigned(y) => mux_out(8 downto 6));
mux6 : mux2to1_3b port map (a => "000",b => "110",sel => input(6),unsigned(y) => mux_out(5 downto 3));
mux7 : mux2to1_3b port map (a => "000",b => "111",sel => input(7),unsigned(y) => mux_out(2 downto 0));
max0 : max_3b port map (input1 => mux_out(23 downto 21),input2 => mux_out(20 downto 18),output => max_out0(11 downto 9));
max1 : max_3b port map (input1 => mux_out(17 downto 15),input2 => mux_out(14 downto 12),output => max_out0(8 downto 6));
max2 : max_3b port map (input1 => mux_out(11 downto 9),input2 => mux_out(8 downto 6),output => max_out0(5 downto 3));
max3 : max_3b port map (input1 => mux_out(5 downto 3),input2 => mux_out(2 downto 0),output => max_out0(2 downto 0));
max4 : max_3b port map (input1 => max_out0(11 downto 9),input2 => max_out0(8 downto 6),output => max_out1(5 downto 3));
max5 : max_3b port map (input1 => max_out0(5 downto 3),input2 => max_out0(2 downto 0),output => max_out1(2 downto 0));
max6 : max_3b port map (input1 => max_out1(5 downto 3),input2 => max_out1(2 downto 0),std_logic_vector(output) => output(2 downto 0));
end structure;