

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ej3_sum_1digbcd is
	port(	A : in std_logic_vector(3 downto 0);
		B : in std_logic_vector(3 downto 0);
		Cin: in std_logic;
		Cout: buffer std_logic;
		S: buffer std_logic_vector(3 downto 0)
		);
end entity;

architecture rtl of ej3_sum_1digbcd is
	signal s_suma: std_logic_vector(4 downto 0);
	signal s_resta: std_logic_vector(3 downto 0);

begin
	Sumador: process(A, B, Cin)
	begin
		s_suma<=  ('0'&A) + ('0'&B) + (x"0"&Cin);
	end process Sumador;
	
	Cout <= '1' when s_suma > 9 else
		'0';

	Resta_10: process(s_suma)
	begin
		s_resta<=s_suma(3 downto 0) - x"A";
	end process Resta_10;

	S <= 	s_suma(3 downto 0) when Cout = '0' else
		s_resta;	
end rtl;