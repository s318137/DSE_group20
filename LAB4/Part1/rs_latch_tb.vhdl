LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY rs_latch_tb IS
END rs_latch_tb;

ARCHITECTURE behavior OF rs_latch_tb IS

    COMPONENT rs_latch
    PORT ( Clk, R, S : IN STD_LOGIC;
           Q : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL r : STD_LOGIC := '0';
    SIGNAL s : STD_LOGIC := '0';
    SIGNAL q : STD_LOGIC;

BEGIN
    uut: rs_latch PORT MAP (
        Clk => clk,
        R => r,
        S => s,
        Q => q
    );

    clk_process :process
    begin
        wait for 10 ns;
        clk <= not clk;
    end process;

    stim_proc: process
    begin
        -- Hold reset for some time
        r <= '1';
        s <= '0';
        wait for 50 ns;

        -- Release reset and set S high
        r <= '0';
        s <= '1';
        wait for 50 ns;

        -- Set R high and S low
        r <= '1';
        s <= '0';
        wait for 50 ns;

        -- Set both R and S to low
        r <= '0';
        s <= '0';
        wait for 50 ns;

        -- Set both R and S to high
        r <= '1';
        s <= '1';
        wait for 50 ns;

        -- Set S high and R low
        r <= '0';
        s <= '1';
        wait for 50 ns;

        -- Set S low and R high
        r <= '1';
        s <= '0';
        wait for 50 ns;

        wait;
    end process;

END behavior;