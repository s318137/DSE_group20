LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part3_tb IS
END part3_tb;

ARCHITECTURE behavior OF part3_tb IS

    COMPONENT part3
        PORT (
            clk, en, rst : IN std_logic;
            output : BUFFER unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : std_logic := '0';
    SIGNAL en : std_logic := '0';
    SIGNAL rst : std_logic := '0';
    SIGNAL output : unsigned(15 DOWNTO 0);

    BEGIN

        uut : part3 PORT MAP (
            clk => clk,
            en => en,
            rst => rst,
            output => output
        );

        stim_proc : PROCESS
            BEGIN

                WAIT FOR 10 ns;
                rst <= '1';
                WAIT FOR 10 ns;
                rst <= '0';
                WAIT FOR 10 ns;
                en <= '1';
                WAIT FOR 50 ns;
                en <= '0';
                WAIT FOR 10 ns;
                en <= '1';
                WAIT FOR 30 ns;
                en <= '0';
                WAIT;

        END PROCESS;

        clk_proc : PROCESS
            BEGIN

                while now < 200 ns LOOP
                    clk <= NOT clk;
                    WAIT FOR 5 ns;
                END LOOP;

                WAIT;

        END PROCESS;

END behavior;