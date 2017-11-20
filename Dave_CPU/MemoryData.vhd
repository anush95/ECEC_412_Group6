library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoryData is
port(WriteData:in std_logic_vector(31 downto 0);
     Address:in std_logic_vector(31 downto 0);
     MemRead,MemWrite:in std_logic;
     ReadData:out std_logic_vector(31 downto 0));
end MemoryData;

architecture behavioral of MemoryData is
type memoryArray is array(0 to 55) of std_logic_vector(31 downto 0);
signal dataMem: memoryArray := (
	-- Data Memory
	0 => X"00000004",
	1 => X"00000004",
	others => X"00000000"
);
signal temp: std_logic_vector(31 downto 0) := X"00000000";
begin
ReadData <= temp;
process(WriteData, Address, MemRead, MemWrite)
begin
if MemWrite = '1' then
  dataMem(to_integer(unsigned(Address))/4) <= WriteData;
end if;

if MemRead = '1' then
  temp <= dataMem(to_integer(unsigned(Address))/4);
end if;
end process;
end behavioral;