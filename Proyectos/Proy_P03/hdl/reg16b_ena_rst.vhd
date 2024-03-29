--Creacion de un sistema secuencial shiftRegister Lineal, D_In --> D_Out Size:16 bits
--Entrada de reset, clk y enable
--Autor Lukas

library ieee;
use ieee.std_logic_1164.all;


--Definicion de entradas y salidas del shift register.
entity reg16b_ena_rst is
port(
	clk: in std_logic;
	nRst: in std_logic;
	sRst: in std_logic;
	ena: in std_logic;
	Din: in std_logic_vector(15 downto 0);
	Dout: buffer std_logic_vector(15 downto 0)
	);
end entity;

--Descripcion del sistema.

architecture rtl of reg16b_ena_rst is
begin

--Modelado del sistema
	process(clk, nRST)
	begin
		if nRST='0' then 
			Dout <=(others=>'0');
		elsif clk'event and clk='1' then
			if sRst='1' then 
				Dout<=(others=>'0');
			elsif ena='1' then 
				Dout<=Din;
			end if;
		end if;
	end process;
end rtl;
