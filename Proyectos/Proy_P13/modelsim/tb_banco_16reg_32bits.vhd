library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_banco_16reg_32bits is
end entity;

architecture test of tb_banco_16reg_32bits is
	signal clk: std_logic;
	signal nRst: std_logic;
	signal WE: std_logic;
	signal Dir_WR: std_logic_vector(3 downto 0);
	signal Din: std_logic_vector(31 downto 0);
	signal Dir_RD: std_logic_vector(3 downto 0);
	signal Dout: std_logic_vector(31 downto 0);

	constant T_CLK: time := 100ns;

begin
	dut: entity Work.banco_16reg_32bits(rtl)
		port map(clk => clk,
			nRst =>nRst,
			WE => WE,
			Dir_WR => Dir_Wr,
			Din => Din,
			Dir_RD => Dir_RD,
			Dout => Dout
			);

clk_sim: process
begin
	clk <='0';
	wait for T_CLK/2;
	clk <='1';
	wait for T_CLK/2;
end process clk_sim;

stimuli: process
begin
	nRst <= '0';
	wait until clk'event and clk ='1';
	nRst <= '1'
	for posicion in 0 to 15 loop
		Dir_WR <= posicion;
		Din <= posicion;
		wait until clk'event and clk ='1';
	end loop;
	for posicion in 0 to 15 loop
		Dir_RD <= posicion;
		Din <= posicion;
		wait until clk'event and clk ='1';
	end loop;

	wait;

end process stimuli;

end test;
