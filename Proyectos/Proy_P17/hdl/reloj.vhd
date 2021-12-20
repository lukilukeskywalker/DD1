
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reloj is
	port(clk: in std_logic;
		nRst: in std_logic;
		hora_dec: buffer std_logic_vector(1 downto 0);
		hora_unid: buffer std_logic_vector(3 downto 0);
		minuto_dec: buffer std_logic_vector(2 downto 0);
		minuto_unid: buffer std_logic_vector(3 downto 0)
		);
end entity;

architecture rtl of reloj is
	signal cnt_60_seg: std_logic_vector(27 downto 0);
	signal cout_60_seg: std_logic;
	constant LX_meg_menos_uno: natural:=59999999;

	signal cout_minuto_unid: std_logic;
	signal cout_minuto_dec: std_logic;
	signal cout_hora_unid: std_logic;
	signal rst_hora: std_logic;

begin
	process(clk, nRst)
	begin
		if nRst = '0' then
			cnt_60_seg <=(others => '0');
		elsif( clk'event and clk = '1') then 
			if cout_60_seg = '1' then 
				cnt_60_seg<=(others => '0');
			else
				cnt_60_seg <= cnt_60_seg + 1;
			end if;
		end if;
	end process;
	
	cout_60_seg <= '1' when cnt_60_seg = LX_meg_menos_uno else
			'0';

	process(clk, nRst)
	begin
		if nRst = '0' then 
			minuto_unid <= (others =>'0');
		elsif clk'event and clk = '1' then
			if cout_minuto_unid = '1' then
				minuto_unid <=(others => '0');
			else
				minuto_unid <= minuto_unid +1;
			end if;
		end if;
	end process;
	cout_minuto_unid <= '1' when (minuto_unid = 9) and (cout_60_seg = '1') else
				'0';

	process(clk, nRst)
	begin
		if nRst = '0' then 
			hora_unid <= (others => '0');
		elsif clk'event and clk = '1' then
			if cout_minuto_dec = '1' then 
				if cout_hora_unid = '1' or rst_hora = '1' then 
					hora_unid <= (others => '0');
				else
					hora_unid <= hora_unid +1;
				end if;
			end if;
		end if;
	end process;
	cout_hora_unid <= '1' when (hora_unid = 9) and (cout_minuto_dec = '1') else
				'0';

	process(clk, nRst)
	begin
		if nRst = '0' then
			hora_dec <= (others => '0');
		elsif clk'event and clk = '1' then 
			if rst_hora = '1' then 
				hora_dec <= (others => '0');
			elsif cout_hora_unid = '1' then 
				hora_dec <= hora_dec +1 ;
			end if;
		end if;
	end process;

	rst_hora <= '1' when (hora_dec=1) and (hora_unid = 1) and (cout_minuto_dec = '1') else '0';
	
end rtl; 




	