--Como funciona?
--en ctrl_op decimos que operacion queremos hacer. Si metemos 0 es una suma, si metemos un 1 una resta
--En A y B metemos los dos numeros BCD
--Vale, vayamos paso por paso
--Primero en sgn comprobamos si la salida que va a salir va a ser negativa o positiva. Si B es mayor que A y lo restamos, 
--Obviamente saldra negativa, SI lo sumamos, es imposible que salga negativo.
--Siguiente. EN opA_minu y opB_sust tenemos previamente 2 multiplexores que meteran A en opA si el resultado de la operacion
--es positivo o en opB si es negativo. De esta forma, si nuestra operacion es restar, hacemos el complemento a 2 al
--numero mas pequeño
--Una vez seleccionado el orden de numeros, y haberlo convertido a modulo 2 si corresponde, hacemos una suma. 
--En resultado esta en binario. Si era una resta el resultado viene dado en BCD, 
--(ya que el max en esta calculadora es de -9) con un 4 bit indicando simbolo. 
--EN caso de ser suma, st requiere un ultimo paso, que es comprobar si la salida es mayor que 9, y si lo es, sumarle 6
--Ya que 6+10 forma 16, hace un acarreo, y pone el numero en BCD 


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sumador_restador_BCD is
	port(A, B: in std_logic_vector(3 downto 0);
		ctrl_op: in std_logic;
		sgn: buffer std_logic;
		modulo: buffer std_logic_vector(7 downto 0)
	);
end entity;

architecture rtl of sumador_restador_BCD is
	signal opA_minu: std_logic_vector(3 downto 0);
	signal opB_sust: std_logic_vector(3 downto 0);
	signal res_bin: std_logic_vector(4 downto 0);
	signal carry : std_logic;
begin
	sgn <='1' when ctrl_op = '1' and B>A else '0';	--Salida Signo
	opA_minu <= A when sgn = '0' else B;
	opB_sust <= B when sgn = '0' else A;
	res_bin <= 	('0'&opA_minu)+opB_sust when ctrl_op = '0' else
			('0'&opA_minu)+((not opB_sust)+1);
	carry <= '1' when res_bin >9 and ctrl_op = '0' else '0';
	--Salida de modulo
	modulo(7 downto 4) <= "000" & carry;
	modulo(3 downto 0) <= res_bin(3 downto 0) + ('0'&carry&carry&'0');
end rtl;
--This in my opinion is genious... but shady as fck to put it in an exam...
