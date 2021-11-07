
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_NA_4_conf is 
end entity;

architecture test of tb_NA_4_conf is
	signal umbral: std_logic_vector(1 downto 0):="10";
	signal ent: std_logic_vector(3 downto 0);
	signal sal: std_logic;

begin 
	dut: entity Work.NA_4_conf(rtl)
		port map(umbral => umbral,
			ent => ent,
			sal => sal
			);

stimuli_umbral: process
begin
--Umbral 0;
	sal<='0';
 	case umbral is
		when "00" => umbral <= "01";
		when "01" => umbral <= "10";
		when "10" => umbral <= "11";
		when "11" => umbral <= "00";
		when others => umbral <= "00";
	end case;
	wait for 500 ns;

end process stimuli_umbral;
stimuli_entrada: process
begin
	
	sal<='0';
	case ent is
		when x"0" | x"2" | x"4" | x"6" | x"8" | x"A" | x"C" | x"E" =>
			--ent <= std_logic_vector(to_unsigned(to_integer(unsigned(ent)) +1, 4));
			--ent <= ent +x"1";
			--ent <= std_logic_vector(unsigned(ent) +1);
			ent <= ent(3 downto 1) & "1";--Anotacion. No puedes hacer con hexadecimales, porque tienen dim 4, y tu array es no modificable
		when x"1" => ent <=x"2";
		when x"3" => ent <=x"4";
		when x"5" | x"9" |x"D" => ent <= ent(3 downto 2) & "10";
		when x"7" => ent<=x"8";
		when x"B" => ent<=x"C";
		when x"F" => ent<=x"0";
		when others => ent <= "0000";
	end case;
	wait for 30 ns;
end process stimuli_entrada;


end test;
	
