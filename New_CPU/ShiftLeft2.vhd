--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - Shift Left 2
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all

entity ShiftLeft2 is 
port(x:in std_logic_vector(31 downto 0);
	y:out std_logic_vector(31 downto 0));
end ShiftLeft2;