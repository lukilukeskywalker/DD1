
--Autor Lukas Gdanietz
--Objetivo Test Bench de CONT_BCD_MOD94
--Funciones:
	--Que el contador cuente cuando este habilitado y que no cuente cuando no lo este
	--Que la cuenta sigue la secuencia de num que van de 0 a 93, y que repite ciclicamente

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_contador_bcd_mod94 is
end entity;

architecture test of tb_contador_bcd_mod94 is
	signal clk, nRst: std_logic;
	signal ENA: std_logic;
	signal U: std_logic_vector(3 downto 0);
	signal D: std_logic_vector(3 downto 0);
	
	constant T_CLK: time := 100 ns;
	signal fin: boolean := false;
	signal clk_counter: integer :=0;
	signal bcd_counter: integer :=0;
	begin
	  dut: entity Work.cont_bcd_mod94(rtl)
		port map(nRst=>nRst,
			clk=>clk,
			ENA=>ENA,
			U=>U,
			D=>D
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
		clk_counter <= clk_counter +1;
	end process clk_sim;

	proc_stimuli: process
	begin	
		ENA <='0';
		nRst<='0';
		wait until clk'event and clk='1';
		wait until clk'event and clk='1';
		nRst<='1';
		wait until clk_counter = 50;
		wait until clk'event and clk='1';
		ENA <='1';
		--clk_counter <=0;
		wait until clk'event and clk='1';
		wait until clk_counter = 200;
	end process proc_stimuli;

	proc_bcd_counter: process(nRst, clk)
	begin
		if(nRst = '0') then
			bcd_counter <= 0;
		elsif(clk'event and clk='1') then 
			if(ENA = '1') then 
				bcd_counter <= bcd_counter + 1;
			end if;
		end if;
	end process proc_bcd_counter;
end test;
		
	