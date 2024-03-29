
library ieee;
use ieee.std_logic_1164.all;

entity tb_num_por_3 is
end entity;

architecture test of tb_num_por_3 is
signal an_rst 	: std_logic;
signal clk 	: std_logic;
signal data_in	: std_logic;
signal data_out	: std_logic;
constant T_CLK	:time	:= 100ns;

begin

	dut: entity work.num_por_3(rtl) port map(
		clk => clk,
		an_rst	=> an_rst,
		data_in	=> data_in,
		data_out=> data_out
	);

reloj : process
begin
	clk<='0';
	wait for T_CLK/2;
	clk<='1';
	wait for T_CLK/2;
end process;

estimulos: process
begin
an_rst <= '0';
data_in<='0';
wait for 300 ns;

wait until clk'event and clk = '1';
an_rst<='1';
data_in <='1';
wait until clk'event and clk = '1';
data_in <='1';
wait until clk'event and clk = '1';
data_in <='1';
wait until clk'event and clk = '1';
data_in <='1';
wait until clk'event and clk = '1';
data_in <='0';
wait until clk'event and clk = '1';
data_in <='1';
wait until clk'event and clk = '1';
data_in <='0';
wait until clk'event and clk = '1';
data_in <='0';

wait until clk'event and clk = '1';
data_in <='0';
wait until clk'event and clk = '1';
data_in <='0';
end process;
end test;

