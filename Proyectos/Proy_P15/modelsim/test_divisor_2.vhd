library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_divisor_2 is
end entity;

architecture test of test_divisor_2 is
  
  signal clk:     std_logic;
  signal nRst:    std_logic;
  signal f_out_1: std_logic;
  signal f_out_2: std_logic;
  
  signal f_out: integer :=0;
  signal end_simulation: boolean := false;
  
  -- modifique la siguiente constante para un reloj de 12 MHz
  constant T_clk: time := 83.3 ns;
  
begin
dut: entity Work.divisor_2(rtl)
     port map(clk     => clk,
              nRst    => nRst,
              f_out_1 => f_out_1,
              f_out_2 => f_out_2);
              
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
  -- 5 per�odos de reloj ed la salida f_out_2
  wait until f_out=5;
  end_simulation <= true;
  
end process;
process(clk)
begin
  if(clk'event and clk='1') then
		if(f_out_2 ='1') then 
			f_out<=f_out+1;
		end if;
  end if;
end process;

end test;