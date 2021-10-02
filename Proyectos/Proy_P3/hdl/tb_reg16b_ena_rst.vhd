
--Test Bench para un sistema secuencial shift Register Lineal de 16 bits
--Entrada de reset, clk, y enable
-- Autor Lukas

library ieee;
use ieee.std_logic_1164.all;

entity reg16b_ena_rst_TB is
end entity;

--Declaracion de señales
architecture Test of reg16b_ena_rst_TB is
	signal clk: std_logic;
	signal nRST: std_logic;
	signal sRst: std_logic;
	signal ena: std_logic;
	signal Din: std_logic_vector(15 downto 0);
	signal Dout: std_logic_vector(15 downto 0);

	constant T_CLK: time:= 100ns;	--Declaracion de Constante CLK

begin
--Emplazamiento del modelo
dut: entity Work.reg16b_ena_rst(rtl)
	port map(clk => clk,
		nRST=>nRST,
		sRst=>sRst,
		ena=>ena,
		Din=>Din,
		Dout=>Dout);
--Generacion de Reloj
process
begin
	clk<='0';
	wait for T_CLK/2;
	clk<='1';
	wait for T_CLK/2;
end process;

process
begin
	nRST <='0';
	sRst<='0';
	ena<='0';
	Din<=x"0000";

	wait until clk'event and clk = '1';
	wait until clk'event and clk = '1';
 	nRst <='1';
	ena <='1';
	Din <= X"AAAA";
	
	wait until clk'event and clk = '1';
	sRst <='1';

	wait until clk'event and clk = '1';
	sRst <='0';
	Din<= X"5555";
	
	wait until clk'event and clk = '1';
	ena<='0';
	Din<=X"1234";
	wait until clk'event and clk = '1';
	sRst<='1';

	wait until clk'event and clk = '1';
	wait;
end process;
end Test;
