library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCMulticycle is
port(clk,d:in std_logic;
     AddressIn:in std_logic_vector(31 downto 0);
     AddressOut:out std_logic_vector(31 downto 0));
end PCMulticycle;

architecture behave of PCMulticycle is
begin

process(clk, d, AddressIn)
variable x : integer:=0;
begin
if clk'event  and clk = '1' and d = '1' then
	AddressOut <= AddressIn;
else
	if x = 0 then 
		AddressOut <= (others => '0');
		x := 1;
	end if;
end if;
end process;

end behave;