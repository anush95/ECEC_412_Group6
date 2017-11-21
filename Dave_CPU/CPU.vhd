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
port(clk:in std_logic;
     AddressIn, InstructionIn:in std_logic_vector(31 downto 0);
     AddressOut, InstructionOut:out std_logic_vector(31 downto 0));
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
     RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite: out std_logic;
     ALUOp: out std_logic_vector(1 downto 0));
end component;

component IDEXPR is 
port(clk, RegDst_in, ALUSrc_in, Branch_in, MemRead_in, MemWrite_in, RegWrite_in, MemToReg_in :in std_logic;
     ALUOp_in: in std_logic_vector(1 downto 0);
     Address_in, Instruction_in, ReadData1_in, ReadData2_in:in std_logic_vector(31 downto 0);
     RegDst_out, ALUSrc_out, Branch_out, MemRead_out, MemWrite_out, RegWrite_out, MemToReg_out: out std_logic;
     ALUOp_out: out std_logic_vector(1 downto 0);
     Address_out, Instruction_out, ReadData1_out, ReadData2_out: out std_logic_vector(31 downto 0));
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
port(clk, RegWrite_in, MemToReg_in, Branch_in, MemRead_in, MemWrite_in, Zero_in:in std_logic;
	WriteReg_in: in std_logic_vector(4 downto 0);
   	Address_in, ALURes_in, WriteData_in: in std_logic_vector(31 downto 0);
	RegWrite_out, MemToReg_out, Branch_out, MemRead_out, MemWrite_out, Zero_out: out std_logic;
	WriteReg_out: out std_logic_vector(4 downto 0);
	Address_out, ALURes_out, WriteData_out: out std_logic_vector(31 downto 0));
end component;

-- MEM/WB

component MemoryData is
port(WriteData: in std_logic_vector(31 downto 0);
     Address: in std_logic_vector(31 downto 0);
     clk, MemRead, MemWrite: in std_logic;
     ReadData: out std_logic_vector(31 downto 0));
end component;

component MEMWBPR is
port(clk, RegWrite_in, MemToReg_in: in std_logic;
	WriteReg_in: std_logic_vector(4 downto 0);
	ReadData_in, ALURes_in: in std_logic_vector(31 downto 0);
	RegWrite_out, MemToReg_out: out std_logic;
	WriteReg_out: out std_logic_vector(4 downto 0);
	ReadData_out, ALURes_out: out std_logic_vector(31 downto 0));
end component;

component ShiftLeftTwo is
port(x: in std_logic_vector(31 downto 0);
     y: out std_logic_vector(31 downto 0));
end component;

  -- Signals
  -- IF
  signal AddressIF, InstructionIF, PCIn, PCOut: std_logic_vector(31 downto 0) := X"00000000";
  -- ID
  signal ALUSrcID, BranchID, MemReadID, MemWriteID, MemtoRegID, RegDstID, RegWriteID: std_logic := '0';
  signal ALUOpID: std_logic_vector(1 downto 0) := "00";
  signal AddressID, InstructionID, ReadDataOneID, ReadDataTwoID: std_logic_vector(31 downto 0) := X"00000000";
  -- EX
  signal ALUSrcEX, BranchEX, MemReadEX, MemWriteEX, MemtoRegEX, RegDstEX, RegWriteEX, ZeroEX: std_logic := '0';
  signal ALUOpEX: std_logic_vector(1 downto 0) := "00";
  signal Operation: std_logic_vector(3 downto 0) := "0000";
  signal WriteRegisterEX: std_logic_vector(4 downto 0) := "00000";
  signal AddressEX, ALUOperand, ALUResultEX, InstructionEX, MaskedInstruction, ReadDataOneEX, ReadDataTwoEX: std_logic_vector(31 downto 0) := X"00000000";
  -- MEM
  signal PCSrc, BranchMEM, MemWriteMEM, MemReadMEM, MemtoRegMEM, RegWriteMEM, ZeroMEM: std_logic := '0';
  signal WriteRegisterMEM: std_logic_vector(4 downto 0) := "00000";
  signal AddressMEM, ALUResultMEM, BranchInstruction, ReadDataMEM, ShiftedInstruction, WriteDataMEM: std_logic_vector(31 downto 0) := X"00000000";
  -- WB
  signal MemtoRegWB, RegWriteWB: std_logic := '0';
  signal WriteRegisterWB: std_logic_vector(4 downto 0) := "00000";
  signal ALUResultWB, ReadDataWB, WriteRegisterData: std_logic_vector(31 downto 0) := X"00000000";

