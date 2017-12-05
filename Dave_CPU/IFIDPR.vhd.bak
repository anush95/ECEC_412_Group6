library ieee;
use ieee.std_logic_1164.all;

entity IFIDPR is
port(CLK:in std_logic;
     LIN,IIN:in std_logic_vector(31 downto 0);
     LOUT,IOUT:out std_logic_vector(31 downto 0));
end IFIDPR;

architecture beh of IFIDPR is
signal LData:std_logic_vector(31 downto 0);
signal IData: std_logic_vector(31 downto 0);
begin
	process(CLK)
	begin
		if CLK'event and CLK='1' then
			LData <= LIN;
			IData <= IIN;
		end if;
		if CLK'event and CLK='0' then
			LOUT <= LData;
			IOUT <= IData;
		end if;
	end process;
end beh;