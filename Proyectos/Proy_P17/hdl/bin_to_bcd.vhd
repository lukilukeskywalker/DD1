
--EL objetivo es cambiar el codigo binario a bcd, guardarlo en 4 registros, que pueden ser seleccionados por una entrada
-- Basado en https://allaboutfpga.com/vhdl-code-for-binary-to-bcd-converter/#Simulation_Waveform_Result_for_Binary_to_BCD_Converter
-- Pero este me ha resuelto la ultima duda: https://olduino.files.wordpress.com/2015/03/why-does-double-dabble-work.pdf
-- El problema es que hacia una iteracion mas en la conversion, añadiendo 3 una iteracion mas de las necesarias
--Importante recordar que hay un orden. Primero se añade 3 si el valor del segmento bcd es
-- mayor a 4 (porque al shiftearlo, osea doblando el valor, se convierte en si es 5 a 10) y una vez shifteado, sumar el carry out de binario
-- Yo sin enbargo no hago ningun shift (en binary) , sino elijo el index correspondiente o equivalente
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bin_to_bcd is
	generic(bin_size: positive := 14);
	port(nRst, clk: in std_logic;
		bin_in: in std_logic_vector(bin_size-1 downto 0);
		ENA: in std_logic;
		sel_dig: in std_logic_vector(1 downto 0);
		BCD: buffer std_logic_vector(3 downto 0);
		C_END: buffer std_logic
		);
end entity;

architecture rtl of bin_to_bcd is
	type states is (start, shift, done);
	signal state: states:= start;
	signal counter: integer:= 0; --Esto prob con natural range 0 to bin_size, se reduciria el tamaño que ocupa en memoria
	signal binary: std_logic_vector(bin_size-1 downto 0);
	signal bcd_reg: std_logic_vector(15 downto 0);
	signal bcd_reg_prev: std_logic_vector(15 downto 0);
	
	begin
	proc_conversor: process(clk, nRst)
	begin
		if(nRst = '0') then 
			state <= start;
			bcd_reg_prev <=(others => '0');
		elsif(clk'event and clk = '1') then
			case state is
				when start =>
					if(ENA='1') then	
						binary <= bin_in;
						bcd_reg_prev <= (others => '0');
						counter <= 0;
						state <= shift;
					end if;
				when shift =>
					if(counter = bin_size-1) then
						state <= done;
					end if;
--Step 2: Se dobla en valor de bcd_reg y se añade el bit carry out del dato binario. Esto despues de comparar si es mayor que 4 y añadir 3 si lo es
					bcd_reg_prev <= bcd_reg(14 downto 0) &binary(bin_size-1-counter);
					counter <= counter +1;
				when done =>
					state <= start;
					--if(ENA='1') then 
					--	state <= start;
					--end if;						
				end case;
--				if(counter < bin_size) then 
--					bcd_reg_prev <= bcd_reg(14 downto 0)&binary(bin_size-1-counter);
--					--Ahora bcd_reg contiene el dato shifteado
--					--El siguiente paso consiste en modificarlo añadiendo 3 o 6 (3 es 6 shifteado)
					--FALSO. El primer paso es hacer la comprobacion, el segundo paso es hacer el shifteo
--					counter <= counter +1;
--				end if;
		end if;
	end process proc_conversor;

--Si shifteamos los datos hacia la izq, cada vez que en el numero se supere el valor 4, en el siguiente shifteo,
--se superara el valor admitido en el segmento de 4 bits. Ejemplo: supongamos que tenemos 5 en bcd0. Si lo shifteamos se 
--convierte en A. A no es un valor valido en formato decimal. Por lo tanto tenemos que poner un 1 en el siguiente segmento
--bcd. Igual con 6. 6 se convierte en 12. 1-2 (bcd). Todo esto es equivalente a una suma de 3, cada vez que supera 4
--Pero que sucede cuando solo el MSB tiene 1. Entonces es 8 el valor, y es un valor valido. Sumar 3 solo romperia el 

--Se puede tomar una nueva ruta, que es realizar el shifteo y sumar 6. FALSO. El doblaje o shifteo debe ser realizado 
--despues de la comparacion para evitar condicion prohibida (bcd_reg > 4, predoblaje, bcd_reg > 9 posdoblaje y suma acarreo

--Step 1: Check for BCD digits greater than 4: If found add 3
	bcd_reg(3 downto 0) <= bcd_reg_prev(3 downto 0) +3 when bcd_reg_prev(3 downto 0) > 4  and state = shift else
				bcd_reg_prev(3 downto 0);
	bcd_reg(7 downto 4) <= bcd_reg_prev(7 downto 4) +3 when bcd_reg_prev(7 downto 4) > 4  and state = shift else
				bcd_reg_prev(7 downto 4);
	bcd_reg(11 downto 8) <= bcd_reg_prev(11 downto 8) +3 when bcd_reg_prev(11 downto 8) > 4  and state = shift else
				bcd_reg_prev(11 downto 8);
	bcd_reg(15 downto 12) <= bcd_reg_prev(15 downto 12) +3 when bcd_reg_prev(15 downto 12) > 4 and state = shift else
				bcd_reg_prev(15 downto 12);

--Selecionador de salida
	BCD <= x"0" when state = shift else	--Se inhabilita la salida mientras que se hacen operaciones. No se si realmente seria necesario
		bcd_reg(3 downto 0) when sel_dig = 0 else
		bcd_reg(7 downto 4) when sel_dig = 1 else
		bcd_reg(11 downto 8) when sel_dig = 2 else
		bcd_reg(15 downto 12);

--Aviso proceso finalizado
	C_END <= '1' when state = done else
		'0'; 
	
				
		

end rtl;
	