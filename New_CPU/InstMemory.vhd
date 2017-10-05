--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - Instruction Memory
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all

entity InstMemory is
port(Address:in std_logic_vector(31 downto 0);
	ReadData:out std_logic_vector(31 downto 0));
end InstMemory;