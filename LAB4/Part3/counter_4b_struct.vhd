LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY counter_4b_struct IS
PORT ( rst,clk,en: IN STD_LOGIC; 
       output : out std_logic_vector(3 downto 0);
		 tap_out : out std_logic);
END counter_4b_struct;

ARCHITECTURE structure OF counter_4b_struct IS
component T_flipflop is
PORT ( Clk, T ,clr: IN STD_LOGIC;
       Q : buffer STD_LOGIC);
end component;
signal in2,in3,in4 : std_logic;
signal out1,out2,out3 : std_logic;
BEGIN
tap_out <= in4;
in2 <= en and out1;
in3 <= in2 and out2;
in4 <= in3 and out3;
ff1 : T_flipflop port map (clk,en,rst,out1);
ff2 : T_flipflop port map (clk,in2,rst,out2);
ff3 : T_flipflop port map (clk,in3,rst,out3);
ff4 : T_flipflop port map (clk,in4,rst,output(3));
output(0) <= out1;
output(1) <= out2;
output(2) <= out3;
END structure;