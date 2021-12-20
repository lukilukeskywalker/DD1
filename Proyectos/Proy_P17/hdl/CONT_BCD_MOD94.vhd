
--Autor Lukas Gdanietz
--Objetivo: Crear un contador BCD de dos digitos que tenga un comparador que resetee el contador a 0 una vez llega a 94

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cont_bcd_mod94 is
	port(	clk: in std_logic;
		nRst: in std_logic;
		ENA : in std_logic;
		U: buffer std_logic_vector(3 downto 0) := x"0";
		D: buffer std_logic_vector(3 downto 0));
end entity;

architecture rtl of cont_bcd_mod94 is
	signal Cout : std_logic;
	signal SINC_RST: std_logic := '0';
	
begin

cont_bcd_cin: process(nRst, clk)
begin

	if(nRst = '0') then 
		U <=(others => '0');
	elsif(clk'event and clk='1') then 
		if(SINC_RST = '1') then 
			U<=(others =>'0');
		elsif(Cout = '1') then 
			U<=(others =>'0');
		elsif(ENA = '1') then 
			U <= U + 1;
		end if;
	end if;

end process cont_bcd_cin;
Cout <= '1' when ENA = '1' and U = 9 else
	'0';


--cont_bcd_cin: process(clk, nRst)
--	begin
--	if nRst = '0' then 
--		U <= (others =>'0');
--	elsif(clk'event and clk = '1') then
--		if SINC_RST = '0' then
--			U <= (others =>'0');
--		elsif ENA='1' then 
--			if Cout = '1' then 
--				U <= (others =>'0');
--			else
--				U <= U + 1;
--			end if;
--		end if;
--	end if;
--end process cont_bcd_cin;
--Cout <= '1' when U = 9 and ENA = '1' else
--	'0';

cont_bcd_ena: process(clk, nRst)
	begin
	if nRst = '0' then 
		D <= (others =>'0');
	elsif(clk'event and clk = '1') then 
		if (SINC_RST = '1') then 
			D <= (others =>'0');
		elsif Cout='1' then 
			D <= D + 1;
		end if;
	end if;
end process cont_bcd_ena;

--Comparador MOD 94
SINC_RST <= '1' when  (D = 9 and U = 3 and ENA = '1')else 
	'0';
end rtl;	
