--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - CPU
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all

entity CPU is 
port(clk:in std_logic;
	Overflow:out std_logic);
end CPU;