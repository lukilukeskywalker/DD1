--------------------------------------------------------------------------------
-- Autor:
-- Fecha:
-- Monoestable no redisparable programable para generar pulsos con una duracion
-- de entre 1 y 999 ciclos de reloj
--
-- La duracion de los pulsos se indica, en BCD, por la entrada "duracion"
--
-- La entrada "control" permite seleccionar, mediante un pulso, uno de los dos
-- modos de funcionamiento:
---- Modo de disparo simple: se genera un pulso cada vez que se activa la
---- entrada "disparo"
---- Modo de disparo periodico: se genera un pulso cada 1000 periodos de reloj
--
-- Las entradas "control" y "disparo" llegan al monoestable ya conformadas, de
-- manera que sus pulsos son activos a nivel alto y tienen una duracion de un
-- periodo del reloj del sistema
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sistema_monoestable is
port(clk:      in     std_logic;
     nRst:     in     std_logic;
     control:  in     std_logic;	--Si se activa a nivel alto se cambia de disparo simple a disparo
     disparo:  in     std_logic;
     duracion: in     std_logic_vector(11 downto 0);
     ventana:  buffer    std_logic);

end entity;

architecture rtl of sistema_monoestable is
  signal   div_1K: std_logic_vector(9  downto 0);
--  constant mil:    natural := 1000;  -- Sintesis
  constant mil:    natural :=  1000;  --Simulacion (escalado)
  signal   tic_1K: std_logic;

  signal unidades:  std_logic_vector(3 downto 0);
  signal decenas:   std_logic_vector(3 downto 0);
  signal centenas:  std_logic_vector(3 downto 0);
  signal fin_pulso: std_logic;

  type t_estado is (disparo_simple, disparo_periodico);
  signal estado: t_estado;
  signal disparo_i: std_logic; 
  
  signal ena_u: std_logic;

begin
  -- Timer
  process(clk, nRst)
  begin
    if nRst = '0' then
      div_1K <= (0 => '1', others => '0');

    elsif clk'event and clk = '1' then
	if(tic_1K = '1') then 
		div_1K <= (0 => '1', others => '0');	--Para reiniciar el contador a 0. Cuando se produce FC, en el siguiente CLK se pone a 1
	else 
		div_1K <= div_1K + 1;	--Sino se añade 1 al numero
	end if;
      

    end if;
  end process;
  tic_1K <= '1' when div_1K = mil else
            '0';


  -- Monoestable BCD
  ventana <= '0' when unidades = 0 and decenas = 0 and centenas = 0 else
             '1';

  ena_u <= disparo_i when ventana   = '0' else
           '1'       when fin_pulso = '0' else
           ventana;

  fin_pulso <= '1' when centenas&decenas&unidades > duracion else
               '0';           

  -- Contador BCD del monoestable
  process(clk, nRst)
  begin
    if nRst = '0' then
      unidades <= "0000";

    elsif clk'event and clk = '1' then
      if fin_pulso = '1' then
        unidades <= "0000";
      
      elsif ena_u = '1' then
        if unidades = 9 then
          unidades <= "0000";

        else
          unidades <= unidades + 1;

        end if;
      end if;
    end if;
  end process;

  process(clk, nRst)
  begin
    if nRst = '0' then
      decenas <= "0000";

    elsif clk'event and clk = '1' then
      if fin_pulso = '1' then
        decenas <= "0000";

      elsif unidades = 9 then
        if decenas = 9 then
          decenas <= "0000";

        else
          decenas <= decenas + 1;
        
        end if;
      end if;
    end if;
  end process;

  process(clk, nRst)
  begin
    if nRst = '0' then
      centenas <= "0000";

    elsif clk'event and clk = '1' then
      if fin_pulso = '1' then
        centenas <= "0000";

      elsif decenas = 9 then
        centenas <= centenas + 1;

      end if;
    end if;
  end process;


-- Automata
  process(clk, nRst)
  begin
    if nRst = '0' then
      estado <= disparo_simple;

    elsif clk'event and clk = '1' then
      if estado = disparo_simple then
        if control = '1' then
          estado <= disparo_periodico;

        end if;

      elsif estado = disparo_periodico then
        if control = '1' then
          estado <= disparo_simple;

        end if;
      end if;
    end if;
  end process;

  disparo_i <= disparo when estado = disparo_simple else
               '0';

end rtl;

