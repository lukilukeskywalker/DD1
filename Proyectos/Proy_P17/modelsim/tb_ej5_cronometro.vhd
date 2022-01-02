-- Test del cronometro del ejercicio 5
-- Para ser completado por los estudiantes



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity test_cronometro is
end entity;

architecture test of test_cronometro is
 signal clk       : std_logic;
 signal rst_n     : std_logic;
 signal sto_1     : std_logic;
 signal sto_2     : std_logic;
 signal ini_c     : std_logic;
 signal seg_u     : std_logic_vector(3 downto 0);
 signal seg_d     : std_logic_vector(3 downto 0);
 signal dec       : std_logic_vector(3 downto 0);
 signal seg_u_st1 : std_logic_vector(3 downto 0);
 signal seg_d_st1 : std_logic_vector(3 downto 0);
 signal dec_st1   : std_logic_vector(3 downto 0);
 signal seg_u_st2 : std_logic_vector(3 downto 0);
 signal seg_d_st2 : std_logic_vector(3 downto 0);
 signal dec_st2   : std_logic_vector(3 downto 0);
 constant T_CLK : time := 20 ns;
 signal end_sim : boolean := false;
begin

 dut: entity work.cronometro(rtl) port map(
  clk       => clk,
  rst_n     => rst_n,
  sto_1     => sto_1,
  sto_2     => sto_2,
  ini_c     => ini_c,
  seg_u     => seg_u,
  seg_d     => seg_d,
  dec       => dec,
  seg_u_st1 => seg_u_st1,
  seg_d_st1 => seg_d_st1,
  dec_st1   => dec_st1,
  seg_u_st2 => seg_u_st2,
  seg_d_st2 => seg_d_st2,
  dec_st2   => dec_st2
 );

 process
 begin
   clk <= '0';
   wait for T_CLK/2;
   clk <= '1';
     if end_sim = true then
       wait;
     end if;
   wait for T_CLK/2;
 end process;
 process
 begin
   rst_n <= '0';
   sto_1 <= '0';
   sto_2 <= '0';
   ini_c <= '0';
   wait until clk'event and clk = '1';
   wait until clk'event and clk = '1';
   rst_n <= '1';
   wait until clk'event and clk = '1';
   -- Entradas inactivas, las salidas deben permanecer sin cambios
   wait for 12*T_CLK;
   wait until clk'event and clk = '1';
   -- Pulso de inicio
   ini_c <= '1';
   wait until clk'event and clk = '1';
   ini_c <= '0';
   -- Para ser completado por los estudiantes
   
   
   
   
   
   
   
   -- Fin del test
   wait until clk'event and clk = '1';
   end_sim <= true;
   wait;
 end process;
end test;
