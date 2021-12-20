--Autor: Lukas Gdanietz de Diego
--Objetivo: Crear un contador de modulo ascendente BCD de modulo 816

library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cont_bcd_mod816 is
	port(	clk, nRst: in std_logic;
		ENA: in std_logic;
		U: buffer std_logic_vector(3 downto 0);
		D: buffer std_logic_vector(3 downto 0);
		C: buffer std_logic_vector(3 downto 0)
		);
end entity;

architecture rtl of cont_bcd_mod816 is
	signal U_out : std_logic := '0';
	signal D_out : std_logic := '0';
	signal SINC_RST : std_logic := '0';

begin
	cont_bcd_U: process(nRst, clk)
	begin
		if(nRst = '0') then 
			U <=(others =>'0');
		elsif(clk'event and clk='1') then 
			if(SINC_RST = '1') then 
				U<=(others => '0');
			elsif(U_out = '1') then 
				U<=(others => '0');
			elsif(ENA ='1') then
				U<=U + 1;
			--elsif(ENA = '1') then
			--	if(U_out = '1') then 
			--		U<=(others =>'0');
			--	else
			--		U<=U+1;
			--	end if;
			end if;
		end if;
	end process cont_bcd_U;
	U_out <= '1' when U = 9 and ENA = '1' else
				'0';

	cont_bcd_D: process(nRst, clk)
	begin
		if(nRst = '0') then 
			D <=(others =>'0');
		elsif(clk'event and clk='1') then
			if(SINC_RST = '1') then 
				D<=(others =>'0');
			elsif(D_out = '1') then 
				D <= (others => '0');
			elsif(U_out = '1') then 
				D <= D + 1;
			end if;
		end if;
	end process cont_bcd_D;
	D_out <= '1' when D = 9 and U_out = '1' else
				'0';

	cont_bcd_C: process(nRst, clk)
	begin
		if(nRst = '0') then
			C <=(others => '0');
		elsif(clk'event and clk='1') then 
			if(SINC_RST = '1') then 
				C<=(others => '0');
			elsif(D_out = '1') then --D_out solo puede estar activo cuando U_out esta activo
				C<= C + 1;
			end if;
		end if;
	end process cont_bcd_C;

	--Combinacional de 816;
	SINC_RST <= '1' when C=8 and D=1 and U=6 and ENA = '1'else
				'0';
end rtl;	