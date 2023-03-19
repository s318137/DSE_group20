LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY bin_to_dec_converter_1_tb IS
END bin_to_dec_converter_1_tb;

ARCHITECTURE behavior OF bin_to_dec_converter_1_tb IS

    COMPONENT bin_to_dec_converter_1
        PORT (
            v : IN UNSIGNED(3 DOWNTO 0);
            m : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            z : OUT STD_LOGIC;
            HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL v : UNSIGNED(3 DOWNTO 0);

    SIGNAL m : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL z : STD_LOGIC;
    SIGNAL HEX0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL HEX1 : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN

    uut : bin_to_dec_converter_1
        PORT MAP (
            v => v,
            m => m,
            z => z,
            HEX0 => HEX0,
            HEX1 => HEX1
        );

    PROCESS
    BEGIN
        -- Test of all possible input values
        FOR i IN 0 TO 15 LOOP
            v <= to_unsigned(i, 4);
            WAIT FOR 10 ns;
        END LOOP;
        WAIT;
    END PROCESS;

END behavior;