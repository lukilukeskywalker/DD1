
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity banco_de_reg is
	port(nRst, clk : in std_logic;
		DIGITO : in std_logic_vector(3 downto 0);
		PESO_DIGITO: in std_logic_vector( 1 downto 0);
		WE_DIGITO: in std_logic;
		DIR_DIGITO: in std_logic_vector(1 downto 0);
		DIGITO_OUT: buffer std_logic_vector(3 downto 0);