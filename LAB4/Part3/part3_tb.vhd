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
    
    SIGNAL clk_signal : std_logic := '0';
    SIGNAL en_signal : std_logic := '0';
    SIGNAL rst_signal : std_logic := '0';
    SIGNAL output_signal : unsigned(15 DOWNTO 0);
    
    BEGIN

        uut : part3 PORT MAP (
            clk => clk_signal,
            en => en_signal,
            rst => rst_signal,
            output => output_signal
        );
    
    stim_proc : PROCESS
        BEGIN

            -- resetting
            rst_signal <= '1';
            clk_signal <= '1';
            WAIT FOR 10 ns;
            rst_signal <= '0';
            clk_signal <= '1';

            WAIT FOR 10 ns;
            
            -- enabling
            en_signal <= '1';
            clk_signal <= '1';
            -- some time to appreciate the output
            WAIT FOR 500 ns;

            -- resetting again
            en_signal <= '0';
            clk_signal <= '1';
            WAIT FOR 10 ns;
            rst_signal <= '1';
            clk_signal <= '1';
            WAIT FOR 10 ns;

            -- enabling again
            rst_signal <= '0';
            clk_signal <= '1';
            WAIT FOR 10 ns;
            en_signal <= '1';
            clk_signal <= '1';
            WAIT FOR 500 ns;
            
            WAIT;

    END PROCESS;

END behavior;