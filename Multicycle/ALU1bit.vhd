library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU1bit is
  port( a,b,less,CarryIn: in std_logic;
        Ainvert, Binvert, Op1,Op0: in std_logic;
        Result, CarryOut,set: out std_logic);  
end ALU1bit;

architecture behave of ALU1bit is
  begin
    process(a,b,less,CarryIn,Ainvert,Binvert,Op1,Op0)
      variable ALUControl: std_logic_vector(3 downto 0);
      begin
        ALUControl := Ainvert&Binvert&Op1&Op0;
        CarryOut <= '0';
        case ALUControl is
        when "0000" => --AND
          Result <= a and b;
        when "0001" => --OR
          Result <= a or b; 
        when "0010" => --Add
          Result <= a xor b xor CarryIn;
          CarryOut <= (a and b) or (a and CarryIn) or (b and CarryIn);
        when "0110" => --Subtract
          Result <= a xor (not b) xor CarryIn; 
          CarryOut <= (a and not b) or (a and CarryIn) or (not b and CarryIn);        
        when "0111" => --slt
          Result <= '0';
          set <= less xor ((not a) and (b));
          CarryOut <= less or ((not a) and (b));
        when "1100" => --NOR
          Result <= a nor b;
        when others =>
          Result <= 'X';
        end case;
      end process;
end behave;