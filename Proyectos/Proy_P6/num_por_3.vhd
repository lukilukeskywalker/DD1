
-- Objetivo de la practica. Crear un codigo que una vez se introduzca un numero via serie, este salga multiplicado por 3, en serie.
-- La multiplicacion se debe realizar, multiplicando el numero *2 y luego sumandole el numero, otra vez, de tal forma que: 2x+x=3x
-- El bit menos significativo entra primero, de tal forma que ya se puede realizar el acarreo.

library ieee;
use ieee.std_logic_1164.all;

entity num_por_3 is
	port(an_rst, clk: in std_logic;
		data_in	: in std_logic;
		data_out: buffer std_logic
	);
end entity num_por_3;

architecture rtl of num_por_3 is
	type t_estado is (cero, uno, dos);
	signal estado: t_estado;	--Creamos un tipo de dato, para la maquian de estados
	
begin
proc_estado : process(an_rst, clk)
begin
--Vale, esta maquina de estados tiene que guardar 2 cosas. El proceso, recordemos es
-- Una multiplicacion de 2 y una suma con el valor actual. Siempre. No te ralles
	if(an_rst = '0') then estado<=cero;
	elsif (clk'event and clk = '1') then
		--Aqui empieza la diversion.
		--data_in es el valor actual que hay que guardar para shiftearlo "hacia el futuro"
		
		case estado is
			when cero =>
				if(data_in = '1' and  data_out = '1') then estado<=uno;--En realidad creo que aqui el data_out es irrelevante. me ha estado rallando un monton...
				end if;
			when uno =>
				if(data_in = '1' and data_out = '0') then estado<=dos;--El data_out es irrelevante
				elsif(data_in = '0' and data_out = '1')then estado<=cero;--Realmente el data_out es irrelevante... gosh...
				end if;
			when dos => --Este 2, no es 11, sino 10. Es un acarreo del acarreo
				if(data_in = '0' and data_out = '0') then estado<=uno;--Por eso, si el acarreo no se rellena, va hacia atras el bit.
				end if;
		end case;
	end if;
end process proc_estado;
proc_salida : process(data_in, estado)
begin
	if(data_in = '1') then
		--if(estado=cero) then data_out<='1';
		if(estado=uno) then data_out<='0';
		else data_out<='1';--En los otros dos casos, estado cero y dos, cero + 1 es 1 y 2 mas 1, sigue siendo 21 xD... o mas correctamente 11
		end if;
	else 	
		if(estado = uno) then data_out<='1';--Liberamos el acarreo, no se lleva acarreo
		else data_out<='0';
		end if;
	end if;
end process proc_salida;

end architecture rtl;

	