library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divisor_2 is
port(clk:     in     std_logic;
     nRst:    in     std_logic;
     f_out_1: buffer std_logic;
     f_out_2: buffer std_logic);
end entity;

architecture rtl of divisor_2 is
  -- Se�ales
	signal mod4: std_logic_vector(1 downto 0);
	signal mod3: std_logic_vector(1 downto 0);
  
begin
proc_div_mod4: process(nRst, clk)
begin
  -- Contador modulo 4 con salida de fin de cuenta
  	if(nRst = '0') then mod4 <= "00";
	elsif(clk'event and clk = '1') then
		if(mod4="11") then mod4 <= "00";
		else mod4<=mod4+'1';
		end if;
	end if;
	--f_out_1 <= '1' when mod4="11" else
	--	   '0' ;
	if(mod4="11") then f_out_1 <= '1';
	else f_out_1<='0';
	end if;
end process proc_div_mod4;  

  -- Contador m�dulo 3 con entrada de habilitaci�n y salida
  -- de fin de cuenta (independiente de la entrada de habilitaci�n)
proc_div_mod3: process(nRst, clk)
begin
	if(nRst = '0') then mod3 <= "00";
	elsif(clk'event and clk = '1' and f_out_1 = '1') then 
		if(mod3="10") then mod3 <= "00";
		else mod3<=mod3+'1';
		end if;
	end if;
	if(mod3="10") then f_out_2 <= '1';
	else f_out_2<='0';
	end if;
end process proc_div_mod3;
   
  
            
end rtl;