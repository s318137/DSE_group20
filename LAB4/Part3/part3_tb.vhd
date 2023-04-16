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

    DUT : part3

        PORT MAP (
            clk => clk_signal,
            en => en_signal,
            rst => rst_signal,
            output => output_signal
        );
    
    -- Clock generation
    clk_gen_proc : PROCESS
        BEGIN

            WHILE TRUE LOOP
                clk_signal <= NOT clk_signal;
                WAIT FOR 5 ns;
            END LOOP;
            
        END PROCESS;
    
    stim_proc : PROCESS
        BEGIN

            rst_signal <= '1';
            WAIT FOR 10 ns;
            rst_signal <= '0';
            
            en_signal <= '1';
            WAIT FOR 10 ns;
            en_signal <= '0';
            WAIT FOR 10 ns;
            en_signal <= '1';
            WAIT FOR 10 ns;
            en_signal <= '0';
            WAIT FOR 10 ns;
            en_signal <= '1';
            WAIT FOR 10 ns;
            en_signal <= '0';
            
            WAIT FOR 100 ns;
            
            en_signal <= '1';
            WAIT FOR 10 ns;
            en_signal <= '0';
            WAIT FOR 10 ns;
            en_signal <= '1';
            WAIT FOR 10 ns;
            en_signal <= '0';
            WAIT FOR 10 ns;
            en_signal <= '1';
            WAIT FOR 10 ns;
            en_signal <= '0';
            
            WAIT FOR 100 ns;
            
            WAIT;

    END PROCESS;

END behavior;