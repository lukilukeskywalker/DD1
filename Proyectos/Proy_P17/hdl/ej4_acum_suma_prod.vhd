
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity acum_suma_prod is
	port(clk: in std_logic;
		nRst: in std_logic;
		rst_acum: in std_logic;
		ena_acum: in std_logic;
		acum_in: in std_logic;
		resultado: buffer std_logic_vector(13 downto 0)
	);
end entity;

architecture rtl of acum_suma_prod is
	signal acum_out: std_logic_vector(9 downto 0);

begin

resultado <= acum_in +('0'&acum_out&"000") +(acum_out&'0') when rst_acum = '0'
	else "0000000000"&acum_in;

process(clk, nRst)
begin
	if nRst = '0' then 
		acum_out <= (others => '0');
	elsif clk'event and clk = '1' then 
		if ena_acum = '1' then 
			acum_out <= resultado(9 downto 0);
		end if;
	end if;
end process;
end rtl;