-- Autor: DTE
-- Fecha: 9-9-2016
-- Test de un divisor de frecuencia realizado para la actividad ATGP4 
-- del  bloque I de Diseño digital I versión 1.1 

library ieee;
use ieee.std_logic_1164.all;

entity div_freq_4_tb is
end entity;

architecture test of div_freq_4_tb is 
  signal clk:   std_logic;
  signal nRST:  std_logic;
  signal freq_div_4: std_logic;
  
  constant T_CLK: time := 100 ns;
  
begin
  

dut: entity work.div_freq_4(rtl)
     port map(clk => clk,
              nRST => nRST,
              freq_div_4 => freq_div_4);

process
begin
  clk <= '0';
  wait for T_CLK/2;
  clk <= '1';
  wait for T_CLK/2;
end process;

process
begin
-- Inicialización asíncrona
   nRST <= '0';     
   wait until clk'event and clk = '1';  
   wait until clk'event and clk = '1'; 
   nRST <= '1';
-- Espera el tiempo suficiente para visualizar 4 periodos en la salida del divisor
   wait for 18*T_CLK;
   wait;
end process;
      
end test;


