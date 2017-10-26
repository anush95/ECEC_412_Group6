library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NOR32 is
port(x : in  std_logic_vector(31 downto 0);
     z : out std_logic);
end NOR32;

architecture behave of NOR32 is
begin
process(x)
variable i : integer;
begin
  i := 1;
  while x(i) = '0' and i < 31 loop
    i := i + 1;
  end loop;
  if i = 31 then
     z <= not x(i);
  else
     z <= '0';
  end if;
end process;
end behave;
