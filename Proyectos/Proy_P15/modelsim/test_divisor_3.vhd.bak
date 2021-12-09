library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_divisor_3 is
end entity;

architecture test of test_divisor_3 is
  signal clk:     std_logic;
  signal nRst:    std_logic;
  signal f_div_250: std_logic;
  signal f_div_125: std_logic;
  signal f_div_50: std_logic;
  
  signal end_simulation: boolean := false;
  
  -- modifique la siguiente constante para un reloj de 12 MHz
  constant T_clk: time := TBD ns;
  
begin
dut: entity Work.divisor_3(rtl)
     port map(clk       => clk,
              nRst      => nRst,
              f_div_250 => f_div_250,
              f_div_125 => f_div_125,
              f_div_50  => f_div_50);
              
-- reloj de 12 MHz
process
begin
  clk <= '0';
  wait for T_clk/2;
  clk <= '1';
  wait for T_clk/2;  
  if end_simulation = true then
    wait;
  end if;
end process;

-- Secuencia de test
process
begin
  -- Secuencia de reset
  wait until clk'event and clk = '1';
  wait until clk'event and clk = '1';
  nRst <= '1';                         -- Reset inactivo
  wait until clk'event and clk = '1';
  nRst <= '0';                         -- Reset activo
  wait until clk'event and clk = '1';
  nRst <= '1';                         -- Reset inactivo
  --Fin de secuencia de reset
  
  -- Complete el test para que puedan observarse
  -- 5 períodos de reloj ed la salida f_div_50
  
  
  
  
  
  
end process;

end test;