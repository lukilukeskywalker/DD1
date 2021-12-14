--Objetivo de la practica. Crear un codigo que una vez introducido un numero via serie, se le compruebe si el num de 1 es mayor que el de 0´s.

library ieee;
use ieee.std_logic_1164.all;

entity comp_entrada is
	port(
		entrada: in std_logic_vector(3 downto 0);
		salida: buffer std_logic
	);
end entity comp_entrada;

architecture rtl of comp_entrada is
begin
	process(entrada)
	begin
	case entrada is
		when "0111" => salida <='1';
		when "1011" => salida <='1';
		when "1101" => salida <='1';
		when "1110" => salida <='1';
		when "1111" => salida <='1';
		when others => salida <='0';
	end case;
	end process;
end rtl;
