library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
  port(clk:in std_logic; Overflow:out std_logic);
end CPU;

architecture struc of CPU is
-- IF/ID
component PC is
port(clk: in std_logic;
     AddressIn: std_logic_vector(31 downto 0);
     AddressOut: out std_logic_vector(31 downto 0));
end component;

component Adder is
port(x: in std_logic_vector(31 downto 0);
	y: in std_logic_vector(31 downto 0);
	sum: out std_logic_vector(31 downto 0));
end component;

component InstMemory is
port(Address: in std_logic_vector(31 downto 0);
     ReadData: out std_logic_vector(31 downto 0));
end component;

component MUX32 is
port(x,y: in std_logic_vector(31 downto 0);
     sel: in std_logic;
     z: out std_logic_vector(31 downto 0));
end component;

component IFIDPR is
port(CLK: in std_logic;
	LIN, IIN: in std_logic_vector(31 downto 0);
	LOUT, IOUT: out std_logic_vector(31 downto 0));
end component;

-- ID/EX

component registers is
port(RR1, RR2, WR: in std_logic_vector(4 downto 0);
     WD: in std_logic_vector(31 downto 0);
     RegWrite,ck: in std_logic;
     RD1, RD2: out std_logic_vector(31 downto 0));
end component;

component Control is
port(Opcode: in std_logic_vector(5 downto 0);
     RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump: out std_logic;
     ALUOp: out std_logic_vector(1 downto 0));
end component;

component IDEXPR is 
port(CLK:in std_logic;
     WBCTRLIN:in std_logic_vector(1 downto 0);
     MCTRLIN:in std_logic_vector(2 downto 0);
     EXCTRLIN:in std_logic_vector(3 downto 0);
     LIN,CIN,DIN,EIN:in std_logic_vector(31 downto 0);
     RTIN,RDIN:in std_logic_vector(4 downto 0);
     WBCTRLOUT:out std_logic_vector(1 downto 0);
     MCTRLOUT:out std_logic_vector(2 downto 0);
     EXCTRLOUT:out std_logic_vector(3 downto 0);
     LOUT,COUT,DOUT,EOUT:out std_logic_vector(31 downto 0);
     RTOUT,RDOUT:out std_logic_vector(4 downto 0));
end component;

-- EX/MEM

component ALU32 is
generic(n: natural:= 32);
port(a,b: in std_logic_vector(n-1 downto 0);
     Oper: in std_logic_vector(3 downto 0);
     Result: buffer std_logic_vector(n-1 downto 0);
     Zero: buffer std_logic;
     Overflow: out std_logic);
end component;

component ALUControl is
port(ALUOp: in std_logic_vector(1 downto 0);
     Funct: in std_logic_vector(5 downto 0);
     Operation: out std_logic_vector(3 downto 0));
end component;

component Mux5 is
port(x,y: in std_logic_vector(4 downto 0);
     sel: in std_logic;
     z: out std_logic_vector(4 downto 0));
end component;

component EXMEMPR is
port(CLK:in std_logic;
     WBCTRLIN:in std_logic_vector(1 downto 0);
     MCTRLIN: in std_logic_vector(2 downto 0);
     MIN:in std_logic_vector(31 downto 0);
     ZIN:in std_logic;
     GIN,DIN:in std_logic_vector(31 downto 0);
     BIN:in std_logic_vector(4 downto 0);
     WBCTRLOUT:out std_logic_vector(1 downto 0);
     MCTRLOUT: out std_logic_vector(2 downto 0);
     MOUT:out std_logic_vector(31 downto 0);
     ZOUT:out std_logic;
     GOUT,DOUT:out std_logic_vector(31 downto 0);
     BOUT:out std_logic_vector(4 downto 0));
end component;

-- MEM/WB

component MemoryData is
port(WriteData: in std_logic_vector(31 downto 0);
     Address: in std_logic_vector(31 downto 0);
     MemRead, MemWrite: in std_logic;
     ReadData: out std_logic_vector(31 downto 0));
end component;

component MEMWBPR is
port(CLK: in std_logic;
	WBCTRLIN:in std_logic_vector(1 downto 0);
	HIN,DIN:in std_logic_vector(31 downto 0);
	BIN:in std_logic_vector(4 downto 0);
	WBCTRLOUT:out std_logic_vector(1 downto 0);
	HOUT,DOUT:out std_logic_vector(31 downto 0);
	BOUT:out std_logic_vector(4 downto 0));
end component;

component ShiftLeftTwo is
port(x: in std_logic_vector(31 downto 0);
     y: out std_logic_vector(31 downto 0));
end component;

begin

end struc;