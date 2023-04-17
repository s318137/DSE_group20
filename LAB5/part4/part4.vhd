library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part4 is
port (clock_50 : in std_logic;
		key : in std_logic_vector(3 downto 0);
		HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out std_logic_vector(0 to 6)
		);
end part4;

architecture behavior of part4 is
component D_flipflop is
port (d,clk,rst : in std_logic;
		q : out std_logic);
end component;

component register_7b is
port (load_in : in std_logic_vector(0 to 6);
		output : out std_logic_vector(0 to 6);
		clk,load_en,rst : in std_logic
		);
end component;

component pulse_1hz is
port (clk,s_rst: in std_logic;
		pulse_out: out std_logic
		);
end component;

type state_type is (a,b,c,d,e,f,g,h);
signal c_state,n_state : state_type;
signal pulse,load_en : std_logic;
signal logic_out,reg_out0,reg_out1,reg_out2,reg_out3,reg_out4,reg_out5 : std_logic_vector(0 to 6);
begin

HEX0 <= reg_out0;
HEX1 <= reg_out1;
HEX2 <= reg_out2;
HEX3 <= reg_out3;
HEX4 <= reg_out4;
HEX5 <= reg_out5;
Dff : D_flipflop port map (pulse,clock_50,key(0),load_en);
pulse0 : pulse_1hz port map (clock_50,key(0),pulse);
reg0 : register_7b port map (logic_out,reg_out0,clock_50,load_en,key(0));
reg1 : register_7b port map (reg_out0,reg_out1,clock_50,load_en,key(0));
reg2 : register_7b port map (reg_out1,reg_out2,clock_50,load_en,key(0));
reg3 : register_7b port map (reg_out2,reg_out3,clock_50,load_en,key(0));
reg4 : register_7b port map (reg_out3,reg_out4,clock_50,load_en,key(0));
reg5 : register_7b port map (reg_out4,reg_out5,clock_50,load_en,key(0));

--state ff
process (clock_50)
begin
if (clock_50'event and clock_50 = '1') then
	if (key(0) = '1') then
		c_state <= n_state;
	else
		c_state <= a;
	end if;
end if;
end process;

--state table
process (c_state,pulse) 
begin
if (pulse = '1') then
	case c_state is
	when a => n_state <= b;
	when b => n_state <= c;
	when c => n_state <= d;
	when d => n_state <= e;
	when e => n_state <= f;
	when f => n_state <= g;
	when g => n_state <= h;
	when h => n_state <= h;
	when others => n_state <= a;
	end case;
else 
	n_state <= c_state;
end if;
end process;

--output logic
process (c_state,reg_out5)
begin
case c_state is
when a => logic_out <= (others => '1');
			
when b => logic_out <= "1001000"; --1001000
			
when c => logic_out <= "0110000"; --0110000
			
when d => logic_out <= "1110001"; --1110001
			
when e => logic_out <= "1110001"; --1110001
			
when f => logic_out <= "0000001"; --0000001
			
when g => logic_out <= (others => '1'); --others=>1
			
when h => logic_out <= reg_out5;
			
when others => logic_out <= (others => '1');
end case;
end process;
end behavior;