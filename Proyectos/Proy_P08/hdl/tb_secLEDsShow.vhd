--TB_secLEDsShow

library ieee;
use ieee.std_logic_1164.all;

entity tb_secLEDsShow is 
end entity;

architecture test of tb_secLEDsShow is
	signal an_rst: std_logic;
	signal clk: std_logic;
	signal LEDs : std_logic_vector(7 downto 0);
	signal segDisp : std_logic_vector(6 downto 0);
	signal P_1: std_logic;
	signal P_2: std_logic;
	
	constant T_CLK: time := 100ns;

begin

	dut: entity Work.secLEDsShow(rtl)
		port map(an_rst=> an_rst,
			clk=>clk,
			LEDs=>LEDs,
			segDisp=>segDisp,
			P_1=>P_1,
			P_2=>P_2
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
	P_1<='0';
	P_2<='0';
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	an_rst <='1';
	--Prueba Conformador 1
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	P_1<='0';
	wait for 30 ns;--Primera Prueba. Manteniendo Pulsador un largo rato activo
	P_1<='1';
	wait for 220 ns;
	P_1<='0';
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	P_1<='1';--Segunda prueba. Manteniendo Pulsador en un short burst
	wait for 30 ns;
	P_1<='0';
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	--Tercera prueba. Tiempo justo, como si fuera una maquina
	P_1<='1';
	wait until clk'event and clk ='1';
	P_1<='0';
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	--Finaliza prueba Conformador1
	--Iniciamos prueba COnformador2
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	P_2<='0';
	wait for 30 ns;--Primera Prueba. Manteniendo Pulsador un largo rato activo
	P_2<='1';
	wait for 220 ns;
	P_2<='0';
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	P_2<='1';--Segunda prueba. Manteniendo Pulsador en un short burst
	wait for 30 ns;
	P_2<='0';
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	--Tercera prueba. Tiempo justo, como si fuera una maquina
	P_2<='1';
	wait until clk'event and clk ='1';
	P_2<='0';
	wait until clk'event and clk ='1';
	wait until clk'event and clk ='1';
	--Hacemos un reset
	an_rst <='0';
	wait until clk'event and clk ='1';
	an_rst <='1';
	wait for 1500ns;
	--Y lo hacemos en el otro sentido
	P_2<='1';
	wait for 1000ns;
	--Con este wait deberiamos haber comprobado que los leds se van moviendo.
	
	wait; --Si no ponemos esto al final, el bucle se reinicia instantaneamente y nunca llega a ponerse a uno an_rst

end process stimuli;

end test;
