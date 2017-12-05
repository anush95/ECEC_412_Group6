library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux5 is
port (	x,y: in std_logic_vector(4 downto 0);
	sel : in std_logic;
	z : out std_logic_vector(4 downto 0));
end Mux5;

architecture beh of Mux5 is
begin
process(sel , x,y)
begin
if(sel = '1') then
z<=y;
else
z<= x;
end if;
end process;
end beh;

	