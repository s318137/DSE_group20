LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY counter_4b_struct IS
       PORT (
              rst, clk, en: IN STD_LOGIC; 
              output : OUT std_logic_vector(3 DOWNTO 0);
              tap_out : OUT std_logic
       );
END counter_4b_struct;

ARCHITECTURE structure OF counter_4b_struct IS

       COMPONENT T_flipflop IS
              PORT (
                     Clk, T, clr: IN STD_LOGIC;
                     Q : BUFFER STD_LOGIC
              );
       END COMPONENT;

       SIGNAL in2, in3, in4 : std_logic;
       SIGNAL out1, out2, out3 : std_logic;

       BEGIN
              tap_out <= in4;
              in2 <= en AND out1;
              in3 <= in2 AND out2;
              in4 <= in3 AND out3;
              ff1 : T_flipflop PORT MAP (clk, en, NOT rst, out1);
              ff2 : T_flipflop PORT MAP (clk, in2, NOT rst, out2);
              ff3 : T_flipflop PORT MAP (clk, in3, NOT rst, out3);
              ff4 : T_flipflop PORT MAP (clk, in4, NOT rst, output(3));
              output(0) <= out1;
              output(1) <= out2;
              output(2) <= out3;

END structure;