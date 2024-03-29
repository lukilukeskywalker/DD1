-- Multiplicador de dos numeros de 16 bits
-- La multiplicacion comienza cuando se activa START durante un periodo del reloj del sistema
-- Previamente el multplicando y el multiplicador deben estar en las entradas A y B, respectivamente
-- El circuito activa la salida FIN cuando termina de realizar la operacion, que estara disponible
-- en la salida PRODUCTO

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multiplicador is
port(nRst      : in std_logic;
     clk       : in std_logic;
     start     : in std_logic;
     A         : in std_logic_vector(15 downto 0);
     B         : in std_logic_vector(15 downto 0);
     fin       : buffer std_logic;
     producto  : buffer std_logic_vector(31 downto 0)
     );
end entity;

architecture rtl of multiplicador is

  signal mndo, mdor : std_logic_vector(3 downto 0);
  signal res : std_logic_vector(7 downto 0);
  signal SUM: std_logic_vector(31 downto 0);
  signal FACTOR: std_logic_vector(31 downto 0);
  signal ENA: std_logic;
  signal CRTL: std_logic_vector(2 downto 0);
  signal Q: std_logic_vector(3 downto 0);
  signal FDC: std_logic;
begin

-----------------------------------------------------------------------------------------------------
-- Ejercicio 1
-----------------------------------------------------------------------------------------------------
proc_sumador: process(SUM, FACTOR)
begin
  producto<=SUM+FACTOR;
end process proc_sumador;
proc_registro: process(nRst, clk)
begin
  if(nRst='0') then SUM<=x"00000000";
  elsif(clk'event and clk='1') then
    if(start='1') then SUM<=x"00000000";
    elsif(ENA='1') then SUM<=producto;
    end if;
  end if;
end process proc_registro;
    

-----------------------------------------------------------------------------------------------------
-- Ejercicio 2
-----------------------------------------------------------------------------------------------------

proc_desplazador: process(res, CRTL)
begin
  --Esto con un << en c seria super facil. es solo un shift
  case CRTL is
    when "000" => FACTOR <= x"000000" & res;
    when "001" => FACTOR <= x"00000" & res & x"0";
    when "010" => FACTOR <= x"0000" & res & x"00";
    when "011" => FACTOR <= X"000" & res & x"000";
    when "100" => FACTOR <= x"00" & res & x"0000";
    when "101" => FACTOR <= x"0" & res & x"00000";
    when "110" => FACTOR <= res & x"000000";
    when others => FACTOR <= x"00000000";
    end case;
  end process proc_desplazador;
-----------------------------------------------------------------------------------------------------
-- Ejercicio 3
-----------------------------------------------------------------------------------------------------

-- Modelo del multiplicador de 4 bits
  res <= mndo * mdor;
-- Selectores
proc_selector1: process(B, Q)
begin
  if(Q(1 downto 0) = "00") then mndo <= B(3 downto 0);
  elsif(Q(1 downto 0) = "01") then mndo <= B(7 downto 4);
  elsif(Q(1 downto 0) = "10") then mndo <= B(11 downto 8);
  elsif(Q(1 downto 0) = "11") then mndo <= B(15 downto 12);
  else mndo <= x"0";
  end if;
end process proc_selector1;

proc_selector2: process(A, Q)
begin
  if(Q(1 downto 0) = "00") then mdor <= A(3 downto 0);
  elsif(Q(1 downto 0) = "01") then mdor <= A(7 downto 4);
  elsif(Q(1 downto 0) = "10") then mdor <= A(11 downto 8);
  elsif(Q(1 downto 0) = "11") then mdor <= A(15 downto 12);
  else mdor <= x"0";
  end if;
end process proc_selector2;


-- Contador

proc_contador_4bits: process(nRst, clk)
begin
  --Supongo que es un contador simple 1 a 16
  if nRst = '0' then 
    Q<= x"0";
    FDC<='0';
  elsif clk'event and clk = '1' then
    if START = '1' then 
      Q <= x"0";
      FDC <= '0';
    elsif ENA='1' then
      case Q is
        when x"0" | x"2" | x"4" | x"6" | x"8" | x"A" | x"C" | x"E" =>
          Q <= Q(3 downto 1) & "1";
        when x"1" => Q <=x"2";
		    when x"3" => Q <=x"4";
		    when x"5" | x"9" |x"D" => Q <= Q(3 downto 2) & "10";
		    when x"7" => Q<=x"8";
		    when x"B" => Q<=x"C";
		    when x"F" => Q<=x"0";
		      FDC<='1';
		    when others => Q <= "0000";
	     end case;
	   end if;
	 end if;
	end process proc_contador_4bits;
	     

-----------------------------------------------------------------------------------------------------
-- Ejercicio 4
-----------------------------------------------------------------------------------------------------

-- Codificador

-- Control

end rtl;
