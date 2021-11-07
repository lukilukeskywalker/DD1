
-- Objetivo: Crear el sistema de intermitentes de un thunderbird

library ieee;
use ieee.std_logic_1164.all;

entity int_thunderbird is
	port(an_rst, clk: in std_logic;
		L, R : in std_logic;
		RA, RB, RC, LA, LB, LC : buffer std_logic
	);

end entity int_thunderbird;
architecture rtl of int_thunderbird is
	type moore_state is (inicio, izq_uno, izq_dos, izq_tres, der_uno, der_dos, der_tres, emergencia);
	signal estado : moore_state;
	signal ticks : integer;
	signal tick : std_logic;
begin
proc_timer : process(an_rst, clk)
begin
	if(an_rst='0') then ticks<=0;
	elsif(clk'event and clk ='1') then
		ticks<=ticks+1;
		if(ticks=3600000) then 
			tick <='1';
			ticks <= 0;
		else tick <='0';
		end if;
	end if;

end process proc_timer;

proc_estado : process(an_rst, tick)
begin
	if(an_rst ='0') then estado<=inicio;
	elsif(tick'event and tick = '1') then
		if(L='1' and R='1') then 
			if estado = inicio then estado <=emergencia;
			else estado <= inicio;
			end if;
		elsif(L='0' and R='0') then estado <=inicio;
		else
			case estado is 
				when inicio =>
					if(L='1' and R='0') then estado <= izq_uno;
					elsif(L='0' and R='1') then estado <= der_uno;
					end if;
				when izq_uno =>
					if(L='1' and R='0') then estado <= izq_dos;
					elsif(L='0' and R='1') then estado <= inicio;
					end if;
				when izq_dos =>
					if(L='1' and R='0') then estado <= izq_tres;
					elsif(L='0' and R='1') then estado <= izq_uno;	--�O es inicio? No queda muy claro en el pdf
					end if;
				when izq_tres =>
					if(L='1' and R='0') then estado <= inicio;
					elsif(L='0' and R='1') then estado <= izq_dos;
					end if;
				when der_uno =>
					if(L='1' and R='0') then estado <= inicio;
					elsif(L='0' and R='1') then estado <= der_dos;
					end if;
				when der_dos =>
					if(L='1' and R='0') then estado <= der_uno;
					elsif(L='0' and R='1') then estado <= der_tres;	--�O es inicio? No queda muy claro en el pdf
					end if;
				when der_tres =>
					if(L='1' and R='0') then estado <= der_dos;
					elsif(L='0' and R='1') then estado <= inicio;
					end if;
				when emergencia =>
					if((L='1' and R='0') or (R='1' and L='0')) then estado <= inicio;
					end if;
			end case;
		end if;
	end if;
end process proc_estado;
proc_salida : process(estado)
begin
	case estado is
		when inicio => RA<='0';RB<='0' ;RC<='0';LA<='0';LB<='0';LC <='0';
		when izq_uno => LA<='1'; LB<='0';
		when izq_dos => LB<='1';LC<='0';
		when izq_tres => LC<='1';
		when der_uno => RA<='1';RB<='0';	--Aqui pasa algo, el led del medio en der_tres se apaga
		when der_dos => RB<='1';RC<='0';
		when der_tres => RC<='1'; 
		when emergencia => RA<='1';RB<='1';RC<='1';LA<='1';LB<='1';LC <='1';
		when others => RA<='X';RB<='X';RC<='X';LA<='X';LB<='X';LC <='X';
	end case;
end process proc_salida;

end architecture rtl;

