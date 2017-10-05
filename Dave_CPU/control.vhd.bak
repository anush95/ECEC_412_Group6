
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
port(Opcode : in std_logic_vector(5 downto 0);
     RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump : out std_logic;
     ALUOp : out std_logic_vector(1 downto 0));
end Control;

architecture Behavioral of Control is
begin
  process(Opcode)
    variable temp : std_logic_vector(9 downto 0);
     begin
                
       case Opcode is
        when "000000" =>
          temp := "100100010U";
        when "100011" =>
          temp := "010010110U";
        when "101011" =>
          temp := "U10001U00U";
        when "000100" =>
          temp := "U01000U01U";
        when "000010" =>
          temp := "UUUUUUUUU1";
        when others =>
          null;
        end case;
        
	RegDst <= temp(0);
	ALUSrc <= temp(1);
	ALUOp(1) <= temp(2);
	ALUOp(0) <= temp(3);
	MemRead <= temp(4);
	MemWrite <= temp(5);
	MemtoReg <= temp(6);
	RegWrite <= temp(7);
	Branch <= temp(8);
	Jump <= temp(9);
        
      end process;
    end Behavioral;

