--Autor: Lukas
--Generador de numeros aleatorios de 8 bits en BCD con rango 0 a 99

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gen_num_random is
	port(clk: in std_logic;
		nRst : in std_logic;
		gen: in std_logic;
		pre: in std_logic;
		numero: buffer std_logic_vector(7 downto 0)
	);
end gen_num_random;

architecture rtl of gen_num_random is
	signal c_u: std_logic;
	signal c_d: std_logic;
	signal u: std_logic_vector(3 downto 0);
	signal d: std_logic_vector(3 downto 0);
	signal gen_reg: std_logic_vector(1 downto 0);
	signal pre_reg: std_logic_vector(1 downto 0);
	signal genera: std_logic;
	signal prepara: std_logic;
	signal cuenta: std_logic;

	type t_estado is (inicio, preparado);
	signal estado: t_estado;

begin
--conformador pulsos
conformador_pulsos: process(nRst, clk)
begin
	if nRst='0' then
		gen_reg <=(others=>'0');
		pre_reg <=(others=>'0');
	elsif clk'event and clk = '1' then 
		gen_reg(1) <= gen;
		pre_reg(1) <= pre;
		gen_reg(0) <= gen_reg(1);
		pre_reg(0) <= pre_reg(1);
	end if;
end process conformador_pulsos;

genera <= gen_reg(1) and (not gen_reg(0));
prepara <= pre_reg(1) and (not pre_reg(0));

--genera y prepara son los pulsos conformados a partir de gen y pre, con duracion 1 periodo de reloj.

--Contador unidades

cont_unidades: process(nRst, clk)
begin
	if nRst = '0' then 
		u<= (others=>'0');
	elsif clk'event and clk = '1' then 
		if(c_u = '1' and cuenta = '1') or prepara = '1' then 
			u<=(others => '0');
		elsif cuenta = '1' then 
			u <= u + 1;
		end if;
	end if;
end process cont_unidades;
c_u <= '1' when u = 9 else
	'0';

cont_decenas: process(nRst, clk)
begin
	if nRst = '0' then 
		d<=(others =>'0');
	elsif clk'event and clk = '1' then 
		if(c_d = '1' and cuenta = '1') or prepara = '1' then 
			d <=(others => '0');
		elsif c_u = '1' and cuenta = '1' then 
			d <= d + 1;
		end if;
	end if;
end process cont_decenas;

c_d <= '1' when d=9 and c_u = '1';

--Maquina de estados

state_machine: process(nRst, clk)
begin
	if nRst = '0' then 
		estado <= inicio;
	elsif clk'event and clk = '1' then 
		case estado is
			when inicio => 
				if prepara = '1' then 
					estado <= preparado;
				end if;
			when preparado =>
				if genera = '1' then 
					estado <= inicio;
				end if;
		end case;
	end if;
end process;

cuenta <= '1' when estado = preparado else '0';

--proceso de salida
output_proc: process(nRst, clk)
begin
	if nRst = '0' then 
		numero <= (others=>'0');
	elsif clk'event and clk = '1' then 
		if estado = preparado and genera = '1' then 
			numero <= d&u;
		end if;
	end if;
end process output_proc;
end architecture rtl; 

