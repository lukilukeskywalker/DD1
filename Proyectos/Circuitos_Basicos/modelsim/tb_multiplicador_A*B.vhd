
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity tb_multiplicador_AB is
end entity;

architecture test of tb_multiplicador_AB is

	signal A: std_logic_vector(3 downto 0):=(others=>'0');
	signal B: std_logic_vector(3 downto 0):=(others=>'0');

	signal R: std_logic_vector(7 downto 0);

begin 
	dut: entity Work.multiplicador_AB(rtl)
		port map(A=>A,
				B=>B,
				R=>R
				);
		testbench_proc: process
		begin
			num_A_loop: for A_t in -8 to 7 loop
				num_B_loop: for B_t in -8 to 7 loop
				A<=x"0"+A_t;
				B<=x"0"+B_t;
				wait for 20 ns;
				end loop num_B_loop;
			end loop num_A_loop;
		end process testbench_proc;
end test;
