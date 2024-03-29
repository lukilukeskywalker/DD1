
library ieee;
use ieee.std_logic_1164.all;

entity tb_NA_32_conf is
end entity;

architecture test of tb_NA_32_conf is
	signal an_rst, clk: std_logic;
	signal ENT: std_logic_vector(31 downto 0);
	signal LOAD: std_logic;
	signal nENA: std_logic;
	
	constant T_CLK: time:=100ns;

begin
	dut: entity Work.NA_32_conf(rtl)
		port map(an_rst=>an_rst,
			clk=>clk,
			ENT=>ENT,
			LOAD=>LOAD,
			nENA=>nENA
		);
clk_sim: process
begin
	clk<='0';
	wait for T_CLK/2;
	clk<='1';
	wait for T_CLK/2;
end process clk_sim;

stimuli: process
begin 
	an_rst <='0';
	LOAD<='0';
	nENA<='0';
	ENT<=x"AAAAAAAA";
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	an_rst<='1';
	LOAD <= '1';
	wait until clk'event and clk ='1';--En este momento el tick ni si quiera  inicializado xD
	wait until clk'event and clk ='1';
	LOAD<='0';
	nENA<='1';
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	nENA <='0';
	wait until clk'event and clk ='1';
	wait until clk'event and clk='1';
	wait until clk'event and clk = '1';
	wait;
end process stimuli;
end test;