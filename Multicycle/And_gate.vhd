library IEEE;
use IEEE.std_logic_1164.all;

entity AND2 is
port(x,y:in std_logic;z:out std_logic);
end AND2;

architecture behave of AND2 is 

signal tempz: std_logic;

begin

process(x,y)
begin
if x='1'then
	if y='1' then 
		tempz <='1';
	else 
		tempz<= '0';end if;
else
	tempz<= '0';end if;

end process;
z<= tempz;
end behave;
