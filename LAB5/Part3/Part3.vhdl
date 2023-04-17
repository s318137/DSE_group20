LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Part3 IS
	PORT(
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
		Z : OUT STD_LOGIC;
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);	
END Part3;

ARCHITECTURE Behavior OF part3 IS

	COMPONENT flipflop IS
		PORT (
			D, Clock, Resetn : IN STD_LOGIC;
			Q : OUT STD_LOGIC
		);
	END COMPONENT;

	-- declare signals
	SIGNAL W : STD_LOGIC;
	SIGNAL OneHot : STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL A_up : STD_LOGIC := '1';
	SIGNAL KEY1 : STD_LOGIC;
	SIGNAL Z_out : STD_LOGIC;
	
	TYPE State_type IS (A, B, C, D, E, F, G, H, I);
	SIGNAL Y_Q, Y_D : State_type; -- y_Q is present state, y_D is next state

	BEGIN

		W <= SW(1);
		A_up <= not(OneHot(0));
		KEY1 <= KEY(1);


		PROCESS (W, Y_Q) -- state table
			BEGIN
			
				CASE Y_Q IS
					WHEN A => IF (W = '0') THEN 
						Y_D <= B;
						OneHot <= "000000011";
					ELSE 
						Y_D <= F;
						OneHot <= "000100001";
					END IF;
					
					WHEN B => IF (W = '0') THEN 
						Y_D <= C;
						OneHot <= "000000101";
					ELSE 
						Y_D <= F;
						OneHot <= "000100001";
					END IF;
					
					WHEN C => IF (W = '0') THEN 
						Y_D <= D;
						OneHot <= "000001001";
					ELSE 
						Y_D <= F;
						OneHot <= "000100001";
					END IF;
					
					WHEN D => IF (W = '0') THEN 
						Y_D <= E;
						OneHot <= "000010001";
					ELSE 
						Y_D <= F;
						OneHot <= "000100001";
					END IF;
					
					WHEN E => IF (W = '0') THEN 
						Y_D <= E;
						OneHot <= "000010001";
					ELSE 
						Y_D <= F;
						OneHot <= "000100001";
					END IF;
					
					WHEN F => IF (W = '1') THEN 
						Y_D <= G;
						OneHot <= "001000001";
					ELSE 
						Y_D <= B;
						OneHot <= "000000011";
					END IF;
					
					WHEN G => IF (W = '1') THEN 
						Y_D <= H;
						OneHot <= "010000001";
					ELSE 
						Y_D <= B;
						OneHot <= "000000011";
					END IF;
					
					WHEN H => IF (W = '1') THEN 
						Y_D <= I;
						OneHot <= "100000011";
					ELSE 
						Y_D <= B;
						OneHot <= "000000011";
					END IF;
					
					WHEN I => IF (W = '1') THEN 
						Y_D <= I;
						OneHot <= "100000001";
					ELSE 
						Y_D <= B;
						OneHot <= "000000011";
					END IF;
				
				-- other states
				END CASE;
		END PROCESS; -- state table

		PROCESS (KEY1) -- state flip-flops
			BEGIN
	
				fA : flipflop PORT MAP(D => A_up, Clock => KEY1, Resetn => '1', Q => OneHot(0));
				fB : flipflop PORT MAP(D => OneHot(1), Clock => KEY1, Resetn => SW(0), Q => OneHot(1));
				fC : flipflop PORT MAP(D => OneHot(2), Clock => KEY1, Resetn => SW(0), Q => OneHot(2));

				fD : flipflop PORT MAP(D => OneHot(3), Clock => KEY1, Resetn => SW(0), Q => OneHot(3));
				fE : flipflop PORT MAP(D => OneHot(4), Clock => KEY1, Resetn => SW(0), Q => OneHot(4));
				fF : flipflop PORT MAP(D => OneHot(5), Clock => KEY1, Resetn => SW(0), Q => OneHot(5));

				fG : flipflop PORT MAP(D => OneHot(6), Clock => KEY1, Resetn => SW(0), Q => OneHot(6));
				fH : flipflop PORT MAP(D => OneHot(7), Clock => KEY1, Resetn => SW(0), Q => OneHot(7));
				fI : flipflop PORT MAP(D => OneHot(8), Clock => KEY1, Resetn => SW(0), Q => OneHot(8));

		END PROCESS;

	Z_out <= '1' WHEN (OneHot = "000010001" OR OneHot = "100000001") ELSE '1';

	LEDR <= "0000000001" WHEN (OneHot = "000010001" OR OneHot = "100000001") ELSE "0000000000";
	Z <= Z_out; 

END Behavior;