LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part5_tb IS
END part5_tb;

ARCHITECTURE behavior OF part5_tb IS

	COMPONENT part5 IS 
        PORT (
            clock_50 : IN std_logic;
            ledr : OUT std_logic_vector(9 DOWNTO 0);
            sw : IN std_logic_vector(9 DOWNTO 0);
            key : IN std_logic_vector(3 DOWNTO 0);
            hex0,hex1,hex2,hex3 : OUT std_logic_vector(0 TO 6)
        );
	END COMPONENT;

	SIGNAL clock_50 : std_logic;
    SIGNAL sw : std_logic_vector(9 DOWNTO 0);
    SIGNAL key : std_logic_vector(3 DOWNTO 0);
    SIGNAL ledr : std_logic_vector(9 DOWNTO 0);
	SIGNAL hex0, hex1, hex2, hex3 : std_logic_vector(0 TO 6);

	BEGIN

        uut: part5 PORT MAP (
            clock_50 => clock_50,
            ledr => ledr,
            sw => sw,
            key => key,
            hex0 => hex0,
            hex1 => hex1,
            hex2 => hex2,
            hex3 => hex3
        );

        PROCESS

            BEGIN
                
                WAIT FOR 10 ns;
                clock_50 <= '0';
                WAIT FOR 10 ns;
                
                sw <= "0000000000";
                key <= "0000";
                clock_50 <= '1';
                WAIT FOR 10 ns;
                key <= "0001";
                WAIT FOR 250 ns;
                key <= "1000";
                WAIT FOR 10 ns;

                sw <= "1111111111";
                clock_50 <= '1';
                key <= "0001";
                WAIT FOR 500 ns;
                key <= "1000";
                
                WAIT;

        END PROCESS;

END behavior;