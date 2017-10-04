--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - Program Counter
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all

entity PC is
port(clk:in std_logic;
	AddressIn:in std_logic_vector(31 downto 0);
	AddressOut:out std_logic_vector(31 downto 0));
end PC;