
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_ARITH.all;

entity shiftlogical is
port(x: in std_logic_vector(31 downto 0);
 shamt: in std_logic_vector(4 downto 0);
   dir: in std_logic;
     y: out std_logic_vector(31 downto 0));
end shiftlogical;

architecture beh of shiftlogical is
begin
process(dir)
variable shift : integer;
begin
shift := conv_integer(unsigned(shamt));
if(dir = '0') then --Left shift
    y(31 downto shift) <= x(31-shift downto 0);
    y(shift-1 downto 0) <= (others => '0');
elsif(dir = '1') then --Right shift
    y(31-shift downto 0) <= x(31 downto shift);
    y(31 downto 32-shift) <= (others => '0');
else --Always left shift
    y(31 downto shift) <= x(31-shift downto 0);
    y(shift - 1 downto 0) <= (others => '0');
end if;
end process;
end beh;
