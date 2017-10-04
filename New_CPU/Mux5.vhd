--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - Mux5
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all

entity MUX5 is 
port(x,y:in std_logic_vector(4 downto 0);
	sel:in std_logic;
	z:out std_logic_vector(4 downto 0));
end MUX5;