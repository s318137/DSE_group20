LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part3 IS
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		KEY1 : IN STD_LOGIC; 
		Z : OUT STD_LOGIC;
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
		
END Part3;

ARCHITECTURE Behavior OF part2 IS
--. . . declare signals
	SIGNAL W : STD_LOGIC;
	SIGNAL OneHot : STD_LOGIC_VECTOR(8 DOWNTO 0);
	
	TYPE State_type IS (A, B, C, D, E, F, G, H, I);
	SIGNAL Y_Q, Y_D : State_type; -- y_Q is present state, y_D is next state
BEGIN

	W <= SW(1);

PROCESS (W, Y_Q) -- state table
BEGIN
	CASE Y_Q IS
		WHEN A => IF (W = '0') THEN Y_D <= B ;
		ELSE Y_D <= F;
		END IF;
		
		WHEN B => IF (W = '0') THEN Y_D <= C;
		ELSE Y_D <= F;
		END IF;
		
		WHEN C => IF (W = '0') THEN Y_D <= D;
		ELSE Y_D <= F;
		END IF;
		
		WHEN D => IF (W = '0') THEN Y_D <= E;
		ELSE Y_D <= F;
		END IF;
		
		WHEN E => IF (W = '0') THEN Y_D <= E;
		ELSE Y_D <= F;
		END IF;
		
		WHEN F => IF (W = '1') THEN Y_D <= G;
		ELSE Y_D <= B;
		END IF;
		
		WHEN G => IF (W = '1') THEN Y_D <= H;
		ELSE Y_D <= B;
		END IF;
		
		WHEN H => IF (W = '1') THEN Y_D <= I;
		ELSE Y_D <= B;
		END IF;
		
		WHEN I => IF (W = '1') THEN Y_D <= I;
		ELSE Y_D <= B;
		END IF;
	
--. . . other states
END CASE;
END PROCESS; -- state table
PROCESS (Clock) -- state flip-flops
BEGIN
	
	OneHot <= Y_Q

END PROCESS;
--. . . assignments for output z and the LEDs
END Behavior;