begin
  -- Components
  -- IF
  Mux32_0: Mux32 port map(AddressIF, AddressMEM, PCSrc, PCIn);
  PC_inst: PC port map(clk, PCIn, PCOut);
  Add_0: Adder port map(PCOut, X"00000004", AddressIF);
  InstructionMemory: InstMemory port map(PCOut, InstructionIF);
  IFIDRegister: IFIDPR port map(clk, AddressIF, InstructionIF, AddressID, InstructionID);
  -- ID
  Registers_inst: registers port map(InstructionID(25 downto 21), InstructionID(20 downto 16), WriteRegisterWB, WriteRegisterData, RegWriteWB, clk, ReadDataOneID, ReadDataTwoID);
  Control_inst: Control port map(InstructionID(31 downto 26), RegDstID, BranchID, MemReadID, MemtoRegID, MemWriteID, ALUSrcID, RegWriteID, ALUOpID);  
  IDEXRegister: IDEXPR port map(clk, RegDstID, ALUSrcID, BranchID, MemReadID, MemWriteID, RegWriteID, MemtoRegID, ALUOpID, AddressID, InstructionID, ReadDataOneID, ReadDataTwoID,
				     RegDstEX, ALUSrcEX, BranchEX, MemReadEX, MemWriteEX, RegWriteEX, MemtoRegEX, ALUOpEX, AddressEX, InstructionEX, ReadDataOneEX, ReadDataTwoEX);
  -- EX
  ALUControl_inst: ALUControl port map(ALUOpEX, InstructionEX(5 downto 0), Operation);
  MaskedInstruction <= InstructionEX and X"0000FFFF";
  ShiftLeft2: ShiftLeftTwo port map(MaskedInstruction, ShiftedInstruction);
  Add_1: Adder port map(AddressEX, ShiftedInstruction, BranchInstruction);
  Mux32_1: Mux32 port map(ReadDataTwoEX, MaskedInstruction, ALUSrcEX, ALUOperand);
  ALU_inst: ALU32 port map(ReadDataOneEX, ALUOperand, Operation, ALUResultEX, ZeroEX);
  Mux5_inst: Mux5 port map(InstructionEX(20 downto 16), InstructionEX(15 downto 11), RegDstEX, WriteRegisterEX);
  EXMEMRegister: EXMEMPR port map(clk, RegWriteEX, MemtoRegEX, BranchEX, MemReadEX, MemWriteEx, ZeroEX, WriteRegisterEX, AddressEx, ALUResultEX, ReadDataTwoEX,
				       RegWriteMEM, MemtoRegMEM, BranchMEM, MemReadMEM, MemWriteMEM, ZeroMEM, WriteRegisterMEM, AddressMEM, ALUResultMEM, WriteDataMEM);
  -- MEM
  PCSrc <= BranchMEM and ZeroMEM;
  DataMemory: MemoryData port map(WriteDataMEM, ALUResultMEM, clk, MemReadMEM, MemWriteMEM, ReadDataMEM);
  MEMWBRegister: MEMWBPR port map(clk, RegWriteMEM, MemtoRegMEM, WriteRegisterMEM, ReadDataMEM, ALUResultMEM, RegWriteWB, MemToRegWB, WriteRegisterWB, ReadDataWB, ALUResultWB);
  -- WB
  Mux32_2: Mux32 port map(ALUResultWB, ReadDataWB, MemtoRegWB, WriteRegisterData);
end struc;