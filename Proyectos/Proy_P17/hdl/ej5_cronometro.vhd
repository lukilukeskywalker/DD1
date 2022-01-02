-- Modelo para el Cronometro del ejercicio 5
-- Tiene errores sintácticos que hay que corregir
-- También tiene 3 errores funcionales que se pueden corregir por separado



library ieee;
use ieee.std_logic_1164.all;

entity cronometro is port(
 clk       : in std_logic;
 rst_n     : in std_logic;
 sto_1     : in std_logic;
 sto_2     : in std_logic;
 ini_c     : in std_logic;
 seg_u     : buffer std_logic_vector(3 downto 0);
 seg_d     : buffer std_logic_vector(3 downto 0);
 dec       : buffer std_logic_vector(3 downto 0);
 seg_u_st1 : buffer std_logic_vector(3 downto 0);
 seg_d_st1 : buffer std_logic_vector(3 downto 0);
 dec_st1   : buffer std_logic_vector(3 downto 0);
 seg_u_st2 : buffer std_logic_vector(3 downto 0);
 seg_d_st2 : buffer std_logic_vector(3 downto 0);
 dec_st2   : buffer std_logic_vector(3 downto 0)
);
end entity;

architecture rtl of cronometro is
signal cnt       : std_logic_vector(22 downto 0);
signal tic       : std_logic;
signal ena       : std_logic;
signal eoc_dec   : std_logic;
signal eoc_seg_u : std_logic;
signal eoc_seg_d : std_logic;
signal reset     : std_logic;
signal seg_u     : std_logic_vector(3 downto 0);
signal seg_d     : std_logic_vector(3 downto 0);
signal dec       : std_logic_vector(3 downto 0);
signal seg_u_st1 : std_logic_vector(3 downto 0);
signal seg_d_st1 : std_logic_vector(3 downto 0);
signal dec_st1   : std_logic_vector(3 downto 0);
signal seg_u_st2 : std_logic_vector(3 downto 0);
signal seg_d_st2 : std_logic_vector(3 downto 0);
signal dec_st2   : std_logic_vector(3 downto 0);

-- Para diseño físico descomentar la línea 47 y comentar la 48
-- constant T_DEC : integer := 5000000; -- para diseño físico (con reloj de 50 MHz) 
constant T_DEC : integer := 5;-- para simulación
begin
 -- Subsistema_1
 process(clk, rst_n)
 begin
   if rst_n = '0' then
     cnt <= (0 => '1',others => '0');
   elsif clk'event and clk = '1' then
     if tic = '1' or reset = '1' then
       cnt <= (0 => '1',others => '0');
     else
       cnt <= cnt + 1;
     end if;
   end if;  
 end process;

 tic <= '1' when cnt = T_DEC else '0';
 -- Para sincronizar la cuenta con inic_c
 reset <= '1' when ini_c = '1' and ena = '1' else '0';
 -- Fin subsistema_1

 -- Subsistema_2
 process(clk, rst_n)
 begin
  if rst_n = '0' then
    ena <= '0';
  elsif clk'event and clk = '1' then
    if ini_c = '1' then
      ena <= '1';
    elsif (seg_d&seg_u&dec) = X"599" and tic = '1' then
      ena <= '0';
    end if;
  end if;  
 end process;

 -- Fin subsistema_2
 -- Subsistema_3
 
process(clk, rst_n)
 begin
   if rst_n = '0' then
     dec <= (others => '0');
   elsif clk'event and clk = '1' then
     if  ena = '1' and tic = '1' then
       if eoc_dec = '1' then
         dec <= (others => '0');
       else
         dec <= dec + 1;
       end if;
     end if;
   end if;  
 end process;

 eoc_dec <= '1' when ena = '1' and dec = '9' else '0';

 process(clk, rst_n)
  begin
    if rst_n = '0' then
      seg_u <= (others => '0');
    elsif clk'event and clk = '1' then
      if eoc_dec <= '1' and tic = '1' then
        if eoc_seg_u = '1' then
          seg_u <= (others => '0');
        else
          seg_u <= seg_u + 1;
        end if;
      end if;
    end if;  
  end process;

 eoc_seg_u <= '1' when eoc_dec = '1' and seg_u = '9' else '0';
 
 process(clk, rst_n)
  begin
    if rst_n = '0' then
      seg_d <= (others => '0');
    elsif clk'event and clk = '1' then
      if eoc_seg_u = '1' and tic = '1' then
        if eoc_seg_d = '1' then
          seg_d <= (others => '0');
        else
          seg_d <= seg_d + 1;
        end if;
      end if;
    end if;  
  end process;

 eoc_seg_d <= '1' when eoc_seg_u = '1' and seg_d = '9' else '0'; 

-- Fin subsistema_3

-- Subsistema_4

 process(clk, rst_n)
 begin
   if rst_n = '0' then
    seg_u_st1 <= (others => '0');
    seg_d_st1 <= (others => '0');
    dec_st1   <= (others => '0');
    seg_u_st2 <= (others => '0');
    seg_d_st2 <= (others => '0');
    dec_st2   <= (others => '0');
   elsif clk'event and clk = '1' then
     if sto_1 = '1' then
      seg_u_st1 <= seg_u;
      seg_d_st1 <= seg_d;
      dec_st1   <= dec;
     end if;
     if sto_2 = '1' then
      seg_u_st2 <= seg_u;
      seg_d_st2 <= seg_d;
      dec_st2   <= dec;
     end if;
   end if;  
 end process;

-- Fin subsistema_4

end rtl;