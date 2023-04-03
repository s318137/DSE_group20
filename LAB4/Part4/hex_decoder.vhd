LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY hex_decoder IS
port (input : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(0 to 6)
		);
END hex_decoder;

architecture structure of hex_decoder is
begin
output(0) <= (NOT(input(3)) AND NOT(input(2)) AND NOT(input(1)) AND input(0)) OR (NOT(input(3)) AND input(2) AND NOT(input(1)) AND NOT(input(0))) OR (input(3) AND NOT(input(2)) AND input(1) AND input(0)) OR (input(3) AND input(2) AND NOT(input(1)) AND input(0));
output(1) <= (input(2) AND input(1) AND NOT(input(0))) OR (input(3) AND input(1) AND input(0)) OR (input(3) AND input(2) AND NOT(input(0))) OR (NOT(input(3)) AND input(2) AND NOT(input(1)) AND input(0));
output(2) <= (input(3) AND input(2) AND NOT(input(0))) OR (input(3) AND input(2) AND input(1)) OR (NOT(input(3)) AND NOT(input(2)) AND input(1) AND NOT(input(0)));
output(3) <= (input(2) AND input(1) AND input(0)) OR (NOT(input(3)) AND NOT(input(2)) AND NOT(input(1)) AND input(0)) OR (NOT(input(3)) AND input(2) AND NOT(input(1)) AND NOT(input(0))) OR (input(3) AND NOT(input(2)) AND input(1) AND NOT(input(0)));
output(4) <= (NOT(input(3)) AND input(0)) OR (NOT(input(2)) AND NOT(input(1)) AND input(0)) OR (NOT(input(3)) AND input(2) AND NOT(input(1)));
output(5) <= (NOT(input(3)) AND NOT(input(2)) AND input(0)) OR (NOT(input(3)) AND NOT(input(2)) AND input(1)) OR (NOT(input(3)) AND input(1) AND input(0)) OR (input(3) AND input(2) AND NOT(input(1)) AND input(0));
output(6) <= (NOT(input(3)) AND NOT(input(2)) AND NOT(input(1))) OR (NOT(input(3)) AND input(2) AND input(1) AND input(0)) OR (input(3) AND input(2) AND NOT(input(1)) AND NOT(input(0)));
end structure;