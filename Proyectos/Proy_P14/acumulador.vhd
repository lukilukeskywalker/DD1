
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity acumulador is
	port(clk: in std_logic;
		nRst: in std_logic;
		ena: in std_logic;
		rst: in std_logic;
		Din: in std_logic_vector(7 downto 0);
		Dout: buffer std_logic_vector(11 downto 0);
		OV: buffer std_logic);
end entity;

architecture rtl of acumulador is
	signal sum_aux: std_logic_vector(12 downto 0);
	signal sum: std_logic_vector(11 downto 0);

begin
	sum_aux <=('0'&Dout) + ("00000"&Din);

	sum <= (others => '1') when sum_aux(12) = '1' else
		sum_aux(11 downto 0);

	OV <= sum_aux(12);

process(clk, nRst)
begin
	if nRst = '0' then 
		Dout <= (others => '0');
	elsif clk'event and clk = '1' then 
		if rst = '1' then 
			Dout <= (others => '0');
		elsif ena = '1' then 
			Dout <= sum;
		end if;
	end if;
end process;
end rtl;