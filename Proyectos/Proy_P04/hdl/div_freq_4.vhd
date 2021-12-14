--Modelo de un divisor de frecuencia por 4

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--Entidad: unidad primaria VHDL que modela la interfaz
entity div_freq_4 is
port(
	clk: in std_logic;
	nRST: in std_logic;
	freq_div_4: buffer std_logic);
end entity;

architecture rtl of div_freq_4 is
	signal Q_i: std_logic_vector(1 downto 0);
begin
	process(clk, nRST)	--Proceso de entrada de reloj, suma al contador Q_i
	begin
		if nRST='0' then Q_i <="00";
		elsif clk'event and clk = '1' then Q_i <= Q_i +1;
		end if;
	end process;
	process(Q_i)	--Proceso Q_i, Contador de 0 a 3
	begin
		if Q_i = 3 then freq_div_4 <= '1';
		else freq_div_4 <= '0';
		end if;
	end process;
end rtl;

