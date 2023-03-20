LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux2to1_6b is
port (sel : in std_logic;
		a,b : in std_logic_vector(5 downto 0);
		y : out std_logic_vector(5 downto 0));
end mux2to1_6b;

architecture structure of mux2to1_6b is
component mux2to1_3b is
port (sel : in std_logic;
		a,b : in std_logic_vector(2 downto 0);
		y : out std_logic_vector(2 downto 0));
end component;
begin
mux0 : mux2to1_3b port map(sel => sel, a => a(5 downto 3), b => b(5 downto 3), y => y(5 downto 3));
mux1 : mux2to1_3b port map(sel => sel, a => a(2 downto 0), b => b(2 downto 0), y => y(2 downto 0));
end structure;