
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_acumulador_moore is
end entity;

architecture test of tb_acumulador_moore is
  signal rst, clk: std_logic;
  signal ena: std_logic;
  signal E :std_logic_vector(7 downto 0);
  signal S :std_logic_vector(12 downto 0);
  
  constant T_CLK: time := 100 ns;
  
  begin
    dut: entity Work.acumulador_moore(rtl)
      port map(rst=>rst,
              clk=>clk,
              ena=>ena,
              E=>E,
              S=>S
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
    rst <='0';
    wait until clk'event and clk='1';
    E<=x"AA";
    rst <='1';
    ena<='1';
    wait until clk'event and clk='1';
    wait until clk'event and clk='1';
    wait until clk'event and clk='1';
    wait until clk'event and clk='1';
    wait until clk'event and clk='1';
    wait until clk'event and clk='1';
    ena<='0';
    wait until clk'event and clk='1';
    wait until clk'event and clk='1';
    wait;
    end process stimuli;
end test;
    
    
    
    
  