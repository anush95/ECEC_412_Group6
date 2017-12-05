library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OR2 is
port(x, y : in  std_logic;
        z : out std_logic);
end OR2;

architecture behave of OR2 is
begin
process(x,y)
variable const: std_logic;
begin
    if x='1' or y='1' then
        const := '1';
    else
        const := '0';
    end if;            
    z <= const;    

end process;

end behave;