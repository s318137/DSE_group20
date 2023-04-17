LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part2_2_tb IS
END part2_2_tb;

ARCHITECTURE behavior OF part2_2_tb IS

    COMPONENT part2_2
        PORT (
            SW : IN  std_logic_vector(9 DOWNTO 0);
            KEY : IN  std_logic_vector(3 DOWNTO 0);
            HEX0, HEX1, HEX2, HEX3 : OUT std_logic_vector(0 TO 6)
        );
    END COMPONENT;

   SIGNAL SW : std_logic_vector(9 DOWNTO 0);
   SIGNAL KEY : std_logic_vector(3 DOWNTO 0);
   SIGNAL HEX0, HEX1, HEX2, HEX3 : std_logic_vector(0 TO 6);

    BEGIN

        uut: part2_2 PORT MAP (
                            SW => SW,
                            KEY => KEY,
                            HEX0 => HEX0,
                            HEX1 => HEX1,
                            HEX2 => HEX2,
                            HEX3 => HEX3
                    );

        stim_proc: PROCESS
            BEGIN

                -- resetting
                WAIT FOR 10 ns;
                SW <= "0000000001";
                KEY <= "0001";
                WAIT FOR 50 ns;

                -- enabling
                SW <= "0000000000";
                SW <= "0000000010";
                KEY <= "0001";
                WAIT FOR 500 ns;    

                WAIT;
                
        END PROCESS;

END behavior;