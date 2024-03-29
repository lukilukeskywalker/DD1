
library ieee;
use ieee.std_logic_1164.all;

entity decodificador is 
port(
	Dir_WR : in std_logic_vector(1 downto 0);
	WE     : in std_logic;
	ENA    : buffer std_logic_vector(3 downto 0)
);

end entity;


architecture rtl of decodificador  is  
begin
process(Dir_WR,WE)
begin
	if WE = '1' then 
	    case Dir_WR is
				

		when "00" =>
			ENA <= "0001";
		when "01" =>
			ENA <= "0010";
		when "10" =>
			ENA <= "0100";
		when "11" =>
			ENA <= "1000";
		when others =>
			ENA <= "XXXX";
			end case;
		else
			ENA <="0000";
		end if;
	end process;
end rtl;
 

	