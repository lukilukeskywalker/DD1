library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divisores is
port(clk:  in     std_logic;
     nRst: in     std_logic;
     sel:  in     std_logic;
     LED:  buffer std_logic);
end entity;

architecture rtl of divisores is
  signal cnt_05_seg:  std_logic_vector(22 downto 0);
  signal cout_05_seg: std_logic;
  signal cnt_cinco:   std_logic_vector(2 downto 0);
  signal cout_cinco:  std_logic;
  signal toggle:      std_logic;
  constant seis_mill_menos_uno:  natural:= 5999999;

begin
  process(clk, nRst)
  begin
    if nRst = '0' then
      cnt_05_seg <= (others => '0');
      
    elsif clk'event and clk = '1' then
      if cout_05_seg = '1' then       
        cnt_05_seg <= (others => '0');
        
      else
        cnt_05_seg <= cnt_05_seg + 1;
      end if;
    end if;
  end process;
  
  cout_05_seg <= '1' when cnt_05_seg = seis_mill_menos_uno
               else '0';
  
  process(clk, nRst)
  begin
    if nRst = '0' then
      cnt_cinco <= (others => '0');
      
    elsif clk'event and clk = '1' then
      if cout_05_seg = '1' then       
        if cout_cinco = '1' then       
          cnt_cinco <= (others => '0');
        
        else
          cnt_cinco <= cnt_cinco + 1;
        end if;
      end if;
    end if;
  end process;
  cout_cinco <= '1' when (cnt_cinco = 4) and (cout_05_seg = '1')
                else '0';

  toggle <= cout_05_seg when sel = '0' else
            cout_cinco;

  flip_flop_T:
  process(clk, nRst)
  begin
    if nRst = '0' then
      LED <= '0';
      
    elsif clk'event and clk = '1' then
      if toggle = '1' then       
        LED <= not LED;

      end if;
    end if;
  end process;             
end rtl;