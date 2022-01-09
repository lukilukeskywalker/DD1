
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity acumulador_ini_inst is
	generic (N:positive := 8;
		M:positive := 8);
	--constant M :natural := 8;
	port(nRst, clk: in std_logic;
		E: in std_logic_vector(N-1 downto 0);
		S: buffer std_logic_vector(M-1 downto 0);
		INI: in std_logic;
		ENA: in std_logic
		);
end entity acumulador_ini_inst;

architecture rtl of acumulador_ini_inst is
	signal sal_sumador: std_logic_vector(M-1 downto 0);
	signal sal_multiplexor: std_logic_vector(M-1 downto 0);
begin

--Proceso sumador:
sal_sumador <= E + S;

--Proceso Multiplexor:
sal_multiplexor <= E when INI = '1' and ENA = '1' else
		sal_sumador;

--Proceso Registro
proc_reg: process(nRst, clk)
begin
	if(nRst = '0') then 
		S <= (others => '0');
	elsif(clk'event and clk = '1') then
		if ENA = '1' then
			S <= sal_multiplexor;
		end if;
	end if;
end process proc_reg;
end rtl;
