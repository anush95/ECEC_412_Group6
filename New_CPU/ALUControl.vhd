--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - ALU Control
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all

entity ALUControl is
port(ALUOp:in std_logic_vector(1 downto 0);
	Funct: in std_logic_vector(5 downto 0);
	Operation: out std_logic_vector(3 downto 0));
end ALUControl;