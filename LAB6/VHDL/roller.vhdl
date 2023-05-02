LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

--For easiness, every rollers / shifters are reduced to this component

ENTITY roller IS
	PORT(
		A, B, C, D : IN SIGNED(7 DOWNTO 0);
		W, X, Y, Z : OUT SIGNED(7 DOWNTO 0)
		);
END ENTITY;

ARCHITECTURE Behaviour OF roller IS

SIGNAL W_out, X_out, Y_out, Z_out : SIGNED(7 DOWNTO 0) := "00000000";


BEGIN
	W_out <= A(7) & ('0' & A(6 DOWNTO 1)); --& concatenation, conservation of sign 
	X_out <= B(7) & (B(6 DOWNTO 1) & '0'); -- shifting only on the 7 number bits
	Y_out <= C(7) & (C(6 DOWNTO 2) & "00"); -- x4 = 2 shift
	Z_out <= D(7) & ("00" & D(6 DOWNTO 2));
	
	W <= W_out;
	X <= X_out;
	Y <= Y_out;
	Z <= Z_out;
	
END Behaviour;