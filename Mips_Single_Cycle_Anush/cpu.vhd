library ieee;
use ieee.std_logic_1164.all;

entity CPU is
	port(clk: in std_logic);
end CPU;

architecture struc of CPU is
	
	-- defining all the components
	component ALU is
		generic (width: integer:=32);
		port ( 
	    	       CLK:in std_logic;
		       A: in std_logic_vector((width-1) downto 0);
 		       B: in std_logic_vector((width-1) downto 0);
 		       Sel: in std_logic_vector(3 downto 0);
 		       Y: out std_logic_vector((width-1) downto 0);
		       Z: out std_logic
		     );
	end component;

	component ShiftLeft2 is
		generic (n:natural:=32);
 		port(
			X:in std_logic_vector(n-1 downto 0);
     	  		Y:out std_logic_vector(n-1 downto 0)
		);
	end component;

	component Control is
		port(
        		opcode: in std_logic_vector(5 downto 0);
        		RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite: out std_logic;
        		ALUOp: out std_logic_vector(1 downto 0)
		);
	end component;

	component ALUControl is
		port(
			ALUOp: in std_logic_vector(1 downto 0);
        		funct: in std_logic_vector(5 downto 0);
        		aluctlout: out std_logic_vector(3 downto 0)
		);
	end component;

	component Mux is
		Port ( 
			SEL : in  STD_LOGIC;                      
       			A   : in  STD_LOGIC_VECTOR (31 downto 0); 
       			B   : in  STD_LOGIC_VECTOR (31 downto 0); 
       			X   : out STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component Mux5 is
		Port ( 
			SEL : in  STD_LOGIC;                      
       			A   : in  STD_LOGIC_VECTOR (4 downto 0); 
       			B   : in  STD_LOGIC_VECTOR (4 downto 0); 
       			X   : out STD_LOGIC_VECTOR (4 downto 0)
		);
	end component;

	component memory is
		port (
                	address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
                	MemWrite, MemRead,ck: in STD_LOGIC;
                	read_data: out STD_LOGIC_VECTOR (31 downto 0)
        	);
	end component;

	component and2 is
		Port (
           		A   : in  STD_LOGIC;
           		B   : in  STD_LOGIC;
           		C   : out STD_LOGIC
		);
	end component;

	component registers is
		port (
			CLK,RW:in STD_LOGIC;
	       		R1,R2,WR:in STD_LOGIC_VECTOR (4 downto 0);
	       		Data:in STD_LOGIC_VECTOR (31 downto 0);
	                RegData1,RegData2:out STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;

	component Instruction is
		port (
	        	PC: in std_logic_vector(31 downto 0);
			INST: out std_logic_vector(31 downto 0);
		        ck: in std_logic
	        );
	end component;

	component SignExtended is
		generic (n:natural:=16);
		port(
			X:in std_logic_vector(n-1 downto 0);
      	 		Y:out std_logic_vector(n*2-1 downto 0)
		);
	end component;	

	component PC is
		generic (n:natural:=32);
		port(
			CLK:in std_logic;
		  	AddressIn:in std_logic_vector(n-1 downto 0);
		  	AddressOut:out std_logic_vector(n-1 downto 0));
	end component;

-- define internal signals	
	signal pc_1: std_logic_vector(31 downto 0) ;
	
	signal pc_count: std_logic_vector(31 downto 0) := X"00000004";
	signal inst: std_logic_vector(31 downto 0);
	signal write_reg: std_logic_vector(4 downto 0);
	signal readt1: std_logic_vector(31 downto 0);
	signal readt2: std_logic_vector(31 downto 0);
	signal ext: std_logic_vector(31 downto 0);
	signal aluctl: std_logic_vector(3 downto 0);
	signal aluin: std_logic_vector(31 downto 0);
	signal alures: std_logic_vector(31 downto 0);
	signal memdata: std_logic_vector(31 downto 0);
	signal writedata: std_logic_vector(31 downto 0) := X"00000000";
	signal RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, BranchAnd, zero, notUsed: std_logic;
	signal ALUOp: std_logic_vector(1 downto 0);
	signal Branch_ALU, JumpAddress, ALU_4, PC_ALU_MUX, JumpMUX, SignShift, add_with: std_logic_vector(31 downto 0);
	signal shift_28: std_logic_vector(27 downto 0);
	
	-- defining the internal workings
	begin
	-- run PC
	PCinit: PC port map(clk,ALU_4,pc_1);
	-- read isntruction from memory
	IM: Instruction port map(pc_1, inst, clk);
	
	
	-- update pc
	PCA: ALU port map(clk,pc_1, pc_count, "0010", ALU_4, notUsed);

	-- Control block
	CTL: Control port map(inst(31 downto 26), RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
	
	-- Decide what goes in write
	MU1: Mux5 port map(RegDst, inst(15 downto 11), inst(20 downto 16), write_reg);

	-- Fill registers
	Reg: registers port map(clk, RegWrite, inst(25 downto 21), inst(20 downto 16), write_reg, writedata, readt1, readt2);
	
	-- ALU control
	ALUC: ALUControl port map(ALUOp, inst(5 downto 0), aluctl);
	
	-- SignExt
	SignE: SignExtended port map(inst(15 downto 0), ext);
	
	-- ALU input Mux
	MU2: Mux port map(ALUSrc, ext, readt2, aluin);

	-- ALU operation
	ALU1: ALU port map(clk,readt1, aluin, aluctl, alures, zero);

	-- Memory operation
	Mem: memory port map(alures, readt2, MemWrite, MemRead, clk, memdata);

	-- Memory out mux
	Mu3: Mux port map(MemToReg, memdata, alures, writedata);

	-- Shift2
	SL2: shift_28 <= inst(25 downto 0)& "00";
	
	-- Concat with 4 of mostsig bit in pc
	JumpAddress <= pc_1(31) & pc_1(31) & pc_1(31) & pc_1(31) & shift_28;

	-- Shift branch given branch by 2
	SignShift <= ext(29 downto 0) & "00";

	-- Add branch 
	ALUB: ALU port map(clk,ALU_4, SignShift, "0010", Branch_ALU, notUsed);

	-- Branch And
	A1: and2 port map(zero, Branch, BranchAnd);

	-- PC+4, Branch Mux
	Mu4: Mux port map(BranchAnd, Branch_ALU, ALU_4, PC_ALU_MUX);

	-- Jump Mux
	Mu5: Mux port map(Jump, JumpAddress, PC_ALU_MUX, pc_1);
end struc;