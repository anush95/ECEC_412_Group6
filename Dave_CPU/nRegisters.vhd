library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity registers is
  port(RR1,RR2,WR:in std_logic_vector(4 downto 0);
       WD:in std_logic_vector(31 downto 0);
       RegWrite:in std_logic;
       RD1,RD2:out std_logic_vector(31 downto 0));
end registers;

architecture behavior of registers is
 type mem_array is array(0 to 31) of std_logic_vector(31 downto 0);
  signal reg_mem: mem_array := (
    X"00000000", --0
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000004", 
    X"00000004", --10 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"0000000E", --20
    X"00000005", 
    X"00000008", 
    X"00000003", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", 
    X"00000000", --30
    X"00000000"  
  );
  signal temp_data: std_logic_vector(31 downto 0) := X"00000000";
begin
  RD1 <= reg_mem(to_integer(unsigned(RR1)));
  RD2 <= reg_mem(to_integer(unsigned(RR2)));
  process(WD, WR, RegWrite)
  begin
    if RegWrite = '1' then
      reg_mem(to_integer(unsigned(WR))) <= WD;
    end if;
  end process;
end behavior;