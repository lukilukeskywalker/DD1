
library ieee;
use ieee.std_logic_1164.all;

entity NA_32_conf is
	port(an_rst, clk: in std_logic;
		ENT: in std_logic_vector(31 downto 0);
		LOAD: in std_logic;
		nENA: in std_logic;
		FIN: buffer std_logic;
		SAL: buffer std_logic
		);
end entity NA_32_conf;

architecture rtl of NA_32_conf is
	constant timer_counter: integer:=1; --12000000;
	signal ticks: integer;
	signal tick: std_logic;
	signal ent_reg: std_logic_vector(31 downto 0);
	
begin
proc_timer: process(an_rst, clk)
begin
	if(an_rst='0') then ticks<=0;
	elsif(clk'event and clk='1') then 
		ticks<=ticks+1;
		if(ticks=timer_counter/2 or ticks > timer_counter/2) then
			if tick='1' then tick<='0';
			else tick<='1';
			end if;
			ticks<=1;
		end if;
	end if;
end process proc_timer;

--Proceso de Registro de desplazamiento
proc_reg_desp: process(an_rst, tick)
begin
	if(an_rst='0') then ent_reg<=x"00000000";
	elsif(tick'event and tick='1')then
		if(LOAD ='1') then ent_reg <= ENT;
		elsif (nENA ='0') then ent_reg <= ent_reg(30 downto 0) & "0";
		end if;
	end if;
end process proc_reg_desp;

end architecture rtl;
		