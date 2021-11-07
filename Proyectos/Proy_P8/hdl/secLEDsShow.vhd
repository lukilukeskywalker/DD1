-- Objetivo de la practica:
-- Crear un sistema que secuencialmente cada segundo vaya encendiendo un led
-- Funciones:
-- Tiene 3 secuencias:
-- 1� Secuencia desplazamiento. P_2 determina el sentido, inicialmente a izq
-- 2� Secuencia desplazamiento a DERECHAS. P_2 desplaza un led por pulso
-- 3� Secuencia desplazamiento a IZQUIERDAS. P_2 desplaza un led por pulso
-- P_2 Determina el sentido de los leds, inicialmente a izquierdas, cuando se pulsa a derechas, y viceversa

library ieee;
use ieee.std_logic_1164.all;

entity secLEDsShow is 
	port(an_rst, clk: in std_logic;
		LEDs : buffer std_logic_vector(7 downto 0):="10000000";
		segDisp: buffer std_logic_vector(6 downto 0);
		P_1, P_2: in std_logic
	);
end entity secLEDsShow;
-- Tenemos que crear 2 conformadores, un automata para los leds y un decodificador de estado a BCD con salida segDisp
architecture rtl of secLEDsShow is
	constant timer_counter: integer:=12000000;
	type mod_automata is (Desp_Per_Der, Desp_Per_Izq, Desp_Der, Desp_Izq);
	signal automata_state: mod_automata:=Desp_Per_Der;
	signal ticks: integer;
	signal tick: std_logic;
	signal MOD0: std_logic;--Salida Conformador P_1, ModoFunc
	signal SHIFT: std_logic;--Salida Conformador P_2, Pulso-shift
	signal Q_i_1 :std_logic; --Memoria Conformador 1
	signal Q_i_2 : std_logic; --Memoria Conformador 2
begin
proc_timer : process(an_rst, clk)
--proc_timer test->PASS
begin
	if(an_rst='0') then ticks<=0;
	elsif(clk'event and clk='1') then
		ticks<=ticks+1;
		if(ticks=timer_counter/2 or ticks > timer_counter/2) then
			--tick <='1';
			if tick ='1' then tick <='0';
			else tick <='1';
			end if;
			--tick <= not tick; --Para hacer pulsos de mismo tama�o->Cual es el valor contrario a undefined? undefined xD
	--El problema de querer hacer pulsos del mismo tama�o es que lo mas peque�o que puedes 
	--hacer tu pulso es el tiempo que recibes una interrupcion, en  este caso  cada clk='1'
			ticks <= 1;
		--else tick <='0';
		end if;
	end if;
end process proc_timer;
proc_estado_conformador_1 : process(an_rst, tick)
begin
	if an_rst ='0' then Q_i_1 <='0';
	elsif (tick'event and tick='1') then Q_i_1 <= P_1;
	end if;
end process proc_estado_conformador_1;
proc_salida_conformador_1 : process(Q_i_1, P_1)
begin
	if Q_i_1 ='1' then MOD0<='0';
	else MOD0<=P_1;
	end if;
end process proc_salida_conformador_1;
proc_estado_conformador_2 : process(an_rst, tick)
begin
	if an_rst ='0' then Q_i_2 <='0';
	elsif (tick'event and tick='1') then Q_i_2 <= P_2;
	end if;
end process proc_estado_conformador_2;
proc_salida_conformador_2 : process(Q_i_2, P_2)
begin
	if Q_i_2 ='1' then SHIFT<='0';
	else SHIFT<=P_2;
	end if;
end process proc_salida_conformador_2;

proc_automata : process(an_rst, tick)
begin
	if an_rst ='0' then 
		automata_state <= Desp_Per_Der;
		LEDs<="10000000";
	elsif tick'event and tick ='1' then
		case automata_state is
			when Desp_Per_Der =>
				if(MOD0 = '1') then automata_state <= Desp_Der;
				elsif(SHIFT = '1') then automata_state <= Desp_Per_Izq;
				else LEDs <= LEDs(0)&LEDs(7 downto 1);
				end if;
			when Desp_Per_Izq =>
				if(MOD0 = '1') then automata_state <= Desp_Der;
				elsif(SHIFT='1') then automata_state <= Desp_Per_Der;
				else LEDs <= LEDs(6 downto 0) & LEDs(7);
				end if;
			when Desp_Der =>
				if(MOD0 = '1') then automata_state <= Desp_Izq;
				elsif(SHIFT='1') then LEDs <= LEDs(0)&LEDs(7 downto 1);
				end if;
			when Desp_Izq => 
				if(MOD0 = '1') then automata_state <= Desp_Per_Der;
				elsif (SHIFT='1') then LEDs <= LEDs(6 downto 0) &LEDs(7);
				end if;
			end case;
	end if;
end process proc_automata; 
proc_LEDpos_TO_digBCD : process (LEDs)
begin 
	case LEDs is
		when "10000000" => segDisp <="1001111";
		when "01000000" => segDisp <="0010010";
		when "00100000" => segDisp <="0000110";
		when "00010000" => segDisp <="1001100";
		when "00001000" => segDisp <="0100100";
		when "00000100" => segDisp <="0100000";
		when "00000010" => segDisp <="0001111";
		when "00000001" => segDisp <="0000000";
		when others => 
			segDisp <="0000001";	--Un cero, nunca sucedera, pero bueno. Pues, si. Si sucede. Wtf
			
	end case;
end process proc_LEDpos_TO_digBCD;

end architecture rtl;
		
	
