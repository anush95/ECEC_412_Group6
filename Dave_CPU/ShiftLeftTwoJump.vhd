
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftLeftTwoJump is
port(x:in std_logic_vector(25 downto 0);
y:in std_logic_vector(3 downto 0);
z:out std_logic_vector(31 downto 0));
end ShiftLeftTwoJump;

architecture behavior of ShiftLeftTwoJump is
begin

process(x,y)
variable temp : std_logic_vector(31 downto 0);
begin
  temp(31 downto 28) := y;
  temp(27 downto 2) := x;
  temp(1 downto 0) := "00";
  z <= temp;

end process;
end behavior;