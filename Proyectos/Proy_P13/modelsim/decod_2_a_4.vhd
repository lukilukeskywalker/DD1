
library ieee;
use ieee.std_logic_1164.all;

entity decod_2_a_4 is
	port(	ena: in std_logic;
		Din: in std_logic_vector(1 downto 0);
		Dout: buffer std_logic_vector(3 downto 0));
end entity;

architecture rtl of decod_2_a_4 is
begin
	process(ena, Din)
	begin
		if ena = '1' then
			case Din is
				when "00" =>
					Dout <= "0001";
				when "01" =>
					Dout <= "0010";
				when "10" =>
					Dout <= "0100";
				when "11" =>
					Dout <= "1000";
				when others =>
					Dout <= "XXXX";
			end case;
		else
			Dout <="0000";
		end if;
	end process;
end rtl;
