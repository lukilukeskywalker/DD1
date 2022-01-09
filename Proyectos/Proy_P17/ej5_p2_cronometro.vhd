-- Modelo para el Cronometro del ejercicio 5
-- Tiene errores sintácticos que hay que corregir
-- También tiene 3 errores funcionales que se pueden corregir por separado



library ieee;
use ieee.std_logic_1164.all;
--Faltaba introducir la siguiente libreria, por tanto operadores + - fallan
use ieee.std_logic_unsigned.all;

--Entradas definidas por el enunciado: ini_c, sto_1, sto_2
	--Cuando el cronometro esta parado y se presiona ini_c, el cronometro debe contar hasta 59.9, y pasar al estado inicial
	--Cuando se presiona sto_1 el estado de cuenta se almacena y se puede ver en seg_d_st1, seg_u_st1 y dec_st1
	--Cuando se presiona sto_2 el estado de cuenta se almacena y se puede ver en seg_d_st2, seg_u_st2 y dec_st2
--Salidas definidas por el enunciado: 
	--seg_u, seg_d, dec <-Cronometro 
	--seg_d_st1, seg_u_st1 y dec_st1
	--seg_d_st2, seg_d_st2 y dec_st2

--OBJETIVO 2 EJERCICIO, O PRIMER EJERCICIO DE DISEÑO
--seg_d_st2, seg_u_st2 y dec_st2 quedan eliminadas.
--sto_2 solamente detiene el contador. Una vez se apreta ini_c teniendo el contador en un estado que no sea el inicial, se 
--reinicia el contador.
--Se pide que se utilice un unico registro de almacenamiento
entity cronometro is port(
 clk       : in std_logic;
 rst_n     : in std_logic;
 sto_1     : in std_logic;
 sto_2     : in std_logic;
 ini_c     : in std_logic;
 seg_u     : buffer std_logic_vector(3 downto 0);
 seg_d     : buffer std_logic_vector(3 downto 0);
 dec       : buffer std_logic_vector(3 downto 0);
 seg_u_st1 : buffer std_logic_vector(3 downto 0);
 seg_d_st1 : buffer std_logic_vector(3 downto 0);
 dec_st1   : buffer std_logic_vector(3 downto 0);
 seg_u_st2 : buffer std_logic_vector(3 downto 0);
 seg_d_st2 : buffer std_logic_vector(3 downto 0);
 dec_st2   : buffer std_logic_vector(3 downto 0)
);
end entity;

architecture rtl of cronometro is
signal cnt       : std_logic_vector(22 downto 0);
signal tic       : std_logic;
signal ena       : std_logic;
signal eoc_dec   : std_logic;
signal eoc_seg_u : std_logic;
signal eoc_seg_d : std_logic;
signal reset     : std_logic;
--Las siguentes señales son salidas que se introdujeron erroneamente
--signal seg_u     : std_logic_vector(3 downto 0);
--signal seg_d     : std_logic_vector(3 downto 0);
--signal dec       : std_logic_vector(3 downto 0);
--signal seg_u_st1 : std_logic_vector(3 downto 0);
--signal seg_d_st1 : std_logic_vector(3 downto 0);
--signal dec_st1   : std_logic_vector(3 downto 0);
--signal seg_u_st2 : std_logic_vector(3 downto 0);
--signal seg_d_st2 : std_logic_vector(3 downto 0);
--signal dec_st2   : std_logic_vector(3 downto 0);

-- Para diseño físico descomentar la línea 47 y comentar la 48
-- constant T_DEC : integer := 5000000; -- para diseño físico (con reloj de 50 MHz) 
constant T_DEC : integer := 5;-- para simulación
begin
 -- Subsistema_1
 process(clk, rst_n)--Subsistema generador de TICS
 begin
   if rst_n = '0' then
     cnt <= (0 => '1',others => '0');
   elsif clk'event and clk = '1' then
     if tic = '1' or reset = '1' then
       cnt <= (0 => '1',others => '0');
     else
       cnt <= cnt + 1;
     end if;
   end if;  
 end process;

 tic <= '1' when cnt = T_DEC else '0';
 -- Para sincronizar la cuenta con inic_c
 reset <= '1' when ini_c = '1' and ena = '1' else '0';
 -- Fin subsistema_1
--Funcion sub_1: Produce un tic cada vez que el contador cnt vale T_DEC. En el siguiente flanco de reloj se resetea el contador
--y el comparador pone tic a 0. Ademas el contador se resetea si reset esta a 1 durante minimo un periodo de tiempo

 -- Subsistema_2
 process(clk, rst_n)--Subsistema de control ini_c
 begin
  if rst_n = '0' then
    ena <= '0';
  elsif clk'event and clk = '1' then
    if reset = '1' then --Cambio a reset sincrono por reloj, no por subcontador
	ena <= '0';
    elsif ini_c = '1' then
      ena <= '1';
    elsif (seg_d&seg_u&dec) = X"599" and tic = '1' then --Aqui tendria que poner un reset¿?
      ena <= '0';
    end if;
  end if;  
 end process;

 -- Fin subsistema_2
