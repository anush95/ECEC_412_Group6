library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IR is
port(x:in std_logic_vector(31 downto 0);
     clk,IRWrite:in std_logic;
     y:out std_logic_vector(31 downto 0));
 end IR;


architecture behave of IR is


begin

P1:process(clk,IRWrite,x)
variable temp:std_logic_vector(31 downto 0);
begin

  if clk='0' and clk'event and IRWrite='1' then  
  temp:=x;
  end if;

  if clk='0' and clk'event then 
  y<=temp;
  end if;
  

end process P1;

end behave;