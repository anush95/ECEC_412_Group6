library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstMemory is
port(Address:in std_logic_vector(31 downto 0);  
     ReadData:out std_logic_vector(31 downto 0));
end InstMemory;

architecture beh of InstMemory is
type memoryArray is array(0 to 31) of std_logic_vector(31 downto 0);
signal memContents:memoryArray := (
	-- Code 1
	0 => X"02959820",
	1 => X"8d100000",
	2 => X"8d110004",
	3 => X"0296b822",
	4 => X"ad130008",
	others => X"00000000"

	-- Code 2

--	others => X"00000000"

	-- Code 3

--	others => X"00000000"

	-- Code 4

--	others => X"00000000"
	
	-- Code 5

--	others => X"00000000"
);
begin
ReadData <= memContents(to_integer(unsigned(Address))/4);
end beh;
