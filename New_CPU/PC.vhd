--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - Program Counter
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;

entity PC is
port(clk:in std_logic;
	AddressIn:in std_logic_vector(31 downto 0);
	AddressOut:out std_logic_vector(31 downto 0));
end PC;

architecture behavioral of PC is
signal temp: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
begin

process(clk)
begin
	if clk='1' and clk'event then
		temp <= AddressIn;
	end if;
	AddressOut <= temp;
end process;

end behavioral;