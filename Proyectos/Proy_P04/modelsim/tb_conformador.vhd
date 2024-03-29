-- Autor: TBC
-- Fecha: TBC
-- Test del curcuito conformador
-- El test genera un pulso corto (de un periodo de reloj) y un pulso largo
-- (de varios per�odos de reloj)

library ieee;
use ieee.std_logic_1164.all;

entity tb_conformador is
end entity;

architecture test of tb_conformador is
signal clk : std_logic;
signal an_rst : std_logic;
signal e : std_logic;
signal s : std_logic;
constant T_CLK : time := 100 ns;

begin

  dut: entity work.conformador(rtl) port map(
    clk    => clk,
    an_rst => an_rst,
    e      => e,
    s      => s
  );

  reloj: process	--Proceso de reloj
  begin
    clk <= '0';
    wait for T_CLK/2;
    clk <= '1';
    wait for T_CLK/2;
  end process;

  estimulos: process
  begin
    an_rst <= '0';
    e <= '0';
    wait for 300 ns;
    wait until clk'event and clk = '1';
    an_rst <= '1';			--Producimos un evento de reset. Siguiente paso, Ponemos a 0->e, sig 1->e sig 0->e sig e>1 sig e>1 sig e>1
    wait until clk'event and clk = '1';
    an_rst <= '0';
    e <= '0';
    wait until clk'event and clk = '1';
    an_rst <= '0';
    e <= '1';
    wait until clk'event and clk = '1';
    an_rst <= '0';
    e <= '0';
    wait until clk'event and clk = '1';
    an_rst <= '0';
    e <= '1';
    wait until clk'event and clk = '1';
    wait until clk'event and clk = '1';
    wait until clk'event and clk = '1';
    an_rst <= '1';
    e <= '0';
    wait until clk'event and clk = '1';
    e <= '1';
    wait until clk'event and clk = '1';
    e <= '0';
    wait until clk'event and clk = '1';
    e <= '1';
    wait until clk'event and clk = '1';
    wait until clk'event and clk = '1';
    wait until clk'event and clk = '1';

    wait;
  end process;
end test;