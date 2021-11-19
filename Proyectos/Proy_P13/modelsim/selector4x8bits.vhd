
library ieee;
use ieee.std_logic_1164.all;

entity selector4x8bits is
	port(	Canal_0: in std_logic_vector(7 downto 0);
		Canal_1: in std_logic_vector(7 downto 0);
		Canal_2: in std_logic_vector(7 downto 0);
		Canal_3: in std_logic_vector(7 downto 0);
		Sel: in std_logic_vector(1 downto 0);
		Dout: buffer std_logic_vector( 7 downto 0));
end entity;

architecture rtl of selector4x8bits is
begin
	Dout <= Canal_0 when Sel = "00" else
		Canal_1 when Sel = "01" else
		Canal_2 when Sel = "10" else
		Canal_3;
end rtl; 