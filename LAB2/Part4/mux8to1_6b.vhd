LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux8to1_6b is
port (sel : in std_logic_vector(2 downto 0);
		a,b,c,d,e,f,g,h : in std_logic_vector(5 downto 0);
		y : out std_logic_vector(5 downto 0));
end mux8to1_6b;

architecture structure of mux8to1_6b is
component mux4to1_6b is
port (sel : in std_logic_vector(1 downto 0);
		a,b,c,d : in std_logic_vector(5 downto 0);
		y : out std_logic_vector(5 downto 0));
end component;
component mux2to1_6b is
port (sel : in std_logic;
		a,b : in std_logic_vector(5 downto 0);
		y : out std_logic_vector(5 downto 0));
end component;
signal out0,out1 : std_logic_vector(5 downto 0);
begin
mux0 : mux4to1_6b port map(sel => sel(1 downto 0), a => a, b => b, c => c, d => d, y => out0);
mux1 : mux4to1_6b port map(sel => sel(1 downto 0), a => e, b => f, c => g, d => h, y => out1);
mux2 : mux2to1_6b port map(sel => sel(2), a => out0, b => out1, y => y);
end structure;