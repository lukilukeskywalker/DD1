
library ieee;
use ieee.std_logic_unsigned.all;

entity circuito_completo is
	port(clk, nRst: in std_logic;
 	     WE: in std_logic;
 	     Dir_RD: in std_logic_vector(5 downto 0);
 	     Dir_WR: in std_logic_vector(5 downto 0);
 	     Din:  in std_logic_vector(31 downto 0);
 	     Dout: buffer std_logic_vector(31 downto 0));
end entity;


architecture estructural of circuito_completo is
	signal ENA : std_logic_vector(3 downto 0);
	signal Dout_B0 : std_logic_vector(31 downto 0);
	signal Dout_B1 : std_logic_vector(31 downto 0);
	signal Dout_B2 : std_logic_vector(31 downto 0);
	signal Dout_B3 : std_logic_vector(31 downto 0);

	begin

	U_decod: entity Work.decodificador(rtl)
		port map( ENA => ENA,
			  WE => WE,
			  Dir_WR => Dir_WR(5 downto 4));

	U_selector: entity Work.selector4x32bits(rtl)
		port map( Dout_B0 => Dout_B0,
			  Dout_B1 => Dout_B1,
			  Dout_B2 => Dout_B2,
			  Dout_B3 => Dout_B3,
			  Dout 	  => Dout,
		 	  Dir_RD => Dir_RD(5 downto 4));
	

	U_banco0: entity Work.banco_16reg_32bits(rtl)
		port map( clk => clk,
			  nRst => nRst,
			  WE => ENA(0),
			  Dout => Dout_B0,
			  Din => Din,
		 	  Dir_RD => Dir_RD(3 downto 0),
			  Dir_WR => Dir_WR(3 downto 0));

	U_banco1: entity Work.banco_16reg_32bits(rtl)
		port map( clk => clk,
			  nRst => nRst,
			  WE => ENA(1),
			  Dout => Dout_B1,
			  Din => Din,
		 	  Dir_RD => Dir_RD(3 downto 0),
			  Dir_WR => Dir_WR(3 downto 0));

	U_banco2: entity Work.banco_16reg_32bits(rtl)
		port map( clk => clk,
			  nRst => nRst,
			  WE => ENA(2),
			  Dout => Dout_B2,
			  Din => Din,
		 	  Dir_RD => Dir_RD(3 downto 0),
			  Dir_WR => Dir_WR(3 downto 0));

	U_banco3: entity Work.banco_16reg_32bits(rtl)
		port map( clk => clk,
			  nRst => nRst,
			  WE => ENA(3),
			  Dout => Dout_B3,
			  Din => Din,
		 	  Dir_RD => Dir_RD(3 downto 0),
			  Dir_WR => Dir_WR(3 downto 0));

end estructural;
			  

	