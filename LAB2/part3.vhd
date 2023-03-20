LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY part3 IS
PORT (sw : IN std_logic_vector(3 DOWNTO 0);
		hex1,hex0 : OUT STD_LOGIC_VECTOR(0 TO 6)
		);
END part3;

architecture structure of part3 is

component mux2to1_1b is
port (a,b,sel : in std_logic;
		y : out std_logic);
end component;

component decimal_decoder is
port (c : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(0 to 6)
		);
end component;

component comparator IS
PORT (v : IN UNSIGNED(3 DOWNTO 0);
		m : IN unsigned(3 DOWNTO 0);
		y : OUT STD_LOGIC);
END component;

component circuitA IS
PORT (v : IN UNSIGNED(2 DOWNTO 0);
		m : OUT unsigned(2 DOWNTO 0)
		);
END component;

signal out1,out3,out4,out5,out6,out7,out8 : std_logic;
signal number,number1,number2 : unsigned(3 downto 0);
signal out2 : unsigned(2 downto 0);

begin
number(0) <= sw(0);
number(1) <= sw(1);
number(2) <= sw(2);
number(3) <= sw(3);
comp : comparator port map(v => number , m => "1001", y => out1);
ca : circuitA port map(v => number(2 downto 0),m => out2);
mux0 : mux2to1_1b port map(a => sw(3), b => '0', sel => out1,y => out3);
mux1 : mux2to1_1b port map(a => sw(2), b => out2(2), sel => out1,y => out4);
mux2 : mux2to1_1b port map(a => sw(1), b => out2(1), sel => out1,y => out5);
mux3 : mux2to1_1b port map(a => sw(0), b => out2(0), sel => out1,y => out6);
number1(3) <= out3;
number1(2) <= out4;
number1(1) <= out5;
number1(0) <= out6;
number2(3 downto 1) <= "000";
number2(0) <= out1;
dec0 : decimal_decoder port map(c => std_logic_vector(number1), output => hex0);
dec1 : decimal_decoder port map(c => std_logic_vector(number2), output => hex1);
end structure;