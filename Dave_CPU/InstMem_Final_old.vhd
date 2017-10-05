library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity InstMemory is
port(Address:in std_logic_vector(31 downto 0);  
     ReadData:out std_logic_vector(31 downto 0);
	ck:in std_logic);
end InstMemory;

architecture beh of InstMemory is
type memoryArray is array(0 to 31) of std_logic_vector(31 downto 0);
signal memContents:memoryArray := (
    X"8D150000",
    X"8D160004", 
    X"02B6782A",
    X"100F0002",
    X"11E00002",
    X"02538822",
    X"08000007",
    X"AD11000C",
    X"00000000",
    X"00000000", 
    X"00000000",
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",  
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000",
    X"00000000");

begin
process(ck)
begin
if ck='0' and ck'event then
	ReadData <= memContents(conv_integer(Address(31 downto 2)));
end if;
--wait on address;       
end process;

end beh;

