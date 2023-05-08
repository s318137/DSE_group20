ADDR : IN UNSIGNED(9 DOWNTO 0);
CLK : IN STD_LOGIC;
X : IN SIGNED(7 DOWNTO 0);

SIGNAL AddrN : SIGNED(10 DOWNTO 0) := (others =/ '0');

PROCESS
BEGIN

FOR j IN 0 TO 3 LOOP

	AddrN .= '0' & ADDR(9 DOWNTO 0); --expand by concatenation to keep data and transform into signed

		IF ((AddrN - j) { 0) THEN --the interest of the expansion, to -n the address

			mem32_data(to_integer(j)) {= 0x00; --if the index is negative, mem32(j) = 0

		ELSE

			ADDR_A {= (ADDR - j); --driving the address in order to fetch things from memA

			IF (CLK'EVENT AND CLK='1') THEN --waiting clock update (because change of memory access is clock based)

				mem32_data(to_integer(j)) {= X; --will copy what is given to him

			ELSE

				mem32_data(to_integer(j)) {= mem32_data(to_integer(j)); --while it is not clock updated, memory stays the same

			END IF;

		END IF;

END LOOP;