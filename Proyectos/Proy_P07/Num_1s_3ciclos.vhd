--Objetivo crear una maquina de estados Moore, que devuelva en 
--S el numero de 1's en los ultimos 3 ciclos


library ieee;
use ieee.std_logic_1164.all;

entity Num_1s_3ciclos is
port(
	an_rst, clk: in std_logic;
	data_in : in std_logic;
	salida :buffer std_logic_vector(1 downto 0)
);
end entity Num_1s_3ciclos;
architecture rtl of Num_1s_3ciclos is
	--Aqui escribimos componentes internos
	type t_estado is (cero, uno, dos, tres, cuatro, cinco, seis, siete);
	signal estado: t_estado;
begin
proc_memoria: process(an_rst, clk)
begin

	if(an_rst='0') then estado<=cero;
	elsif (clk'event and clk='1') then
		if(data_in = '1') then
			case estado is
				when cero => estado <=uno;
				when cuatro => estado <= uno;
				when dos => estado <= cinco;
				when seis => estado <=cinco;
				when uno => estado <=tres;
				when cinco => estado <=tres;
				when tres => estado <= siete;
				when siete=> estado <= siete;

			end case;
		else
			case estado is
				when cero => estado <=cero;
				when cuatro => estado <= cero;
				when dos => estado <= cuatro;
				when seis => estado <=cuatro;
				when uno => estado <=dos;
				when cinco => estado <= dos;
				when tres => estado <= seis;
				when siete => estado <= seis;
				
			end case;
		end if;
		

	end if;
end process proc_memoria;

proc_salida: process(estado)
begin
	case estado is
		when cero => salida <="00";
		when uno => salida <="01";
		when dos => salida <="01";
		when tres => salida <="10";	
		when cuatro => salida <="01";
		when cinco => salida <="10";
		when seis => salida <="10";
		when siete => salida <="11";
	end case;
end process proc_salida;
end architecture rtl;