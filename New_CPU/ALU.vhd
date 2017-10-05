--------------------------------------------
-- ECEC 412 Modern Processor Design
-- MIPS Single Cycle CPU - ALU
-- Group 6
--------------------------------------------

library IEEE;
use ieee.std_logic_1164.all

entity ALU is
generic(n:natural:=32);
port(a,b:in std_logic_vector(n-1 downto 0);
	Oper: in std_logic_vector(3 downto 0);
	Result:buffer std_logic_vector(n-1 downto 0);
	Zero,Overflow:buffer std_logic);
end ALU;

architecture struct of ALU32 is 

component ALU1 is
port(a,b,less,CarryIn: in std_logic;
	Ainvert,Binvert,Op1,Op0: in std_logic;
	Result, CarryOut, set: out std_logic);
end component;

component NOR32 is
port(x:in std_logic_vector(31 downto 0);
	z:out std_logic;
end component;

signal Carry:std_logic_vector(0 to n);
signal ainvert, binvert: std_logic;
signal operation: std_logic_vector(1 downto 0);
signal Less: std_logic_vector(0 to n-1);
signal Set: std_logic;

begin
ainvert <= Oper(3);
binvert <= Oper(2);
operation <= Oper(1 downto 0);


