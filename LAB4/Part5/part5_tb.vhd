LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part5_tb IS
END part5_tb;

ARCHITECTURE behavior OF part5_tb IS

	COMPONENT part5 IS 
        PORT (
            clock_50 : IN std_logic;
            ledr : OUT std_logic_vector(6 DOWNTO 0);
            sw : IN std_logic_vector(7 DOWNTO 0);
            key : IN std_logic_vector(3 DOWNTO 0);
            hex0,hex1,hex2,hex3 : OUT std_logic_vector(0 TO 6)
        );
	END COMPONENT;

	SIGNAL clock_50 : std_logic;
    SIGNAL sw : std_logic_vector(7 DOWNTO 0);
    SIGNAL key : std_logic_vector(3 DOWNTO 0);
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
                sw <= "00000000";
                key <= "0000";
                WAIT FOR 100 ns;
                key <= "0001";
                WAIT FOR 100 ns;
                key <= "1000";
                WAIT FOR 100 ns;
                sw <= "11111111";
                key <= "0001";
                WAIT FOR 100 ns;
                key <= "1000";
                
                WAIT;

        END PROCESS;

END behavior;