LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part4_tb IS
END part4_tb;

ARCHITECTURE behavior OF part4_tb IS

    COMPONENT part4
        PORT (
            sw : IN std_logic_vector(9 DOWNTO 0);
            clock_50 : IN std_logic;
            hex0 : OUT std_logic_vector(0 TO 6)
        );
    END COMPONENT;

    SIGNAL sw : std_logic_vector(9 DOWNTO 0);
    SIGNAL clock_50 : std_logic := '0';
    SIGNAL hex0 : std_logic_vector(0 TO 6);

    BEGIN

        uut : part4 PORT MAP (
            sw => sw,
            clock_50 => clock_50,
            hex0 => hex0
        );

        PROCESS

            BEGIN
                sw <= "0000000000";
                clock_50 <= '0';
                WAIT FOR 50 ns;
                
                sw <= "0000000001";
                clock_50 <= '1';
                WAIT FOR 50 ns;

        END PROCESS;

END behavior;