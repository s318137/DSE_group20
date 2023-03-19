LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY bin_to_dec_converter_1 IS
    PORT (  v : IN UNSIGNED(3 DOWNTO 0);
            m : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            z : OUT STD_LOGIC;
            HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END bin_to_dec_converter_1;

ARCHITECTURE Behavior OF bin_to_dec_converter_1 IS
    SIGNAL d0, d1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL comp : STD_LOGIC;

    BEGIN
        PROCESS(v) IS
            BEGIN
                IF (v > "1001") THEN
                    comp <= '1';
                ELSE
                    comp <= '0';
                END IF;

                CASE v IS
                    WHEN "0000" => d0 <= "0000001"; d1 <= "1111111";  -- 00 shown
                    WHEN "0001" => d0 <= "1001111"; d1 <= "1111111";  -- 01 shown
                    WHEN "0010" => d0 <= "0010010"; d1 <= "1111111";  -- 02 shown
                    WHEN "0011" => d0 <= "0001100"; d1 <= "1111111";  -- 03 shown
                    WHEN "0100" => d0 <= "1001100"; d1 <= "1111111";  -- 04 shown
                    WHEN "0101" => d0 <= "0100100"; d1 <= "1111111";  -- 05 shown
                    WHEN "0110" => d0 <= "0100000"; d1 <= "1111111";  -- 06 shown
                    WHEN "0111" => d0 <= "0001111"; d1 <= "1111111";  -- 07 shown
                    WHEN "1000" => d0 <= "0000000"; d1 <= "1111111";  -- 08 shown
                    WHEN "1001" => d0 <= "0000100"; d1 <= "1111111";  -- 09 shown
                    WHEN "1010" => d0 <= "0000001"; d1 <= "1001111";  -- 10 shown
                    WHEN "1011" => d0 <= "1001111"; d1 <= "1001111";  -- 11 shown
                    WHEN "1100" => d0 <= "0010010"; d1 <= "1001111";  -- 12 shown
                    WHEN "1101" => d0 <= "0001100"; d1 <= "1001111";  -- 13 shown
                    WHEN "1110" => d0 <= "1001100"; d1 <= "1001111";  -- 14 shown
                    WHEN "1111" => d0 <= "0100100"; d1 <= "1001111";  -- 15 shown
                    WHEN OTHERS => d0 <= "0110000"; d1 <= "0110000";  -- E shown
                END CASE;
        END PROCESS;

    HEX0 <= d0;
    HEX1 <= d1;

END ARCHITECTURE Behavior;