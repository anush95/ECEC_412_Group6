
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftLeftTwo is
port(x:in std_logic_vector(31 downto 0);y:out std_logic_vector(31 downto 0));
end ShiftLeftTwo;

architecture behavior of ShiftLeftTwo is
begin
y <= x(29 downto 0) & x(31 downto 30);
end behavior;