--Autor Lukas Gdanietz
--Objetivo Test Bench de ej3_sum_1digBCD
--Funciones:
	--Que la salida expresa correctamente, en codigo BCD el resultado de sumar 2 digitos BCD de entrada y acarreo.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_ej3_sum_1digBCD is
end entity;

architecture test of tb_ej3_sum_1digBCD is
	signal A, B, S: std_logic_vector(3 downto 0);
	signal Cin, Cout: std_logic;
	--signal clk, nRst: std_logic;
	--signal fin: boolean := false;
	--signal A_carry, B_carry: std_logic;

	constant T_CLK: time := 100 ns;
	begin
		dut: entity Work.ej3_sum_1digBCD(rtl)
			port map(A=>A,
				B=>B,
				S=>S,
				Cin=>Cin,
				Cout=>Cout
				);
	comb_sim: process
	begin
		A <=(others=>'0');
		B <=(others=>'0');
		Cin <= '0';
		for z in 0 to 1 loop
			for i in 0 to 9 loop
				for j in 0 to 9 loop
					wait for T_CLK;
					--A<=A+1;
					A<="0000"+j;
				end loop;
				--A<=(others=>'0');
				--B<=B+1;
				B<="0000"+i;	
			end loop;
			Cin<=not Cin;
		end loop;
		wait;
	end process comb_sim;



end test;
	
