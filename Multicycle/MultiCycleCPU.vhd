library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MulticycleCPU is
port(clk                : in  std_logic; 
     Overflow : out std_logic);
end MulticycleCPU;

architecture structure of MulticycleCPU is

component ALU is
generic(n : natural:=32);
port(   a, b            : in  std_logic_vector(n-1 downto 0);
	Oper            : in  std_logic_vector(3 downto 0);
	Result          : buffer std_logic_vector(n-1 downto 0);
	Zero	        : buffer std_logic;
        Overflow        : out std_logic);
end component;

component ALUControl is
port(   ALUOp           : in std_logic_vector(1 downto 0);
        Funct           : in std_logic_vector(5 downto 0);
        Operation       : out std_logic_vector(3 downto 0));
end component;

component ALUOut is
port(   x               : in  std_logic_vector(31 downto 0);
        clk             : in  std_logic;
        y               : out std_logic_vector(31 downto 0));
end component;

component AND2 is
port(   x,y             : in  std_logic;
        z               : out std_logic);
end component;

component IR is
port(   x               : in  std_logic_vector(31 downto 0);
        clk, IRWrite    : in  std_logic;
        y               : out std_logic_vector(31 downto 0));
end component;

component MDR is
port(   x               : in  std_logic_vector(31 downto 0);
        clk             : in  std_logic;
        y               : out std_logic_vector(31 downto 0));
end component;

component Memory is
port(   WriteData       : in  std_logic_vector(31 downto 0);
        Address         : in  std_logic_vector(31 downto 0);
       MemRead, MemWrite : in  std_logic;
        ReadData        : out std_logic_vector(31 downto 0));
end component;

component MulticycleControl is
port(   Opcode          : in std_logic_vector(5 downto 0);
        clk             : in std_logic;
        RegDst,RegWrite,ALUSrcA,IRWrite,MemtoReg,MemWrite,MemRead,IorD,PCWrite,PCWriteCond:out std_logic;
        ALUSrcB,ALUOp,PCSource : out std_logic_vector(1 downto 0));
end component;

component MUX5 is
port (  sel             : in  std_logic;
	x,y             : in  std_logic_vector(4 downto 0);
        z               : out std_logic_vector(4 downto 0));
end component;

component MUX32 is
port (  sel             : in  std_logic;
	x, y            : in  std_logic_vector(31 downto 0);
        z               : out std_logic_vector(31 downto 0));
end component;

component MUX3Way is
port(   w, x, y        : in  std_logic_vector(31 downto 0);
        sel            : in  std_logic_vector(1 downto 0);
        z              : out std_logic_vector(31 downto 0));
end component;

component MUX4Way is
port(   v, w, x, y     : in  std_logic_vector(31 downto 0);
        sel            : in  std_logic_vector(1 downto 0);
        z              : out std_logic_vector(31 downto 0));
end component;

component NOR32 is
port(   x              : in std_logic_vector(31 downto 0);
	z              : out std_logic);
end component;

component OR2 is
port(   x, y           : in  std_logic;
        z              : out std_logic);
end component;

component PCMulticycle is
port(   clk, d         : in  std_logic;
        AddressIn      : in  std_logic_vector(31 downto 0);
        AddressOut     : out std_logic_vector(31 downto 0));
end component;

component RegA is
port(   x              : in  std_logic_vector(31 downto 0);
        clk            : in  std_logic;
        y              : out std_logic_vector(31 downto 0));
end component;

component RegB is
port(   x              : in  std_logic_vector(31 downto 0);
        clk            : in  std_logic;
        y              : out std_logic_vector(31 downto 0));
end component;

component registers is
port(   RR1, RR2, WR   : in  std_logic_vector(4 downto 0);
        WD             : in  std_logic_vector(31 downto 0);
        RegWrite       : in  std_logic;
        RD1,RD2        : out std_logic_vector(31 downto 0));
end component;

component ShiftLeftTwo is
port(   x              : in std_logic_vector(31 downto 0);
        y              : out std_logic_vector(31 downto 0));
end component;

component ShiftLeftTwoJump is
port(   x              : in  std_logic_vector(25 downto 0);
        y              : in  std_logic_vector(3 downto 0);
        z              : out std_logic_vector(31 downto 0));
end component;

component SignExtend is
port(   x              : in std_logic_vector(15 downto 0);y:out std_logic_vector(31 downto 0));
end component;

-- Signals
signal C,E,F,G,H,I,J,L,M,N,P,Q,R,S,T,U,V : std_logic_vector(31 downto 0);
signal D,W : std_logic;
signal K : std_logic_vector(4 downto 0);

-- 32-bit instruction
signal Inst : std_logic_vector(31 downto 0);

-- ALU control output
signal Operation:STD_LOGIC_VECTOR(3 downto 0);

-- Control output
signal MUX4sel:STD_LOGIC_VECTOR(31 downto 0):="00000000000000000000000000000100";
signal RegDst,RegWrite,ALUSrcA,PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,Zero : std_logic;
signal PCSource, ALUOp, ALUSrcB : std_logic_vector(1 downto 0);


begin

-- Connecting components together
PCMC            :  PCMulticycle port map(clk,D,C,E);
MUX32_Address   :  MUX32 port map(IorD,E,F,G);
MemoryMC        :  Memory port map(H,G,MemRead,MemWrite,I);
InstructionReg  :  IR port map(I,clk,IRWrite,Inst);
MemoryDataReg   :  MDR port map(I,clk,J);
ControlMC       :  MulticycleControl port map(I(31 downto 26),clk,RegDst,RegWrite,ALUSrcA,IRWrite,MemtoReg,MemWrite,MemRead,IorD,PCWrite,PCWriteCond,ALUSrcB,ALUOp,PCSource);
MUX5_WriteReg   :  MUX5 port map(RegDst,Inst(20 downto 16),Inst(15 downto 11),K);
MUX32_WriteData :  MUX32 port map(MemtoReg,F,J,L);
RegMC           :  registers port map(Inst(25 downto 21),Inst(20 downto 16),K,L,RegWrite,M,N);
RegisterA       : RegA port map(M,clk,P);
RegisterB       : RegB port map(N,clk,H);
SignExtendMC    : SignExtend port map(Inst(15 downto 0),Q);
ShiftLeftMC     : ShiftLeftTwo port map(Q,R);
MUX32_a         : MUX32 port map(ALUSrcA,E,P,S);
MUX32x4_b       : MUX4Way port map(H,MUX4sel,Q,R,ALUSrcB,T);
ALUControlMC    : ALUControl port map(ALUOp,Inst(5 downto 0),Operation);
ALUMC           : ALU port map(S,T,Operation,U,Zero,Overflow);
ALU_Register    : ALUOut port map(U,clk,F);
ShiftLeft2Jump  : ShiftLeftTwoJump port map(Inst(25 downto 0),E(31 downto 28),V);
MUX32x3_final   : MUX3Way port map(U,F,V,PCSource,C);
ANDMC           : AND2 port map(Zero,PCWriteCond,W);
ORMC            : OR2 port map(W,PCWrite,D);

end structure;
