
-- Test-bench de un decodificador
-- BCD a 7 segmentos realizado para
-- el tutorial de la actividad AINP4
-- (TBC)

-- Clausulas de visibilidad
library ieee;
use ieee.std_logic_1164.all;

-- Declaracion de entidad sin puertos
entity   tb_decodBCD7seg     is
end entity;

architecture test of tb_decodBCD7seg is
  signal digBCD: std_logic_vector(3 downto 0);   --Estimulo   -- (1) Tipos de datos  
  signal segDisp: std_logic_vector(6 downto 0); --Respuesta
 
  
begin
  --Modelo a verificar: decodificador BCD a 7 segmentos
  dut: entity Work.decodBCD7seg(rtl)                    -- (2) Lista de conexi?n
       port map(digBCD     => digBCD,    
                segDisp     => segDisp);
                                
  process
  begin                                        -- (3) Est?mulos
    digBCD <= "0000";  -- En T = 0 ns
    wait for 100 ns;  
    digBCD <= "0001";  -- En T = 100 ns
    wait for 100 ns;
    digBCD <= "0010";  -- En T = 100 ns
    wait for 100 ns;
    digBCD <= "0011";  -- En T = 0 ns
    wait for 100 ns;  
    digBCD <= "0100";  -- En T = 100 ns
    wait for 100 ns;  
    digBCD <= "0101";  -- En T = 0 ns
    wait for 100 ns;  
    digBCD <= "0110";  -- En T = 100 ns
    wait for 100 ns;  
    digBCD <= "0111";  -- En T = 0 ns
    wait for 100 ns;  
    digBCD <= "1000";  -- En T = 100 ns      
    wait for 100 ns;  
    digBCD <= "1001";  -- En T = 100 ns
    wait for 100 ns;  
    digBCD <= "1010";  -- En T = 0 ns
    wait for 100 ns;
    digBCD <= "1011";  -- En T = 0 ns
    wait for 100 ns; 
    digBCD <= "1100";  -- En T = 100 ns
    wait for 100 ns;  
    digBCD <= "1101";  -- En T = 0 ns
    wait for 100 ns;  
    digBCD <= "1110";  -- En T = 100 ns
    wait for 100 ns;  
    digBCD <= "1111";  -- En T = 0 ns
    wait for 100 ns;  
  
    wait;            
  end process;               
end test;