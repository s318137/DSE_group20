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

	SIGNAL clock_50, sw, key : std_logic;
	SIGNAL ledr, hex0, hex1, hex2, hex3 : std_logic_vector(0 TO 6);

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

        -- Clock generation
        PROCESS

            BEGIN
                clock_50 <= '0';
                WAIT FOR 10 ns;
                clock_50 <= '1';
                WAIT FOR 10 ns;
                
        END PROCESS;

        PROCESS

            BEGIN
                sw <= "0000000000";
                key <= "0000";
                WAIT FOR 100 ns;
                key <= "0001";
                WAIT FOR 50 ns;
                assert ledr = "0000000001" REPORT "Test case 1 failed" severity error;
                key <= "0010";
                WAIT FOR 50 ns;
                assert ledr = "0000000000" REPORT "Test case 2 failed" severity error;
                WAIT;

        END PROCESS;

        -- Display the simulation results
        PROCESS

            BEGIN
                WAIT FOR 500 ns;
                REPORT "Simulation completed" severity note;
                WAIT;

        END PROCESS;

END behavior;