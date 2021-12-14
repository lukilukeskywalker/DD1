
-- Es una maquina de estados que tiene un entrada y una salida
-- La entrada mete valores 0's o 1's. Solo cuando se ha metido 
-- un 0, primero, un 1, segundo, y un 1, segundo, se activa la 
-- salida s

library ieee;
use ieee.std_logic_1164.all;

entity det_011 is
	port(an_rst, clk: in std_logic;
		data_in	: in std_logic;
		det	: buffer std_logic
	);
end entity det_011;
architecture rtl of det_011 is
	type t_estado is (nada, d_0, d_01, d_011);	--Creamos unas definiciones nuevas, que definiran nuestro estado en la maquina de estados 
	signal estado: t_estado;
begin
proc_estado : process(an_rst, clk)
begin
	if(an_rst = '0') then estado<=nada;
	elsif (clk'event and clk = '1') then
		if(data_in = '1') then
			if(estado=d_0) then estado<=d_01;
			elsif(estado=d_01) then estado<=d_011;
			elsif(estado=d_011) then estado<=nada;
			else estado<=nada;
			end if;
		else estado<=d_0;
		end if;
	end if;
end process proc_estado;

proc_salida : process(estado)
begin
	if(estado = d_011) then det<='1';
	else det<='0';
	end if;
end process proc_salida;

end architecture rtl;
--Va creo que he codificado correctmente esto...
		