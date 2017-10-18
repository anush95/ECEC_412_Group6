library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegB is
port(x:in std_logic_vector(31 downto 0);
     clk:in std_logic;
     y:out std_logic_vector(31 downto 0));
 end RegB;

architecture b of RegB is
begin

process(x, clk)
begin
if clk'event and clk='1' then
	y <= x;
end if;
end process;

end b;
