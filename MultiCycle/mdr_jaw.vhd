library ieee;
use ieee.std_logic_1164.all;

entity MDR is
port(x:in std_logic_vector(31 downto 0);
     clk:in std_logic;
     y:out std_logic_vector(31 downto 0));
end MDR;

architecture beh of MDR is
signal regData:std_logic_vector(31 downto 0);
begin
	process(x, clk)
	begin
		if clk'event and clk = '1' then
			regData <= x;
		end if;
		if clk'event and clk = '0' then
			y <= regData;
		end if;
	end process;
end beh;