library ieee;
use ieee.std_logic_1164.all, ieee.std_logic_arith.all;

entity MemoryData is
port(WriteData:in std_logic_vector(31 downto 0);
     Address:in std_logic_vector(31 downto 0);
     clk,MemRead,MemWrite:in std_logic;
     ReadData:out std_logic_vector(31 downto 0));
end MemoryData;

architecture behavioral of MemoryData is
type memoryArray is array(0 to 2**8-1) of std_logic_vector(7 downto 0);
signal memoryContents:memoryArray;
begin
process(clk)
variable j : integer;
variable flag : boolean := FALSE;
begin

if flag = FALSE then
  
  memoryContents(4) <= "11111111";
  memoryContents(5) <= "11111111";
  memoryContents(6) <= "11111111";
  memoryContents(7) <= "11111100";
  
  memoryContents(8) <= "11111111";
  memoryContents(9) <= "11111111";
  memoryContents(10) <= "11111111";
  memoryContents(11) <= "11111011";
  
  flag := TRUE;
  
end if;

j := conv_integer(unsigned(Address));
if clk = '0' and MemRead = '1' and Address /= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
 ReadData <= memoryContents(j) & memoryContents(j+1) 
              & memoryContents(j+2) & memoryContents(j+3);
end if;
 
if clk = '1' and MemWrite = '1' and Address /= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
memoryContents(j)<=Writedata(31 downto 24);
memoryContents(j+1)<=Writedata(23 downto 16);
memoryContents(j+2)<=Writedata(15 downto 8);
memoryContents(j+3)<=Writedata(7 downto 0);
end if;

end process;
end behavioral;
