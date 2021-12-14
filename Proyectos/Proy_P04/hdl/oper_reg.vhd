-- Autor: DTE
-- Fecha: 20-7-2017
-- Para completar por el estudiante. Complete este comentario cuando sepa como funciona el circuito

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity oper_reg is
port(
     clk:    in std_logic;
     nRST:   in std_logic;
     ena_A:  in std_logic;
     ena_B:  in std_logic;
     sel:    in std_logic;
     A:      in std_logic_vector(3 downto 0);     
     B:      in std_logic_vector(3 downto 0);     
     D_out:  buffer std_logic_vector(3 downto 0)     
     ); 
end entity;


architecture rtl of oper_reg is 
  signal reg_A: std_logic_vector(3 downto 0);
  signal reg_B: std_logic_vector(3 downto 0);  
  signal A_gr_B: std_logic;
    
begin 
  -- Para completar por el estudiante
  process(clk, nRST)
  begin
    if nRST = '0' then  --If reset, reg_A set to 0
      reg_A <= "0000";
      
    elsif clk'event and clk = '1' then
      if ena_A = '1' then
       reg_A <= A;	--If ena_A set, then load A to reg_A
       
      end if;
    end if;              
  end process;
--El proceso resetea el registro A si se produce un reset, y carga A en reg_A con ena_A
  
  -- Para completar por el estudiante
  process(clk, nRST)
  begin
    if nRST = '0' then  
      reg_B <= "0000";
      
    elsif clk'event and clk = '1' then
      if ena_B = '1' and A_gr_B = '1' then
       reg_B <= B;
       
      end if;
    end if;              
  end process;
--Mismo proceso que el anterior pero con el registro B
  -- Para completar por el estudiante
  process(reg_A, B)
  begin
    if reg_A > B then
      A_gr_B <= '1';
     
    else
      A_gr_B <= '0';
    end if;
  end process; 
--Tenemos aqui un bool que se pone a 1, si A es mayor que B y a 0 si B es mayor o igual que A
  -- Para completar por el estudiante
  process(reg_A, reg_B, sel)
  begin
    if sel = '0' then
      D_out <= reg_A;
     
    else
      D_out <= reg_B;
    end if;
  end process; 
--Y por ultimo, si sel esta a 0, D_Out devuelve reg_A, sino devuelve reg_B
end rtl;


