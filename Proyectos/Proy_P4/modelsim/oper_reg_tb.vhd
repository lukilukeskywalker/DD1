-- Autor: DTE
-- fecha: 9-9-2016
-- Test de un sistema complejo realizado para la actividad ATGP4 
-- del  bloque I de Diseño digital I versión 1.1 

library ieee;
use ieee.std_logic_1164.all;

entity oper_reg_tb is
end entity;

architecture test of oper_reg_tb is 
  signal clk:   std_logic;
  signal nRST:  std_logic;
  signal ena_A: std_logic;
  signal ena_B: std_logic;
  signal sel:   std_logic;    
  signal A:     std_logic_vector(3 downto 0);     
  signal B:     std_logic_vector(3 downto 0);     
  signal D_out:     std_logic_vector(3 downto 0);     
  
  constant T_CLK: time := 100 ns;
  
begin
  

dut: entity work.oper_reg(rtl)
     port map(clk => clk,
              nRST => nRST,
              ena_A => ena_A,
              ena_B => ena_B,
              sel => sel,
              A => A,
              B => B,
              D_out => D_out              
              );

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
   ena_A <= '0';
   ena_B <= '0';
   sel <= '0';
   A <= "0000";
   B <= "0000";  
   wait until clk'event and clk = '1';
   nRST <= '1';
 -- Carga de un dato en A  
   ena_A <= '1';    
   A <= "1010";
   wait until clk'event and clk = '1';
   ena_A <= '0';
-- Carga de un dato en B (menor que A)
   ena_B <= '1';    
   B <= "0010";
   sel <= '1';      -- Selección de B en la salida
   wait until clk'event and clk = '1';
-- Carga de un dato en B (igual que A)
   B <= "1010";     
   wait until clk'event and clk = '1';
-- Carga de un dato en B (mayor que A)
   B <= "1100";
   wait until clk'event and clk = '1';
   ena_B <= '0';
   sel <= '0';      -- Selección de A enla salida
-- Carga de un dato en A   
   ena_A <= '1';    
   A <= "0110";
   wait until clk'event and clk = '1';
   ena_A <= '0';
-- Carga de un dato en B (menor que A)
   ena_B <= '1';    
   B <= "0100";
   sel <= '1';      -- Selección de B en la salida
   wait until clk'event and clk = '1';
-- Carga de un dato en B (igual que A)
   B <= "0110";     
   wait until clk'event and clk = '1';
-- Carga de un dato en B (mayor que A)
   B <= "0111";
   wait until clk'event and clk = '1';   
   wait;
end process;
      
end test;