--Funcion sub_2: Habilita ena si ini_c esta activo en el siguiente flanco de reloj. 
--Desactiva ena en el siguiente flanco de reloj desde que el cronometro TOTAL llega al estado final. 
--Comentario adicional: Es genial, al hacerlo en un sistema controlado por flanco de reloj, desactivamos el reloj 
--y ponemos el reloj a 000
 -- Subsistema_3
 
process(clk, rst_n) --Proceso contador de decenas de segundo
 begin
   if rst_n = '0' then
     dec <= (others => '0');
   elsif clk'event and clk = '1' then
     if reset = '1' then 
	dec <= (others => '0');
     elsif  ena = '1' and tic = '1' then
       if eoc_dec = '1' then
         dec <= (others => '0');
       else
         dec <= dec + 1;
       end if;
     end if;
   end if;  
 end process;
-- En las lineas 118, 135 y 152 Se comete un error. Se comprueba dec, seg_u y seg_d con '9' lo cual es incorrecto . Debe ser 9, no '9'
 eoc_dec <= '1' when ena = '1' and dec = 9 else '0'; --eoc_dec <= '1' when ena = '1' and dec = '9' else '0'; Error!

 process(clk, rst_n)--Proceso contador unidades segundo
  begin
    if rst_n = '0' then
      seg_u <= (others => '0');
    elsif clk'event and clk = '1' then
      --if eoc_dec <= '1' and tic = '1' then --Error!
      if reset = '1' then
	  seg_u <= (others => '0');
      elsif eoc_dec = '1' and tic = '1' then 
        if eoc_seg_u = '1' then
          seg_u <= (others => '0');
        else
          seg_u <= seg_u + 1;
        end if;
      end if;
    end if;  
  end process;

 eoc_seg_u <= '1' when eoc_dec = '1' and seg_u = 9 else '0';
 
 process(clk, rst_n) --Procesp contador de decenas de segundo
  begin
    if rst_n = '0' then
      seg_d <= (others => '0');
    elsif clk'event and clk = '1' then
      if reset = '1' then
	seg_d <= (others => '0');
      elsif eoc_seg_u = '1' and tic = '1' then
        if eoc_seg_d = '1' then
          seg_d <= (others => '0');
        else
          seg_d <= seg_d + 1;
        end if;
      end if;
    end if;  
  end process;

-- eoc_seg_d <= '1' when eoc_seg_u = '1' and seg_d = 9 else '0'; 
--Aqui se produce otro error: cuenta hasta decimas 9... pero algo me dice que es redundante. Bueno no
--Pensaba que seria redundante porque ena, que se desactiva en 599, pensaria que el propio contador se pondria en 000,
--pero sin embargo se pondria en 600, lo cual es incorrecto. Por tanto: 
eoc_seg_d <= '1' when eoc_seg_u = '1' and seg_d = 5 else '0';


-- Fin subsistema_3
--Funcion sub_3: El sistema consiste en 3 contadores decimales. Cuando el contador decimal llega a 9, eoc_dec se pone a 1
--de tal forma que en el siguiente flanco de reloj, actualiza el contador de unidades de segundo y reinicia el contador 
--decimal. Sucede el mismo proeso en el contador unidades de segundero seg_u, cuando llega a 9 eoc_se_u pasa a 1, el cual
--en el siguiente flanco de reloj actualiza el contador decimal de segundos y reinicia el contador de unidades de segundo
-- El ultimo proceso de reset, eoc_seg_d se pone a 1 si el reset de los anteriores contadores se pone a 1 y el contador de 
--decimas vale 5 (anteriormente 9, pero prob este mal) 

-- Subsistema_4

 process(clk, rst_n)
 begin
   if rst_n = '0' then
    seg_u_st1 <= (others => '0');
    seg_d_st1 <= (others => '0');
    dec_st1   <= (others => '0');
    seg_u_st2 <= (others => '0');
    seg_d_st2 <= (others => '0');
    dec_st2   <= (others => '0');
   elsif clk'event and clk = '1' then
     if sto_1 = '1' then
      seg_u_st1 <= seg_u;
      seg_d_st1 <= seg_d;
      dec_st1   <= dec;
     end if;
     if sto_2 = '1' then
      seg_u_st2 <= seg_u;
      seg_d_st2 <= seg_d;
      dec_st2   <= dec;
     end if;
   end if;  
 end process;

-- Fin subsistema_4
--Funcionamiento sub_4: Es el sistema que si se presiona sto_1 o/y sto_2 guarda el valor del cronometro en sus respectivos 
--registros y salidas.

end rtl;
--El tercer problema que creo haber detectado, pero que en realidad ni se pide en el enunciado es que hay un condicional 
--de reset que pone la señal "reset" a 1 cuando ini_c y ena estan activos. Pero en los subsistemas no hay condicioanl de 
--reset
--El reset sincrono que he creado es solamente sincrono a reloj no a subcontador de tics