library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux is
    Port ( 
	   
	   SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (31 downto 0);
           B   : in  STD_LOGIC_VECTOR (31 downto 0);
           X   : out STD_LOGIC_VECTOR (31 downto 0));
end Mux;

architecture Behavioral of Mux is
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
