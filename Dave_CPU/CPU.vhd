library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
  port(clk:in std_logic; Overflow:out std_logic);
end CPU;

architecture struc of CPU is

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

component AND2 is
port(x,y: in std_logic;
     z: out std_logic);
end component;

component Control is
port(Opcode: in std_logic_vector(5 downto 0);
     RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump: out std_logic;
     ALUOp: out std_logic_vector(1 downto 0));
end component;

component MemoryData is
port(WriteData: in std_logic_vector(31 downto 0);
     Address: in std_logic_vector(31 downto 0);
     clk, MemRead, MemWrite: in std_logic;
     ReadData: out std_logic_vector(31 downto 0));
end component;

component InstMemory is
port(Address: in std_logic_vector(31 downto 0);
     ReadData: out std_logic_vector(31 downto 0));
end component;

component Mux5 is
port(x,y: in std_logic_vector(4 downto 0);
     sel: in std_logic;
     z: out std_logic_vector(4 downto 0));
end component;

component MUX32 is
port(x,y: in std_logic_vector(31 downto 0);
     sel: in std_logic;
     z: out std_logic_vector(31 downto 0));
end component;

component registers is
port(RR1, RR2, WR: in std_logic_vector(4 downto 0);
     WD: in std_logic_vector(31 downto 0);
     RegWrite,ck: in std_logic;
     RD1, RD2: out std_logic_vector(31 downto 0));
end component;

component ShiftLeftTwoJump is
port(x: in std_logic_vector(25 downto 0);
     y: in std_logic_vector(3 downto 0);
     z: out std_logic_vector(31 downto 0));
end component;

component ShiftLeftTwo is
port(x: in std_logic_vector(31 downto 0);
     y: out std_logic_vector(31 downto 0));
end component;

component SignExtend is
port(x: in std_logic_vector(15 downto 0);
     y: out std_logic_vector(31 downto 0));
end component;

component PC is
port(clk: in std_logic;
     AddressIn: std_logic_vector(31 downto 0);
     AddressOut: out std_logic_vector(31 downto 0));
end component;

-- Wires
signal A,C,D,E,F,G,H,J,K,L,M,N,O,P,Q: std_logic_vector(31 downto 0);
signal B: std_logic_vector(4 downto 0);
signal R: std_logic;

-- Instruction
signal Instruction: std_logic_vector(31 downto 0);

-- ALU Control Signal
signal Operation: std_logic_vector(3 downto 0);

-- Control lines
signal RegDst, Branch, MemRead, MemtoReg,MemWrite,ALUSrc, RegWrite,Jump, Zero: std_logic;
signal ALUOp: std_logic_vector(1 downto 0);

-- PC Incrementer signal
signal four: std_logic_vector(31 downto 0) := "00000000000000000000000000000100";

begin

PC32: PC port map(clk,P,A);
IM: InstMemory port map(A, Instruction);
Control0: Control port map(Instruction(31 downto 26), RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump, ALUOp);
ALUControl0: ALUControl port map(ALUOp, Instruction(5 downto 0), Operation);
Mux50: MUX5 port map(Instruction(20 downto 16), Instruction(15 downto 11), RegDst, B);
Reg: registers port map(Instruction(25 downto 21), Instruction(20 downto 16), B, J, RegWrite, clk, C, D);
SignExt: SignExtend port map(Instruction(15 downto 0), E);
Mux320: MUX32 port map(D, E, ALUSrc, F);
ALU0: ALU32 port map(C, F, Operation, G, Zero,open);
DM: MemoryData port map(D, G, clk, MemRead, MemWrite, H);
Mux321: MUX32 port map(G, H, MemtoReg, J);
ADD4: ALU32 port map(A, four, "0010", L, open, open);
SLLJ: ShiftLeftTwoJump port map(Instruction(25 downto 0), L(31 downto 28), Q);
SLLALU: ShiftLeftTwo port map(E, K);
ADD: ALU32 port map(L, K, "0010", M, open, open);
AND0: AND2 port map(Branch, Zero, R);
MuxPC0: MUX32 port map(L, M, R, N);
MUXPC1: MUX32 port map(N, Q, Jump, P);

end struc;