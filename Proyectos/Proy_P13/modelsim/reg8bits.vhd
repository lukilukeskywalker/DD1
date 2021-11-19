
library ieee;
use ieee.std_logic_1164.all;

entity reg8bits is
	port(	clk: in std_logic;
		nRst: in std_logic;
		ena: in std_logic;
		Din: in std_logic_vector(7 downto 0);
		Dout: buffer std_logic_vector(7 downto 0));
end entity;

architecture rtl of reg8bits is
begin
	process(clk, nRst)
	begin
		if nRst = '0' then
			Dout <= (others => '0');
		elsif clk'event and clk = '1' then 
			if ena = '1' then
				Dout <= Din;
			end if;
		end if;
	end process;
end rtl;