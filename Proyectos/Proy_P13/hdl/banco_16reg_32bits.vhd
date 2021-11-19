
library ieee;
use ieee.std_logic_1164.all;

entity banco_16reg_32bits is
	port(clk: in std_logic;
 	     nRst: in std_logic;
 	     WE: in std_logic;
 	     Dir_WR: in std_logic_vector(3 downto 0);
 	     Din: in std_logic_vector(31 downto 0);
 	     Dir_RD: in std_logic_vector(3 downto 0);
 	     Dout: buffer std_logic_vector(31 downto 0));
end entity;

architecture rtl of banco_16reg_32bits is
 signal Reg0 : std_logic_vector(31 downto 0);
 signal Reg1 : std_logic_vector(31 downto 0);
 signal Reg2 : std_logic_vector(31 downto 0);
 signal Reg3 : std_logic_vector(31 downto 0);
 signal Reg4 : std_logic_vector(31 downto 0);
 signal Reg5 : std_logic_vector(31 downto 0);
 signal Reg6 : std_logic_vector(31 downto 0);
 signal Reg7 : std_logic_vector(31 downto 0);
 signal Reg8 : std_logic_vector(31 downto 0);
 signal Reg9 : std_logic_vector(31 downto 0);
 signal Reg10 : std_logic_vector(31 downto 0);
 signal Reg11 : std_logic_vector(31 downto 0);
 signal Reg12 : std_logic_vector(31 downto 0);
 signal Reg13 : std_logic_vector(31 downto 0);
 signal Reg14 : std_logic_vector(31 downto 0);
 signal Reg15 : std_logic_vector(31 downto 0);

 begin
 	process(clk, nRst)
	begin
	 if nRst = '0' then
	   reg0 <= (others => '0');
	   reg1 <= (others => '0');
           reg2 <= (others => '0');
           reg3 <= (others => '0');
           reg4 <= (others => '0');
	   reg5 <= (others => '0');
	   reg6 <= (others => '0');
           reg7 <= (others => '0');
           reg8 <= (others => '0');
           reg9 <= (others => '0');
	   reg10 <= (others => '0');
	   reg11 <= (others => '0');
           reg12 <= (others => '0');
           reg13 <= (others => '0');
           reg14 <= (others => '0');
	   reg15 <= (others => '0');
	 
	 elsif clk'event and clk = '1' then
	  if WE = '1' then
	     case Dir_WR is
		when "0000" => reg0 <= Din;
		when "0001" => reg1 <= Din;
		when "0010" => reg2 <= Din;
		when "0011" => reg3 <= Din;
		when "0100" => reg4 <= Din;
		when "0101" => reg5 <= Din;
		when "0110" => reg6 <= Din;
		when "0111" => reg7 <= Din;
		when "1000" => reg8 <= Din;
		when "1001" => reg9 <= Din;
		when "1010" => reg10 <= Din;
		when "1011" => reg11 <= Din;
		when "1100" => reg12 <= Din;
		when "1101" => reg13 <= Din;
		when "1110" => reg14 <= Din;
		when "1111" => reg15 <= Din;
		when others => null;
		
	     end case;
	   end if;
	 end if;
	end process;
	Dout <= reg0 when Dir_RD = "0000" else
		reg1 when Dir_RD = "0001" else
		reg2 when Dir_RD = "0010" else
		reg3 when Dir_RD = "0011" else
		reg4 when Dir_RD = "0100" else
		reg5 when Dir_RD = "0101" else
		reg6 when Dir_RD = "0110" else
		reg7 when Dir_RD = "0111" else
		reg8 when Dir_RD = "1000" else
		reg9 when Dir_RD = "1001" else
		reg10 when Dir_RD = "1010" else
		reg11 when Dir_RD = "1011" else
		reg12 when Dir_RD = "1100" else
		reg13 when Dir_RD = "1101" else
		reg14 when Dir_RD = "1110" else
		reg15;

end rtl;
