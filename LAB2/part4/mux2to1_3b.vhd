LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux2to1_3b is
port (sel : in std_logic;
		a,b : in std_logic_vector(2 downto 0);
		y : out std_logic_vector(2 downto 0));
end mux2to1_3b;

architecture structure of mux2to1_3b is

component mux2to1_1b is 
port (a,b,sel : in std_logic;
		y : out std_logic);
end component;

begin

mux1: mux2to1_1b port map (a => a(0),b => b(0),sel => sel,y => y(0));
mux2: mux2to1_1b port map (a => a(1),b => b(1),sel => sel,y => y(1));
mux3: mux2to1_1b port map (a => a(2),b => b(2),sel => sel,y => y(2));

end structure;
