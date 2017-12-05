library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Memory is
port(WriteData:in std_logic_vector(31 downto 0);
     Address:in std_logic_vector(31 downto 0);
     MemRead,MemWrite:in std_logic;
     ReadData:out std_logic_vector(31 downto 0));
end Memory;

architecture b of Memory is
type memoryArray is array(0 to 2**8-1) of std_logic_vector(7 downto 0);
signal Memory_Array: memoryArray;
begin

process(WriteData, Address, MemRead, MemWrite)
variable x : boolean := FALSE;
variable y : integer;
begin

--lw $s0, 40($t0)
Memory_Array(0) <= "10001101";
Memory_Array(1) <= "00010000";
Memory_Array(2) <= "00000000";
Memory_Array(3) <= "00101000";

--lw $s1, 44($t0)
Memory_Array(4) <= "10001100";
Memory_Array(5) <= "00010001";
Memory_Array(6) <= "00000000";
Memory_Array(7) <= "00101100";

--beq $s0, $s1, L
Memory_Array(8) <= "00010010";
Memory_Array(9) <= "00010001";
Memory_Array(10) <= "00000000";
Memory_Array(11) <= "00000010";

--add $s3, $s4, $s5
Memory_Array(12) <= "00000010";
Memory_Array(13) <= "10010101";
Memory_Array(14) <= "10011000";
Memory_Array(15) <= "00100000";

--j exit
Memory_Array(16) <= "00001000";
Memory_Array(17) <= "00000000";
Memory_Array(18) <= "00000000";
Memory_Array(19) <= "00000110";

--L: sub $s3, $s4, $s5
Memory_Array(20) <= "00000010";
Memory_Array(21) <= "10010101";
Memory_Array(22) <= "10011000";
Memory_Array(23) <= "00100010";

--exit: sw $s3, 48($t0)
Memory_Array(24) <= "10101101";
Memory_Array(25) <= "00010011";
Memory_Array(26) <= "00000000";
Memory_Array(27) <= "00110000";

if x = FALSE then
	Memory_Array(40) <= "00000000";
	Memory_Array(41) <= "00000000";
	Memory_Array(42) <= "00000000";
	Memory_Array(43) <= "00000100";

	Memory_Array(44) <= "00000000";
	Memory_Array(45) <= "00000000";
	Memory_Array(46) <= "00000000";
	Memory_Array(47) <= "00000100";
	x := TRUE;
end if;

if MemRead='1' and Address/="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
	y := conv_integer(unsigned(Address));
	ReadData <= Memory_Array(y) & Memory_Array(y+1) & Memory_Array(y+2) & Memory_Array(y+3);
elsif MemWrite='1' and Address/="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
	y:= conv_integer(unsigned(Address));
	Memory_Array(y) <= WriteData(31 downto 24);
	Memory_Array(y+1) <= WriteData(23 downto 16);
	Memory_Array(y+2) <= WriteData(15 downto 8);
	Memory_Array(y+3) <= WriteData(7 downto 0);
end if;

end process;

end b;