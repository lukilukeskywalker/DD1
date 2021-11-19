
library ieee;
use ieee.std_logic_1164.all;

entity selector4x32bits is
 	port( 	Dir_RD: in std_logic_vector(1 downto 0);
		Dout_B0: in std_logic_vector(31 downto 0);
		Dout_B1: in std_logic_vector(31 downto 0);
		Dout_B2: in std_logic_vector(31 downto 0);
		Dout_B3: in std_logic_vector(31 downto 0);
		Dout: buffer std_logic_vector(31 downto 0)
		);
end entity;

architecture rtl of selector4x32bits is
begin
	Dout <= Dout_B0 when Dir_RD = "00" else
		Dout_B1 when Dir_RD = "01" else
		Dout_B2 when Dir_RD = "10" else
		Dout_B3;
end rtl;
		