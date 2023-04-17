LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part4_tb IS
END part4_tb;

ARCHITECTURE behavior OF part4_tb IS

    COMPONENT part4
        PORT (
            SW : IN std_logic_vector(9 DOWNTO 0);
            CLOCK_50 : IN std_logic;
            HEX0 : OUT std_logic_vector(0 TO 6)
        );
    END COMPONENT;

    SIGNAL SW : std_logic_vector(9 DOWNTO 0);
    SIGNAL CLOCK_50 : std_logic := '0';
    SIGNAL HEX0 : std_logic_vector(0 TO 6);

    BEGIN

        uut : part4 PORT MAP (
            SW => SW,
            CLOCK_50 => CLOCK_50,
            HEX0 => HEX0
        );

        PROCESS

            BEGIN

                WAIT FOR 10 ns;
                CLOCK_50 <= '1';
                SW <= "0000000000";
                WAIT FOR 10 ns;
                
                CLOCK_50 <= '1';
                SW <= "0000000001";
                WAIT FOR 500 ns;

                WAIT;

        END PROCESS;

END behavior;