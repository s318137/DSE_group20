LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY part4 IS
	PORT (
		clock_50 : IN std_logic;
		key : IN std_logic_vector(3 DOWNTO 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT std_logic_vector(0 TO 6)
	);
END part4;

ARCHITECTURE behavior OF part4 IS

	COMPONENT D_flipflop IS
		PORT (
			d, clk, rst : IN std_logic;
			q : OUT std_logic
		);
	END COMPONENT;

	COMPONENT register_7b IS
		PORT (
			load_in : IN std_logic_vector(0 TO 6);
			output : OUT std_logic_vector(0 TO 6);
			clk, load_en, rst : IN std_logic
		);
	END COMPONENT;

	COMPONENT pulse_1hz IS
		PORT (
			clk, s_rst: IN std_logic;
			pulse_out: OUT std_logic
		);
	END COMPONENT;

	TYPE state_type IS (a, b, c, d, e, f, g, h);

	SIGNAL c_state, n_state : state_type;
	SIGNAL pulse, load_en : std_logic;
	SIGNAL logic_out, reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5 : std_logic_vector(0 TO 6);
	
	BEGIN

		HEX0 <= reg_out0;
		HEX1 <= reg_out1;
		HEX2 <= reg_out2;
		HEX3 <= reg_out3;
		HEX4 <= reg_out4;
		HEX5 <= reg_out5;

		Dff : D_flipflop PORT MAP (pulse,clock_50, key(0), load_en);

		pulse0 : pulse_1hz PORT MAP (clock_50, key(0), pulse);

		reg0 : register_7b PORT MAP (logic_out, reg_out0, clock_50, load_en, key(0));
		reg1 : register_7b PORT MAP (reg_out0, reg_out1, clock_50, load_en, key(0));
		reg2 : register_7b PORT MAP (reg_out1, reg_out2, clock_50, load_en, key(0));
		reg3 : register_7b PORT MAP (reg_out2, reg_out3, clock_50, load_en, key(0));
		reg4 : register_7b PORT MAP (reg_out3, reg_out4, clock_50, load_en, key(0));
		reg5 : register_7b PORT MAP (reg_out4, reg_out5, clock_50, load_en, key(0));

		--state ff
		PROCESS (clock_50)
			BEGIN

				IF (clock_50'event AND clock_50 = '1') THEN
					IF (key(0) = '1') THEN
						c_state <= n_state;
					ELSE
						c_state <= a;
					END IF;
				END IF;

		END PROCESS;

		--state table
		PROCESS (c_state,pulse) 
			BEGIN

				IF (pulse = '1') THEN
					CASE c_state is
						WHEN a => n_state <= b;
						WHEN b => n_state <= c;
						WHEN c => n_state <= d;
						WHEN d => n_state <= e;
						WHEN e => n_state <= f;
						WHEN f => n_state <= g;
						WHEN g => n_state <= h;
						WHEN h => n_state <= h;
						WHEN OTHERS => n_state <= a;
					END CASE;
				ELSE 
					n_state <= c_state;
				END IF;

		END PROCESS;

		--output logic
		PROCESS (c_state, reg_out5)
			BEGIN

				CASE c_state is
					WHEN a => logic_out <= (others => '1');
								
					WHEN b => logic_out <= "1001000"; --1001000
								
					WHEN c => logic_out <= "0110000"; --0110000
								
					WHEN d => logic_out <= "1110001"; --1110001
								
					WHEN e => logic_out <= "1110001"; --1110001
								
					WHEN f => logic_out <= "0000001"; --0000001
								
					WHEN g => logic_out <= (others => '1'); --others=>1
								
					WHEN h => logic_out <= reg_out5;
								
					WHEN others => logic_out <= (others => '1');
				END CASE;

		END PROCESS;

END behavior;