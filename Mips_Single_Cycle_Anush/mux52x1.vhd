library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux5 is
    Port ( 
	   SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (4 downto 0);
           B   : in  STD_LOGIC_VECTOR (4 downto 0);
           X   : out STD_LOGIC_VECTOR (4 downto 0));
end Mux5;

architecture Behavioral of Mux5 is
begin
P1: process(SEL, A, B)
begin
	
	if SEL = '1' then
		X <= A;
	elsif SEL = '0' then
		X <= B;
	end if;

end process P1;
end Behavioral;
