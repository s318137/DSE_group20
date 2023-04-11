LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part2_2 IS
	PORT (
		SW : IN std_logic_vector(9 DOWNTO 0);
		KEY : IN std_logic_vector(3 DOWNTO 0);
		HEX0, HEX1, HEX2, HEX3 : OUT std_logic_vector(0 TO 6)
	);
END part2_2;

ARCHITECTURE structure OF part2_2 IS

	COMPONENT hex_decoder IS
		PORT (
			input : IN std_logic_vector(3 DOWNTO 0);
			output : OUT std_logic_vector(0 TO 6)
		);
	END COMPONENT;

	COMPONENT part2_1 IS
		PORT (
			clk, rst, en : IN std_logic;
			output : BUFFER std_logic_vector(15 DOWNTO 0);
			tap_out : OUT std_logic
		);
	END COMPONENT;

	SIGNAL counter_out : std_logic_vector(15 DOWNTO 0);
	SIGNAL tap : std_logic;

	BEGIN
		counter : part2_1 PORT MAP(KEY(0),SW(0),SW(1),counter_out,tap);
		dec1 : hex_decoder PORT MAP(counter_out(15 DOWNTO 12),HEX3);
		dec2 : hex_decoder PORT MAP(counter_out(11 DOWNTO 8),HEX2);
		dec3 : hex_decoder PORT MAP(counter_out(7 DOWNTO 4),HEX1);
		dec4 : hex_decoder PORT MAP(counter_out(3 DOWNTO 0),HEX0);

END structure;