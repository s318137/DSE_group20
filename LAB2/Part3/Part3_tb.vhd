LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Part3_tb IS
END Part3_tb;

ARCHITECTURE behavior OF Part3_tb IS

    COMPONENT Part3
        PORT (
            SW : IN std_logic_vector(3 DOWNTO 0);
            HEX1,HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6)
        );
    END COMPONENT;

    SIGNAL SW : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL HEX1, HEX0 : std_logic_vector(0 TO 6);

    BEGIN
        uut: Part3 PORT MAP (
            SW => SW,
            HEX1 => HEX1,
            HEX0 => HEX0
        );

    stim_proc: PROCESS
        BEGIN
            -- Test 1: SW = "0001" equivalent number: 00
            SW <= "0000";
            WAIT FOR 10 ns;
            ASSERT HEX1 = "0000001" AND HEX0 = "0000001" 
            REPORT "Test 1 failed"; 

            -- Test 2: SW = "1000" equivalent number: 08
            SW <= "1000";
            WAIT FOR 10 ns;
            ASSERT HEX1 = "0000001" AND HEX0 = "0000000" 
            REPORT "Test 2 failed"; 

            -- Test 3: SW = "1101" equivalent number: 13
            SW <= "1101";
            WAIT FOR 10 ns;
            ASSERT HEX1 = "1001111" AND HEX0 = "0000110" 
            REPORT "Test 3 failed";

            -- Test 4: SW = "1111" equivalent number: 15
            SW <= "1111";
            WAIT FOR 10 ns;
            ASSERT HEX1 = "1001111" AND HEX0 = "0100100" 
            REPORT "Test 4 failed";

            WAIT;
    END PROCESS;

END behavior;