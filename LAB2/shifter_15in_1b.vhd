LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity shifter_15in_1b is
port (sel : in std_logic;
		input : in std_logic_vector(14 downto 0);
		output : out std_logic_vector(14 downto 0)
		);
end shifter_15in_1b;

architecture structure of shifter_15in_1b is
component mux2to1_1b is
port (a,b,sel : in std_logic;
		y : out std_logic
		);
end component;
begin
mux0: mux2to1_1b port map (sel => sel, a => input(0), b => input(1), y => output(0));
mux1: mux2to1_1b port map (sel => sel, a => input(1), b => input(2), y => output(1));
mux2: mux2to1_1b port map (sel => sel, a => input(2), b => input(3), y => output(2));
mux3: mux2to1_1b port map (sel => sel, a => input(3), b => input(4), y => output(3));
mux4: mux2to1_1b port map (sel => sel, a => input(4), b => input(5), y => output(4));
mux5: mux2to1_1b port map (sel => sel, a => input(5), b => input(6), y => output(5));
mux6: mux2to1_1b port map (sel => sel, a => input(6), b => input(7), y => output(6));
mux7: mux2to1_1b port map (sel => sel, a => input(7), b => input(8), y => output(7));
mux8: mux2to1_1b port map (sel => sel, a => input(8), b => input(9), y => output(8));
mux9: mux2to1_1b port map (sel => sel, a => input(9), b => input(10), y => output(9));
mux10: mux2to1_1b port map (sel => sel, a => input(10), b => input(11), y => output(10));
mux11: mux2to1_1b port map (sel => sel, a => input(11), b => input(12), y => output(11));
mux12: mux2to1_1b port map (sel => sel, a => input(12), b => input(13), y => output(12));
mux13: mux2to1_1b port map (sel => sel, a => input(13), b => input(14), y => output(13));
mux14: mux2to1_1b port map (sel => sel, a => input(14), b => input(0), y => output(14));
end structure;