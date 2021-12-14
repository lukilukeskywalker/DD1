--------------------------------------------------------------------------------
-- Autor:
-- Fecha:
-- Descripcion del test:
-- Reset asincrono inicial
-- Completar
-- ...
-- ...
-- ...
-- ...
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity test_sistema_monoestable is
end entity;

architecture test of test_sistema_monoestable is
  signal clk:      std_logic;
  signal nRst:     std_logic;
  signal control:  std_logic;
  signal disparo:  std_logic;
  signal duracion: std_logic_vector(11 downto 0);
  signal ventana:  std_logic;
  signal estado:   std_logic;

  constant T_CLK: time := 1 us;
  signal fin: boolean := false;
  signal pulsos: integer :=0;

  type state_machine is (pulso_simple, pulso_periodico);
  signal machine_state : state_machine := pulso_simple; 
begin

dut: entity work.sistema_monoestable(rtl)
     port map(clk      => clk,
              nRst     => nRst,
              control  => control,
              disparo  => disparo,
              duracion => duracion,
              ventana  => ventana);

  process
  begin
    clk <= '0';
    wait for T_CLK/2;
    clk <= '1';
    if fin = true then
      wait;
    end if;
    wait for T_CLK/2;

  end process;

  process
  begin
    nRst <= '0';
    duracion <= X"010";
    control <= '0';
    disparo <= '0';
    wait until clk'event and clk = '1';
    wait until clk'event and clk = '1';
    nRst <= '1';
    -- Para completar por el estudiante
    
	--Estado se encuentra en disparo simple. La duracion del pulso es 10.
	--Producimos el primer disparo.
	wait until clk'event and clk = '1';
	--control <='1';
	wait until clk'event and clk = '1';
	--control <='0';
	wait until clk'event and clk = '1';
	disparo <='1';
	wait until clk'event and clk = '1';
	disparo <='0';
	
	wait until pulsos = 10;
	wait until clk'event and clk = '1';
	duracion <= X"030";
	disparo <='1';
	wait until clk'event and clk = '1';
	disparo <='0';
	wait until pulsos = 40;
	wait until clk'event and clk = '1';
	control <='1';
	wait until clk'event and clk = '1';
	control <='0';
	wait until pulsos = 100;
	control <='1';
	wait until clk'event and clk = '1';
	control <='0';
	wait until clk'event and clk = '1';
	wait until clk'event and clk = '1';
disparo <='1';
	wait until clk'event and clk = '1';
	disparo <='0';
    
    wait until clk'event and clk = '1';
    ---fin <= true;
    wait;
  end process;
process(clk)
begin
	if(clk'event and clk='1') then 
		if(ventana='1') then 
			pulsos<=pulsos +1;
		end if;
	end if;
end process;
proc_planificador: process(clk)
begin
	if(clk'event and clk='1') then 
		case machine_state is
			when pulso_simple => 
				--if(pulsos > (duracion(3 downto 0) + duracion(7 downto 4)*"1010" + duracion(11 downto 8)*1111101000)) then
					--fin <= true;
				--end if;
			when pulso_periodico =>

		end case; 
	end if;
end process proc_planificador;

end test;

