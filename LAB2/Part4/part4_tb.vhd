LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part4_tb IS
END part4_tb;

ARCHITECTURE behavior OF part4_tb IS 

    COMPONENT part4
        PORT (
            sw : IN std_logic_vector(5 DOWNTO 0);
            hex0, hex1 : OUT std_logic_vector(0 TO 6)
        );
    END COMPONENT;

    SIGNAL sw : std_logic_vector(5 DOWNTO 0);
    SIGNAL hex0, hex1 : std_logic_vector(0 TO 6);

    BEGIN

        uut: part4 PORT MAP (
                sw => sw,
                hex0 => hex0,
                hex1 => hex1
        );

        PROCESS

            BEGIN

                -- Test 1 -> decimal number: 00
                sw <= "000000";      
                WAIT FOR 10 ns;
                ASSERT hex0 = "0000001" AND hex1 = "0000001"
                REPORT "Test 1 failed";
                
                -- Test 2 -> decimal number: 29
                sw <= "101001";      
                WAIT FOR 10 ns;
                ASSERT hex0 = "0000100" AND hex1 = "0010010"
                REPORT "Test 2 failed";
                
                -- Test 3 -> decimal number: 09
                sw <= "001001";      
                WAIT FOR 10 ns;
                ASSERT hex0 = "0000100" AND hex1 = "0000001"
                REPORT "Test 3 failed";
                
                -- Test 4 -> decimal number: 15
                sw <= "010101";      
                WAIT FOR 10 ns;
                ASSERT hex0 = "0100100" AND hex1 = "1001111"
                REPORT "Test 4 failed";
                
                -- Test 5 -> decimal number: 12
                sw <= "100100";      
                WAIT FOR 10 ns;
                ASSERT hex0 = "0010010" AND hex1 = "1001111"
                REPORT "Test 5 failed";
                
                -- Test 6 -> decimal number: 33
                sw <= "110011";      
                WAIT FOR 10 ns;
                ASSERT hex0 = "0000110" AND hex1 = "0000110"
                REPORT "Test 6 failed";
                
                WAIT;

        END PROCESS;

END behavior;