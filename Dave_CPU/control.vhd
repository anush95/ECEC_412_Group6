
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
port(Opcode : in std_logic_vector(5 downto 0);
     RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite: out std_logic;
     ALUOp : out std_logic_vector(1 downto 0));
end Control;

architecture Behavioral of Control is
begin
  process(Opcode)
    variable temp : std_logic_vector(9 downto 0);
     begin 
 	if Opcode="000000" then --R format
    		RegDst <= '1';
		Branch <= '0';
		MemRead <= '0';
		MemtoReg <= '0';
		MemWrite <= '0';
    		ALUSrc <= '0';
    		RegWrite <= '1';	
    		ALUOp <= "10";
  	elsif Opcode="100011" then -- lw
    		RegDst <= '0';
		Branch <= '0';
		MemRead <= '1';
		MemtoReg <= '1';
		MemWrite <= '0';
    		ALUSrc <= '1';
    		RegWrite <= '1';	
    		ALUOp <= "00";
  	elsif Opcode="101011" then -- sw
    		RegDst <= '0';
		Branch <= '0';
		MemRead <= '0';
		MemtoReg <= '0';
		MemWrite <= '1';
    		ALUSrc <= '1';
    		RegWrite <= '0';	
    		ALUOp <= "00";
  	elsif Opcode="000100" then --beq
    		RegDst <= '0';
		Branch <= '1';
		MemRead <= '0';
		MemtoReg <= '0';
		MemWrite <= '0';
    		ALUSrc <= '0';
    		RegWrite <= '0';	
    		ALUOp <= "01";
  	elsif Opcode="000010" then --j
    		RegDst <= '0';
		Branch <= '1';
		MemRead <= '0';
		MemtoReg <= '0';
		MemWrite <= '0';
    		ALUSrc <= '0';
    		RegWrite <= '0';	
    		ALUOp <= "00";
	end if;
  end process;
end Behavioral;