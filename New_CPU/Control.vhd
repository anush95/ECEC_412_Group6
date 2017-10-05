--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - Control
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all

entity Control is
port(Opcode:in std_logic_vector(5 downto 0);
	RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
	ALUOp:out std_logic_vector(1 downto 0));
end Control;