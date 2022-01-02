
--test bench para el conversor bcd a bin
--Lukas Gdanietz

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_CONV_BCD_A_BIN_SEC_PSEUDO is
end entity;

architecture test of tb_CONV_BCD_A_BIN_SEC_PSEUDO is
	signal clk, nRst: std_logic;
	signal DIGITO : std_logic_vector(3 downto 0);
	signal PESO_DIGITO : std_logic_vector(1 downto 0);
	signal WE_DIGITO : std_logic;
	signal START : std_logic;
	signal RESULTADO : std_logic_vector(13 downto 0);
	signal FIN_OP : std_logic;

	signal ena_bcd_conv: std_logic;
	signal bin_digit : std_logic_vector( 13 downto 0);
	--signal sel_dig_bcd_conv: std_logic_vector(1 downto 0); --Equivalente a PESO_DIGITO
	signal end_bcd_conv: std_logic;
		

	signal pos_array: integer := 0;
	constant T_CLK: time := 1 us;
	signal fin: boolean := false;

	begin 
	  dut: entity work.conv_bcd_a_bin_sec_pseudo(estructural)
		port map(nRst => nRst,
			clk=>clk,
			DIGITO=>DIGITO,
			PESO_DIGITO=>PESO_DIGITO,
			WE_DIGITO=>WE_DIGITO,
			START => START,
			RESULTADO=>RESULTADO,
			FIN_OP => FIN_OP
			);

	  comp: entity work.bin_to_bcd(rtl)
		port map(nRst => nRst,
			clk=>clk,
			bin_in => bin_digit,
			ENA => ena_bcd_conv,
			sel_dig => PESO_DIGITO,
			BCD=> DIGITO,
			C_END=>end_bcd_conv 
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
--Para validar el modelo que ha realizado debe comprobar que el circuito convierte correctamente un
--conjunto reducido, pero representativo, de números decimales; por ejemplo: 0, 4, 12, 20, 345, 607,
--890, 1234, 2760, 5800 7003 y 9999
	proc_stimuli: process
	begin
		nRst <= '0';
		PESO_DIGITO <= "00";
		WE_DIGITO <= '0';
		START <= '0';
		wait until clk'event and clk ='1';
		wait until clk'event and clk ='1';
		nRst <= '1';
		for j in 0 to 11 loop
			pos_array <= j;
			--bin_digit <= "00000000000000" +1234;
			ena_bcd_conv <= '1';
			wait until clk'event and clk = '1';
			ena_bcd_conv <= '0';
			wait until clk'event and clk = '1' and end_bcd_conv = '1';
			WE_DIGITO <= '1';
			for i in 0 to 3 loop
				PESO_DIGITO <= "00" + i;--Cargamos el digito en los registros
				wait until clk'event and clk = '1';
			end loop;
			WE_DIGITO <= '0';
			wait until clk'event and clk = '1';
			wait until clk'event and clk = '1';
			START <= '1';
			wait until clk'event and clk = '1';
			START <= '0';
			wait until clk'event and clk = '1' and FIN_OP = '1';
			wait until clk'event and clk = '1';
		end loop;
		fin<=true;
		
		wait;
	end process proc_stimuli;

	bin_digit <="00000000000000" +0 when pos_array = 0 else
			"00000000000000" +4 when pos_array = 1 else
			"00000000000000" +12 when pos_array = 2 else
			"00000000000000" +20 when pos_array = 3 else
			"00000000000000" +345 when pos_array = 4 else
			"00000000000000" +607 when pos_array = 5 else
			"00000000000000" +890 when pos_array = 6 else
			"00000000000000" +1234 when pos_array = 7 else
			"00000000000000" +2760 when pos_array = 8 else
			"00000000000000" +5800 when pos_array = 9 else
			"00000000000000" +7003 when pos_array = 10 else
			"00000000000000" +9999;
end test;