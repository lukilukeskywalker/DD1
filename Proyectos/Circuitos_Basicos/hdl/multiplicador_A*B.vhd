
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multiplicador_AB is
	port(A: in std_logic_vector(3 downto 0);
		B: in  std_logic_vector(3 downto 0);
		R: buffer std_logic_vector(7 downto 0)
		);
end entity;

architecture rtl of multiplicador_AB is
	signal factor_1: std_logic_vector(7 downto 0);
	signal factor_2: std_logic_vector(5 downto 0);
	signal factor_3: std_logic_vector(4 downto 0);
	signal factor_4: std_logic_vector(3 downto 0);

	signal A_aux: std_logic_vector(3 downto 0);
	signal B_aux: std_logic_vector(3 downto 0);
	signal R_aux: std_logic_vector(7 downto 0);
begin
	A_aux <= A when A(3)='0' else not(A) + 1;
	B_aux <= B when B(3)='0' else not(B) + 1;

	factor_1 <= "0"&A_aux(3 downto 0)&"000" when B_aux(3)='1' else(others=>'0');
	factor_2 <= A_aux(3 downto 0) &"00" when B_aux(2) = '1' else (others => '0');
	factor_3 <= A_aux(3 downto 0) & "0" when B_aux(1) = '1' else (others=>'0');
	factor_4 <= A_aux(3 downto 0)  when B_aux(0) = '1' else (others=>'0');
	
	R_aux <= factor_1 + factor_2 + factor_3 + factor_4;

	R <= R_aux when A(3)= B(3) else (not(R_aux)+1);
end rtl;