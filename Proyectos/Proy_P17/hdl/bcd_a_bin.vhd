
--Autor: ETSIST
--Funcion: Convierte bcd a binario.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bcd_a_bin is
	port(unidades: in std_logic_vector(3 downto 0);
		decenas: in std_logic_vector(3 downto 0);
		centenas: in std_logic_vector(3 downto 0);
		millares: in std_logic_vector(3 downto 0);
		binario: buffer std_logic_vector(13 downto 0)
		);
end entity;

architecture rtl of bcd_a_bin is
	signal factor_1: std_logic_vector(6 downto 0);
	signal factor_2: std_logic_vector(9 downto 0);

begin
	factor_1 <=(millares&"000") +(millares&'0') +centenas;
	factor_2 <=(factor_1&"000") +(factor_1&'0') + decenas;
	binario <= ('0'&factor_2&"000") +(factor_2&'0')+unidades;
end rtl;