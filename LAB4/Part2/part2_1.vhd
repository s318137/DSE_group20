LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity part2_1 is
port (clk,rst,en : in std_logic;
		output : buffer std_logic_vector(15 downto 0);
		tap_out : out std_logic
		);
end part2_1;

ARCHITECTURE structure of part2_1 is
component counter_4b_struct is
PORT ( rst,clk,en: IN STD_LOGIC; 
       output : out std_logic_vector(3 downto 0);
		 tap_out : out std_logic);
end component;
signal tap1,tap2,tap3 : std_logic;
signal in2,in3,in4 : std_logic;
begin
in2 <= tap1 and output(3);
in3 <= tap2 and output(7);
in4 <= tap3 and output(11);
count1 : counter_4b_struct port map (rst,clk,en,output(3 downto 0),tap1);
count2 : counter_4b_struct port map (rst,clk,in2,output(7 downto 4),tap2);
count3 : counter_4b_struct port map (rst,clk,in3,output(11 downto 8),tap3);
count4 : counter_4b_struct port map (rst,clk,in4,output(15 downto 12),tap_out);
end structure;