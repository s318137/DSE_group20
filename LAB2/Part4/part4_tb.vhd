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

    signal SW : std_logic_vector(9 downto 0) := (others => '0');
    signal HEX0 : std_logic_vector(0 to 6);
    signal HEX1 : std_logic_vector(0 to 6);

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
                wait for 10 ns;
                assert(HEX0 = "0000110" and HEX1 = "0000110")
                report "Test 1 failed";
                
                -- Test 2
                SW <= "0000000010";      
                wait for 10 ns;
                assert(HEX0 = "0000006" and HEX1 = "0000000")
                report "Test 2 failed";
                
                -- Test 3
                SW <= "0000000100";      
                wait for 10 ns;
                assert(HEX0 = "0000011" and HEX1 = "0000000")
                report "Test 3 failed";
                
                -- Test 4
                SW <= "0000001000";      
                wait for 10 ns;
                assert(HEX0 = "0000000" and HEX1 = "0000100")
                report "Test 4 failed";
                
                -- Test 5
                SW <= "0000010000";      
                wait for 10 ns;
                assert(HEX0 = "0000000" and HEX1 = "0000001")
                report "Test 5 failed";
                
                -- Test 6
                SW <= "0000100000";      
                wait for 10 ns;
                assert(HEX0 = "0000000" and HEX1 = "0000011")
                report "Test 6 failed";
                
                -- Test 7
                SW <= "0001000000";      
                wait for 10 ns;
                assert(HEX0 = "0000000" and HEX1 = "0000000")
                report "Test 7 failed";
                
                -- Test 8
                SW <= "0010000000";      
                wait for 10 ns;
                assert(HEX0 = "0000000" and HEX1 = "0000000")
                report "Test 8 failed";

                WAIT;

        END PROCESS;

END behavior;