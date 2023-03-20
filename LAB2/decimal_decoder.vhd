LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity decimal_decoder is
port (c : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(0 to 6)
		);
end decimal_decoder;

architecture behavior of decimal_decoder is
begin
output(0) <= (c(2) and not(c(1)) and not (c(0))) or (not(c(3)) and not (c(2)) and not(c(1)) and c(0));
output(1) <= (c(2) and c(0) and not(c(1))) or (c(2) and c(1) and not(c(0)));
output(2) <= not(c(2)) and c(1) and not(c(0));
output(3) <= (c(2) and not(c(1)) and not(c(0))) or (c(2) and c(1) and c(0)) or (not(c(3)) and not(c(2)) and not(c(1)) and c(0));
output(4) <= c(0) or (c(2) and not(c(1)));
output(5) <= (not(c(2)) and c(1)) or (c(1) and c(0)) or (not(c(3)) and not(c(2)) and c(0));
output(6) <= (not(c(3)) and not(c(2)) and not(c(1))) or (c(2) and c(1) and c(0));
end behavior;