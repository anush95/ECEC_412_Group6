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
	variable count : integer := 0;
	begin
		if clk='1' and clk'event then
			--temp <= AddressIn;
			if count=0 then
				AddressOut <= (others => '0');
				count := count + 1;
			else
				AddressOut <= AddressIn;
			end if;
		end if;
	end process;

end behavioral;