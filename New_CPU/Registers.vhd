--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - Registers
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all

entity registers is
port(RR1,RR2,WR:in std_logic_vector(4 downto 0);
	WD:in std_logic_vector(31 downto 0);
	Clk,RegWrite:in std_logic;
	RD1,RD2: out std_logic_vector(31 downto 0));
end registers;