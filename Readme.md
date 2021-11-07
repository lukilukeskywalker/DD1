<h2>TB_CLK</h2>


```vhdl
clk_sim: process
begin
	clk<='0';
	wait for T_CLK/2;
	clk<='1';
	wait for T_CLK/2;
end process clk_sim;
```
