library IEEE;
use IEEE.std_logic_1164.all;

entity SignExtend is
port(x : in std_logic_vector(15 downto 0);
     y : out std_logic_vector(31 downto 0));
end SignExtend;
architecture behave of SignExtend is
signal temp: std_logic_vector(15 downto 0);
signal temp2: std_logic_vector(31 downto 0);

begin
process (x)
begin
	temp <= x;
	if x(15) = '1' then
		temp2 <= "1111111111111111" & x;
	else
		temp2 <= "0000000000000000" & x;
	end if;
end process;
y<= temp2;
end behave;
