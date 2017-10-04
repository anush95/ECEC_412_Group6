--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - Data Memory
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all

entity DataMemory is
port(WriteData:in std_logic_vector(31 downto 0);
	Address: in std_logic_vector(31 downto 0);
	Clk,MemRead,MemWrite: in std_logic;
	ReadData: out std_logic_vector(31 downto 0));
end DataMemory;