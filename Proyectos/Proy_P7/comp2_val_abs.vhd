--Objetivo, de una entrada de 4 bits, en complemento a 2
--Sacar el valor absoluto. easy.

library ieee;
use ieee.std_logic_1164.all;

entity comp2_val_abs is
port(
	entrada: in std_logic_vector(3 downto 0);
	salida: buffer std_logic_vector(3 downto 0)
);
end entity;

architecture rtl of comp2_val_abs is
begin
	process(entrada)
	begin
	case entrada is
		when "1001" => salida <= "0111";
		when "1010" => salida <= "0110";
		when "1011" => salida <= "0101";
		when "1100" => salida <= "0100";
		when "1101" => salida <= "0011";
		when "1110" => salida <= "0010";
		when "1111" => salida <= "0001";
		when others => salida <= entrada;
	end case;
	end process;
end rtl;
