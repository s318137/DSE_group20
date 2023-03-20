LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux4to1_6b is
port (sel : in std_logic_vector(1 downto 0);
		a,b,c,d : in std_logic_vector(5 downto 0);
		y : out std_logic_vector(5 downto 0));
end mux4to1_6b;

architecture structure of mux4to1_6b is
component mux2to1_6b is
port (sel : in std_logic;
		a,b : in std_logic_vector(5 downto 0);
		y : out std_logic_vector(5 downto 0));
end component;
signal out0,out1 : std_logic_vector(5 downto 0);
begin
mux0 : mux2to1_6b port map(sel => sel(0), a => a, b => b, y => out0);
mux1 : mux2to1_6b port map(sel => sel(0), a => c, b => d, y => out1);
mux2 : mux2to1_6b port map(sel => sel(1), a => out0, b => out1, y => y);
end structure;