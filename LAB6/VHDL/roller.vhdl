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

CONSTANT ONE : SIGNED(A'RANGE) := (0 => '1', others => '0');

SIGNAL NegW, NegX : SIGNED(7 DOWNTO 0) := "00000000";
SIGNAL W_out, X_out, Y_out, Z_out : SIGNED(7 DOWNTO 0) := "00000000";


BEGIN
	NegW <= not(A) + ONE;
	NegX <= not(B) + ONE;
	
	W_out <= NegW(7) & ('0' & NegW(6 DOWNTO 1)); --& concatenation, conservation of sign 
	X_out <= NegX(7) & (NegX(6 DOWNTO 1) & '0'); -- shifting only on the 7 number bits
	Y_out <= C(7) & (C(6 DOWNTO 2) & "00"); -- x4 = 2 shift
	Z_out <= D(7) & ("00" & D(6 DOWNTO 2));
	
	W <= W_out;
	X <= X_out;
	Y <= Y_out;
	Z <= Z_out;


END Behaviour;