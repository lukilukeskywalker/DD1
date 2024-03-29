-- Autor: TBC
-- Fecha: TBC
-- TBC

library ieee;
use ieee.std_logic_1164.all;

entity conformador is
  port ( clk, an_rst : in     std_logic;
         e           : in     std_logic;	--Entrada sistema
         s           : buffer std_logic		--Salida sistema
         );
end entity conformador;

architecture rtl of conformador is
	signal Q_i: std_logic;
begin
-- Memoria de estado
proc_estado: process (clk, an_rst)
begin
  if an_rst = '0' then 
	Q_i<='0';				--Si reset esta puesto, salida de Biestable es 0
  elsif clk'event and clk = '1' then
    Q_i <= e;					--Si reset no esta puesto, y clk, entonces Q_i tiene el valor de la entrada
  end if;
end process proc_estado;
-- Calculo de la salida
proc_salida: process (Q_i, e)			--Sistema combinacional. Muy simple. si Q_i es 1, la salida es 0, si Q_i es 0, la salida es la entrada.
begin
   if Q_i = '1' then 
	s<='0';
   else s<=e;
   end if;

end process proc_salida;

end architecture rtl;
