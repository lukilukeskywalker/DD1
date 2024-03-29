library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_circuito_completo is 
  end entity;


architecture test of tb_circuito_completo is 

	signal clk:         std_logic; 
    	signal nRst:        std_logic; 
    	signal WE:          std_logic; 
     	signal Dir_WR:      std_logic_vector(5 downto 0);        
     	signal Din:         std_logic_vector(31 downto 0); 
     	signal Dir_RD:      std_logic_vector(5 downto 0); 
	constant T_CLK:	    time := 100 ns;
	signal FIN	: std_logic;
	
begin 

dut: entity work.circuito_completo(rtl) 
port map(
   		clk  => clk,
   		nRST => nRST,
   		WE => WE,
		Dir_WR => Dir_WR,
		Din => Din,
		Dir_RD => Dir_RD
  	);

 	

 reloj: process
  	begin
		if FIN = '1' then
			wait;
		end if;
	        clk <= '0';
		wait for T_CLK/2;
		clk <= '1';
		wait for T_CLK/2;
  	end process;

 process
  begin
        nRST <= '0';
	wait for T_CLK;
	wait until CLK'event and CLK = '1';
	nRST <= '1';
	wait for T_CLK;
	wait until CLK'event and CLK = '1';
	WE <= '1'; 
	for posicion in 0 to 15 loop
     	Dir_WR <=  posicion + "000000"; 
     	Din <= posicion + X"00000000";   
	wait for T_CLK;
	wait until CLK'event and CLK = '1';
  end loop;
	WE <= '1'; 
        for posicion2 in 0 to 15 loop 
     	Dir_RD <= posicion2 + "000000";
	wait until CLK'event and CLK = '1';
  end loop;

	FIN <= '1';
   wait;
end process;

end test;