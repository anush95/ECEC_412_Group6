library  ieee;
use  ieee.std_logic_1164.all;

entity Control is
port(
	opcode: in std_logic_vector(5 downto 0);
	RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite: out std_logic;
	ALUOp: out std_logic_vector(1 downto 0)
);
end Control;

architecture behavioralControl of Control is
	signal rt, lw, sw, beq: std_logic;
   begin
	P1:process(opcode)
	begin
	rt <= ((not opcode(0)) and (not opcode(1)) and (not opcode(2)) and (not opcode(3)) and (not opcode(4)) and (not opcode(5)));
	lw <= ((opcode(0)) and (opcode(1)) and (not opcode(2)) and (not opcode(3)) and (not opcode(4)) and (opcode(5)));
	sw <= ((opcode(0)) and (opcode(1)) and (not opcode(2)) and (opcode(3))  and (not opcode(4)) and (opcode(5)));
	beq <= ((not opcode(0)) and (not opcode(1)) and (opcode(2)) and (not opcode(3)) and (not opcode(4)) and (not opcode(5)));
	
	RegDst <= ((not opcode(0)) and (not opcode(1)) and (not opcode(2)) and (not opcode(3)) and (not opcode(4)) and (not opcode(5))); --rt
	AluSrc <= ((opcode(0)) and (opcode(1)) and (not opcode(2)) and (not opcode(3)) and (not opcode(4)) and (opcode(5))) or ((opcode(0)) and (opcode(1)) and (not opcode(2)) and (opcode(3))  and (not opcode(4)) and (opcode(5))); -- lw or sw
	MemtoReg <= ((opcode(0)) and (opcode(1)) and (not opcode(2)) and (not opcode(3)) and (not opcode(4)) and (opcode(5))); -- lw
	RegWrite <= ((not opcode(0)) and (not opcode(1)) and (not opcode(2)) and (not opcode(3)) and (not opcode(4)) and (not opcode(5))) or ((opcode(0)) and (opcode(1)) and (not opcode(2)) and (not opcode(3)) and (not opcode(4)) and (opcode(5))); --rt or lw
	MemRead <= ((opcode(0)) and (opcode(1)) and (not opcode(2)) and (not opcode(3)) and (not opcode(4)) and (opcode(5))); --lw -- lw
	MemWrite <= ((opcode(0)) and (opcode(1)) and (not opcode(2)) and (opcode(3))  and (not opcode(4)) and (opcode(5))); --sw
	Branch <= (not opcode(0)) and (not opcode(1)) and (opcode(2)) and (not opcode(3)) and (not opcode(4)) and (not opcode(5)); -- beq
	ALUOp(1) <= ((not opcode(0)) and (not opcode(1)) and (not opcode(2)) and (not opcode(3)) and (not opcode(4)) and (not opcode(5))); -- rt
	ALUOp(0) <= ((not opcode(0)) and (not opcode(1)) and (opcode(2)) and (not opcode(3)) and (not opcode(4)) and (not opcode(5))); --beq
	
	Jump <= (not opcode(0)) and (opcode(1)) and (not opcode(2)) and (not opcode(3)) and (not opcode(4)) and (not opcode(5));
	end process P1;
end behavioralControl;