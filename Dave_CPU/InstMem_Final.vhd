library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity InstMemory is
port(Address:in std_logic_vector(31 downto 0);  
     ReadData:out std_logic_vector(31 downto 0));
end InstMemory;

architecture beh of InstMemory is
type memoryArray is array(0 to 31) of std_logic_vector(7 downto 0);
signal memContents:memoryArray;

begin


process
variable addint: integer;
variable flag: Boolean := false;
begin
  if flag = false then
 -- lw $s0,0($t0)
  memcontents(0)<="10001101";
    memcontents(1)<="00010000";
    memcontents(2)<="00000000";
    memcontents(3)<="00000000";
    -- lw $s1,4($t0)
    memcontents(4)<="10001101";
  memcontents(5)<="00010001";
  memcontents(6)<="00000000";
  memcontents(7)<="00000100";
-- slt $t1,$s0,$s1

memcontents(8)<="00000010";
    memcontents(9)<="00010001";
    memcontents(10)<="01001000";
    memcontents(11)<="00101010";

  -- beq $t1,$zero,L
memcontents(12)<="00010001";
    memcontents(13)<="00100000";
    memcontents(14)<="00000000";
    memcontents(15)<="00000010";
    -- add $s3,$s4,$s5
    memcontents(16)<="00000010";
  memcontents(17)<="10010101";
  memcontents(18)<="10011000";
  memcontents(19)<="00100000";
  -- j exit
   memcontents(20)<="00001000";
    memcontents(21)<="00000000";
    memcontents(22)<="00000000";
    memcontents(23)<="00000111";
    -- sub $s3,$s4,$s5
    memcontents(24)<="00000010";
  memcontents(25)<="10010101";
  memcontents(26)<="10011000";
  memcontents(27)<="00100010";
  --exit: sw $s3,8($t0)
memcontents(28)<="10101101";
    memcontents(29)<="00010011";
    memcontents(30)<="00000000";
    memcontents(31)<="00001000";

 flag := true;
 end if;

if flag= true and (conv_integer(unsigned(address))<32) then
wait for 0 ns;
addint := conv_integer(unsigned(Address));
ReadData <= memcontents(addint)&memcontents(addint+1)&memcontents(addint+2)&memcontents(addint+3);
end if;   
wait on address;       
end process;

end beh;

