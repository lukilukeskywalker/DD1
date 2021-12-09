library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divisor_3 is
port(clk:       in     std_logic;
     nRst:      in     std_logic;
     f_div_250: buffer std_logic;
     f_div_125: buffer std_logic;
     f_div_50:  buffer std_logic);
end entity;

architecture rtl of divisor_3 is
  signal cnt_div_250: std_logic_vector(5 downto 0);
  signal ff_div_125 : std_logic;
  signal cnt_div_50 : std_logic_vector(2 downto 0);
begin  
  -- Complete la descripción del circuito
  --Se pide un circuito que sea capaz de realizar 3 señales de 250khz, 125khz y 50khz
  --La duracion del pulso de salida debe ser de un ciclo de reloj y nada mas, para que puedan ser encadenados entre si
proc_div_mod48: process(nRst, clk)
begin
	--contador mod 48 con salida fin de cuenta
	if(nRst= '0') then cnt_div_250<="000000";
	elsif(clk'event and clk = '1') then
		if(cnt_div_250 = "110000") then cnt_div_250 <= "000000";
		else cnt_div_250 <= cnt_div_250+'1';
		end if;
		if(cnt_div_250 = "110000") then f_div_250<='1';
		else f_div_250<='0';
		end if;
	end if;
	
end process proc_div_mod48; 

proc_div_mod2: process(nRst, clk)
begin
	--contador mod 2 con salida fin de cuenta
	if(nRst='0') then ff_div_125<='0';
	elsif(clk'event and clk = '1' and f_div_250 = '1') then
		if(ff_div_125 = '0') then 
			ff_div_125 <='1';
			--f_div_125 <='1'; --Como esta colocado ahora hace que el primer pulso salga en el primer ciclo... Si es un contador estaria fallando...
		else ff_div_125 <='0';
			f_div_125 <='1'; 
		end if;
	elsif(clk'event and clk = '1') then f_div_125 <='0';
	end if;
end process proc_div_mod2;

proc_div_mod5: process(nRst, clk)
begin
	--contador mod 5 con salida fin de cuenta
	if(nRst='0') then cnt_div_50<="000";
	elsif(clk'event and clk = '1' and f_div_250 = '1') then
		if(cnt_div_50 = "100") then 
			cnt_div_50 <="000";
			f_div_50 <='1';
		else cnt_div_50 <=cnt_div_50+'1';
		end if;
	elsif(clk'event and clk = '1') then f_div_50 <='0';
	end if;
end process proc_div_mod5;


end rtl;