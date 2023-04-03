LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity part5 is 
port (clock_50 : in std_logic;
		ledr : out std_logic_vector(9 downto 0);
		sw : in std_logic_vector(9 downto 0);
		key : in std_logic_vector(3 downto 0);
		hex0,hex1,hex2,hex3 : out std_logic_vector(0 to 6)
		);
end part5;

architecture structure of part5 is
component timer_outside_tap is
port (clk,en,rst : in std_logic;
		ref : in unsigned(31 downto 0);
		display_out : out std_logic_vector(0 to 6)
		);
end component;
component SR_latch is
port (s,r,rst : in std_logic;
		output : out std_logic);
end component;
component pulse_outside_tap is
port (clk,en,rst : in std_logic;
		pulse_out : out std_logic;
		ref : in unsigned(31 downto 0)
		);
end component;
component comparator_32b is 
port (input,ref : in unsigned(31 downto 0);
		output : out std_logic
		);
end component;
component counter_32b is
port (rst,clk,en: IN STD_LOGIC; 
      output : buffer unsigned(31 downto 0)
		);
end component;
signal timer_en,pulse_out,pulse_en,comparator_out,sr_out,sr_in : std_logic;
signal counter_out,comparator_ref : unsigned(31 downto 0);
begin
comparator_ref(31 downto 8) <= (others => '0');
comparator_ref(7 downto 0) <= unsigned(sw(7 downto 0));
sr_in <= not(key(3));
timer1 : timer_outside_tap port map (clock_50,timer_en,key(0),x"0000C34F",hex0);
timer2 : timer_outside_tap port map (clock_50,timer_en,key(0),x"0007A11F",hex1);
timer3 : timer_outside_tap port map (clock_50,timer_en,key(0),x"004C4B3F",hex2);
timer4 : timer_outside_tap port map (clock_50,timer_en,key(0),x"02FAF07F",hex3);
pulse1 : pulse_outside_tap port map (clock_50,pulse_en,key(0),pulse_out,x"0000C34F");
counter1 : counter_32b port map (key(0),clock_50,pulse_out,counter_out);
comparator1 : comparator_32b port map (counter_out,comparator_ref,comparator_out);
latch : SR_latch port map (sr_in,'0',key(0),sr_out);
timer_en <= not(sr_out) and comparator_out;
pulse_en <= not(comparator_out);
ledr(0) <= timer_en;
end structure;