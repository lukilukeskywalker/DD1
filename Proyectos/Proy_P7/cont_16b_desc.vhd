--Objetivo de la practica es crear un contador descendente , con entrada asincrona de 16 bits, y reset para el reloj

library ieee;
use ieee.std_logic_1164.all;

entity cont_16b_desc is
port(
	preload: in std_logic_vector(15 downto 0);
	clk : in std_logic;
	reset: in std_logic;
	output: buffer std_logic
	);

end entity;

architecture rtl of cont_16b_desc is

