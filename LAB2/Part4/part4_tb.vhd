LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part4_tb IS
END part4_tb;

ARCHITECTURE behavior OF part4_tb IS 

    COMPONENT part4
        PORT (
            SW : IN std_logic_vector(9 DOWNTO 0);
            HEX0, HEX1 : OUT std_logic_vector(0 TO 6)
        );
    END COMPONENT;

    SIGNAL SW : std_logic_vector(9 downto 0);
    SIGNAL HEX0 : std_logic_vector(0 to 6);
    SIGNAL HEX1 : std_logic_vector(0 to 6);

    BEGIN

        uut: part4 PORT MAP (
                SW => SW,
                HEX0 => HEX0,
                HEX1 => HEX1
        );

        PROCESS

            BEGIN

                -- Test 1
                SW <= "0000000001";      
                WAIT FOR 10 ns;
                ASSERT(HEX0 = "0000110" AND HEX1 = "0000110")
                REPORT "Test 1 failed";
                
                -- Test 2
                SW <= "0000000010";      
                WAIT FOR 10 ns;
                ASSERT(HEX0 = "0000000" AND HEX1 = "0000000")
                REPORT "Test 2 failed";
                
                -- Test 3
                SW <= "0000000100";      
                WAIT FOR 10 ns;
                ASSERT(HEX0 = "0000011" AND HEX1 = "0000000")
                REPORT "Test 3 failed";
                
                -- Test 4
                SW <= "0000001000";      
                WAIT FOR 10 ns;
                ASSERT(HEX0 = "0000000" AND HEX1 = "0000100")
                REPORT "Test 4 failed";
                
                -- Test 5
                SW <= "0000010000";      
                WAIT FOR 10 ns;
                ASSERT(HEX0 = "0000000" AND HEX1 = "0000001")
                REPORT "Test 5 failed";
                
                -- Test 6
                SW <= "0000100000";      
                WAIT FOR 10 ns;
                ASSERT(HEX0 = "0000000" AND HEX1 = "0000011")
                REPORT "Test 6 failed";
                
                -- Test 7
                SW <= "0001000000";      
                WAIT FOR 10 ns;
                ASSERT(HEX0 = "0000000" AND HEX1 = "0000000")
                REPORT "Test 7 failed";
                
                -- Test 8
                SW <= "0010000000";      
                WAIT FOR 10 ns;
                ASSERT(HEX0 = "0000000" AND HEX1 = "0000000")
                REPORT "Test 8 failed";

                WAIT;

        END PROCESS;

END behavior;