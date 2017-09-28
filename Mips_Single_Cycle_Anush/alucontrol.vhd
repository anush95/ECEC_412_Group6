library  ieee;
use  ieee.std_logic_1164.all;

entity ALUControl is
port(
	ALUOp: in std_logic_vector(1 downto 0); 
	funct: in std_logic_vector(5 downto 0); 
	aluctlout: out std_logic_vector(3 downto 0)
);
end ALUControl;

architecture behavioralALUControl of ALUControl is
   signal X, Y: std_logic;
   begin
	P1: process(ALUOp, funct)
	begin
	aluctlout(3) <= '0';
	aluctlout(0) <= ((funct(0) or funct(3)) and ALUop(1));
	aluctlout(1) <= (not ALUOp(1)) or (not funct(2));
	aluctlout(2) <= (funct(1) and ALUop(1)) or ALUOp(0);
	end process P1;
   end behavioralALUControl;