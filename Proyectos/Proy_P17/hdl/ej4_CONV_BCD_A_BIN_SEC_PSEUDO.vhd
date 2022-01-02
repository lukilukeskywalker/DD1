
--Arquitectura estructural de un convertidor BCD a binario
--Conformado por un banco de registros, donde se guardan hasta 4 digitos en BCD, un Acumulador que suma los 4 digitos 
--y por ultimo una controladora llamada CONTROL que es una maquina de estados que realiza los pasos para convertir BCD a Binario

--Autor Lukas Gdanietz de Diego

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CONV_BCD_A_BIN_SEC_PSEUDO is
	port(nRst, clk: in std_logic;
		DIGITO: in std_logic_vector(3 downto 0);
		PESO_DIGITO: in std_logic_vector(1 downto 0);
		WE_DIGITO: in std_logic;
		START : in std_logic;
		RESULTADO: buffer std_logic_vector(13 downto 0);
		FIN_OP: buffer std_logic
		);

end entity;

architecture estructural of CONV_BCD_A_BIN_SEC_PSEUDO is
	signal DIR_DIGITO: std_logic_vector(1 downto 0);
	signal RST_ACUM: std_logic;
	signal ENA_ACUM: std_logic;
	signal REG_OUT: std_logic_vector(3 downto 0);

	begin

	banco_de_reg: entity Work.banco_de_reg(rtl)
		port map(DIGITO => DIGITO,
			PESO_DIGITO => PESO_DIGITO,
			WE_DIGITO => WE_DIGITO,
			DIR_DIGITO => DIR_DIGITO,
			DIGITO_OUT => REG_OUT,--REG_OUT => DIGITO_OUT,
			clk => clk,
			nRst => nRst);

	acum_suma_prod: entity Work.acum_suma_prod(rtl)
		port map(clk=>clk,
			nRst=>nRst,
			acum_in => REG_OUT,
			rst_acum => RST_ACUM ,
			ena_acum => ENA_ACUM,
			resultado =>RESULTADO);

	control: entity Work.control(rtl)
		port map(clk => clk,
			nRst => nRst,
			START =>start,
			RST_ACUM => rst_acum,
			ENA_ACUM => ena_acum,
			DIR_DIGITO =>dir_digito,
			FIN_OP => fin_op);

end estructural;			
	
	

		
	