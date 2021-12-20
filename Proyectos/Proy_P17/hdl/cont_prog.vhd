--Autor Lukas Gdanietz 
--Objetivo: Crear un contador programable
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cont_prog is
	port(clk, nRst : in std_logic;
		modulo : in std_logic_vector(9 downto 0);
		ENA: in std_logic;
		FDC : buffer std_logic :='0';
		Q : buffer std_logic_vector(9 downto 0) :=(others=>'0')
		);
end entity;

architecture rtl of cont_prog is
	

begin

	contador: process(nRst, clk)
	begin
		if(nRst = '0') then 
			Q <=(others => '0');
		elsif(clk'event and clk ='1') then 
			if FDC = '1' then 
				Q <= (0=>'1', 
					others=>'0');
			elsif ENA = '1' then 
				Q <= Q + 1;
			end if;
		end if;
	end process contador;

	--Comparador. Sentencia concurrente comparadora.
	FDC <= '1' when modulo <= Q else
		'0';
end rtl;
		
