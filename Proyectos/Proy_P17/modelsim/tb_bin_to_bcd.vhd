
-- test bench para el conversor bin a bcd
--Lukas Gdanietz

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_bin_to_bcd is
end entity;

architecture test of tb_bin_to_bcd is
	signal clk, nRst: std_logic;
	signal bin_in: std_logic_vector(13 downto 0);
	signal ENA: std_logic;
	signal sel_dig: std_logic_vector(1 downto 0);
	signal BCD: std_logic_vector(3 downto 0);
	signal C_END: std_logic;

	constant T_CLK: time := 1 us;
	signal fin: boolean := false;

	begin
	  dut: entity work.bin_to_bcd(rtl)
		port map(nRst => nRst,
			clk => clk,
			bin_in => bin_in,
			ENA => ENA,
			sel_dig => sel_dig,
			BCD => BCD,
			C_END => C_END
			);

	clk_sim: process
	begin
		clk <= '1';
		wait for T_CLK/2;
		clk <= '0';
		wait for T_CLK/2;
		if fin = true then 
			wait;
		end if;
	end process clk_sim;

	proc_stimuli: process
	begin
		nRst <= '0';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		nRst <= '1';
		bin_in <= "01"&"1000"&"1001"&"1001";
		ENA <= '1';
		sel_dig <="00";
		wait until clk'event and clk = '1';
		ENA <= '0';
		for z in 0 to 16 loop
			wait until clk'event and clk = '1';
		end loop;
		for z in 0 to 3 loop
			sel_dig <= "00" +z;
			wait until clk'event and clk = '1';
		end loop;
		wait;
end process proc_stimuli;

end test;