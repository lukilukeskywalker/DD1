
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity acumulador_moore is
  port(rst, clk: in std_logic;
      ena: in std_logic;
      E: in std_logic_vector(7 downto 0);
      S: buffer std_logic_vector(12 downto 0)
  );
  
end entity acumulador_moore;

architecture rtl of acumulador_moore is
  signal SUM: std_logic_vector(12 downto 0);
  
begin
acumulador: process(rst, clk)
begin
  if(rst='0') then  S <=x"000"&'0';
  elsif(clk'event and clk='1') then
    if(ENA = '1') then 
      SUM<=("00000"&E)+S;
      S <= SUM;
    end if;
  end if;
end process acumulador;
end rtl;
  
      
                  
    