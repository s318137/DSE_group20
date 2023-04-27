LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part4_tb IS
END part4_tb;

ARCHITECTURE behavior OF part4_tb IS

    COMPONENT part4
        PORT (
            clock_50 : IN std_logic;
            key : IN std_logic_vector(3 DOWNTO 0);
            HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT std_logic_vector(0 TO 6)
        );
    END COMPONENT;

    SIGNAL clock_50 : std_logic := '0';
    SIGNAL key : std_logic_vector(3 DOWNTO 0) := "0000";
    SIGNAL HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : std_logic_vector(0 TO 6);

    BEGIN

        UUT : part4 PORT MAP (clock_50, key, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

        PROCESS
            BEGIN

                -- Initializiation
                clock_50 <= '1';
                WAIT FOR 10 ns;
                key <= "0001";
                WAIT FOR 10 ns;
                key <= "0000";
                WAIT FOR 10 ns;

                -- Toggle clock signal every 20 ns;
                FOR i IN 1 TO 100 LOOP
                    clock_50 <= NOT clock_50;
                    WAIT FOR 20 ns;
                END LOOP;

                WAIT;

        END PROCESS;

END behavior;