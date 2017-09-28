library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Instruction is 
port (
         PC: in std_logic_vector(31 downto 0);
         INST: out std_logic_vector(31 downto 0);
	 ck: in std_logic
	);
end Instruction;

architecture behav of Instruction is 
type inst_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
signal inst_mem:inst_array := (
    X"22000000",
    X"22200030", 
    X"2240000A",
    X"22600014",
    X"22800000",
    X"22A00001",
    X"22C00003",
    X"011394A2",
    X"0120422A",
    X"1135004C", 
    X"01129CE0",
    X"0130A520", 
    X"8D290000",
    X"01294220",
    X"0252AD62",
    X"0273B5A2",
    X"0294AD60",
    X"10000020",
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

P1: process(pc, ck)
begin
	if ck = '0' and ck'event then
		INST <= inst_mem(conv_integer(PC(31 downto 2)));
	end if;
	
end process P1;
end behav;