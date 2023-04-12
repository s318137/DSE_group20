LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part4_tb IS
END part4_tb;

ARCHITECTURE behavior OF part4_tb IS

    COMPONENT part4
        PORT(
            sw : IN std_logic_vector(9 DOWNTO 0);
            CLOCK_50 : IN std_logic;
            hex0 : OUT std_logic_vector(0 TO 6)
        );
    END COMPONENT;


    SIGNAL sw : std_logic_vector(9 DOWNTO 0) := "0000000000";
    SIGNAL CLOCK_50 : std_logic := '0';
    SIGNAL hex0 : std_logic_vector(0 TO 6);

    BEGIN

        uut: part4 PORT MAP (
            sw => sw,
            CLOCK_50 => CLOCK_50,
            hex0 => hex0
        );

        CLOCK_50 <= NOT CLOCK_50 AFTER 10 ns;

        stimulus: PROCESS
            BEGIN

                -- Reset signal assertion
                sw(0) <= '0';
                WAIT FOR 10 ns;

                -- Release reset signal
                sw(0) <= '1';
                WAIT FOR 500 ns;

                -- Start the timer
                sw <= "0000000001";
                WAIT FOR 1 us;

                -- Verify output
                ASSERT hex0 = x"ABCDEF" REPORT "Output mismatch" SEVERITY error;

                WAIT;

        END PROCESS;

END behavior;