--Autor: Lukas
--Descripcion: banco de reg es un banco de 4 registros de 4 bits. 
	--DIGITO es el dato de entrada, 
	--PESO_DIGITO indica en que registro debe ser guardado DIGITO
	--WE_DIGITO es la señal que indica que el dato debe ser escrito
	--DIR_DIGITO es la direccion que desea ser leida
	--DIGITO_OUT es el la salida del banco de registros
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity banco_de_reg is
	port(nRst, clk : in std_logic;
		DIGITO : in std_logic_vector(3 downto 0);
		PESO_DIGITO: in std_logic_vector( 1 downto 0);
		WE_DIGITO: in std_logic;
		DIR_DIGITO: in std_logic_vector(1 downto 0);
		DIGITO_OUT: buffer std_logic_vector(3 downto 0)
		);

end entity;

architecture rtl of banco_de_reg is
	signal Reg0 : std_logic_vector(3 downto 0);
	signal Reg1 : std_logic_vector(3 downto 0);
	signal Reg2 : std_logic_vector(3 downto 0);
	signal Reg3 : std_logic_vector(3 downto 0);

begin
	escritura_reg : process(clk, nRst)
	begin
		if nRst = '0' then 
			Reg0 <= (others => '0');
			Reg1 <= (others => '0');
			Reg2 <= (others => '0');
			Reg3 <= (others => '0');
		elsif clk'event and clk = '1' then
			if(WE_DIGITO = '1') then 
				case PESO_DIGITO is
					when "00" + 0 => 
						Reg0 <= DIGITO;
					when "00" + 1 => 
						Reg1 <= DIGITO;
					when "00" + 2 => 
						Reg2 <= DIGITO;
					when "00" + 3 => 
						Reg3 <= DIGITO;
					when others =>
				end case;
			end if;
		end if;
	end process escritura_reg;

--Proceso para la salida de dato de registro
	DIGITO_OUT <= 	Reg0 when DIR_DIGITO = "00" + 0 else
			Reg1 when DIR_DIGITO = "01" else
			Reg2 when DIR_DIGITO = "10" else
			Reg3;
	
end rtl;