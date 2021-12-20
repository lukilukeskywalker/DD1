
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity control is
	port(clk: in std_logic;
		nRst: in std_logic;
		start: in std_logic;
		rst_acum: buffer std_logic;
		ena_acum: buffer std_logic;
		dir_digito: buffer std_logic_vector(1 downto 0);
		fin_op: buffer std_logic
	);
end entity;

architecture rtl of control is
	type t_estado is (ini, uno, dos, fin_operacion);
	signal estado: t_estado;
begin
	process(clk, nRst)
	begin
		if(nRst = '0') then
			estado <=ini;
		elsif clk'event and clk = '1' then
			case estado is
				when ini =>
					if start = '1' then 
						estado <= uno;
					end if; 
				when uno =>
					estado <= dos;
				when dos =>
					estado <= fin_operacion;
				when fin_operacion =>
					estado <= ini;
			end case;
		end if;
	end process;
	
	process(estado, start)
	begin
		case estado is
			when ini =>
				dir_digito <= "00";
				fin_op <='0';
				ena_acum <= '1';
				rst_acum <= start;
			when uno =>
				dir_digito <= "01";
				fin_op <= '0';
				ena_acum <= '1';
				rst_acum <= '0';
			when dos =>
				dir_digito <= "10";
				fin_op <= '0';
				ena_acum <= '1';
				rst_acum <= '0';
			when fin_operacion =>
				dir_digito <= "11";
				fin_op <= '1';
				ena_acum <= '0';
				rst_acum <= '0';
		end case;
	end process;
end rtl;
		 