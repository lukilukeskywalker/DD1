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
  -- Complete la descripci�n del circuito
  --Se pide un circuito que sea capaz de realizar 3 se�ales de 250khz, 125khz y 50khz
  --La duracion del pulso de salida debe ser de un ciclo de reloj y nada mas, para que puedan ser encadenados entre si
proc_div_mod48: process(nRst, clk)
begin
	--contador mod 48 con salida fin de cuenta
	if(nRst= '0') then cnt_div_250<= (others => '0');
	elsif(clk'event and clk = '1') then
		if(cnt_div_250 = 47) then cnt_div_250 <= (others => '0');
		else cnt_div_250 <= cnt_div_250+1;
		end if;
		
	end if;
	
end process proc_div_mod48; 
f_div_250 <= '1' when  cnt_div_250 = 47 else '0';


proc_div_mod2: process(nRst, clk)
begin
	--contador mod 2 con salida fin de cuenta
	if(nRst='0') then ff_div_125<='0';
	elsif(clk'event and clk = '1') then
		if(f_div_250 = '1') then ff_div_125 <= not ff_div_125;
		end if;
	end if;
end process proc_div_mod2;
f_div_125 <= ff_div_125 and f_div_250;


proc_div_mod5: process(nRst, clk)
begin
	--contador mod 5 con salida fin de cuenta
	if(nRst='0') then cnt_div_50<= (others => '0');
	elsif(clk'event and clk = '1' and f_div_250 = '1') then
		if(f_div_250 = '1') then
			if(cnt_div_50 = 4) then 
				cnt_div_50 <= (others => '0');
			else
				cnt_div_50 <= cnt_div_50 +1;
			end if;
		end if;
	end if;
end process proc_div_mod5;
f_div_50 <= 	'1' when (cnt_div_50 = 4 and f_div_250 = '1') else
		'0';


end rtl;