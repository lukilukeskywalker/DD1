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


entity test_sistema_monoestable is
end entity;

architecture test of test_sistema_monoestable is
  signal clk:      std_logic;
  signal nRst:     std_logic;
  signal control:  std_logic;
  signal disparo:  std_logic;
  signal duracion: std_logic_vector(11 downto 0);
  signal ventana:  std_logic;

  constant T_CLK: time := 1 us;
  signal fin: boolean := false;
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
	wait until 
    
    wait until clk'event and clk = '1';
    fin <= true;
    wait;
  end process;
process(
end test;

