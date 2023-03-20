LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY binary_decoder IS
PORT ( v : IN UNSIGNED(3 DOWNTO 0);
m : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
z : OUT STD_LOGIC);
END converter;