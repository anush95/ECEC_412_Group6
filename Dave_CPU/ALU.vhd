library IEEE;
use ieee.std_logic_1164.all;

entity ALU32 is
  generic( n: natural:= 32);
  port( a,b: in std_logic_vector(n-1 downto 0);
        Oper: in std_logic_vector(3 downto 0);
        Result:buffer std_logic_vector(n-1 downto 0);
        Zero:buffer std_logic;
        Overflow:out std_logic); 
end ALU32;

architecture beh of ALU32 is
  
signal CARRY:STD_LOGIC_VECTOR(n-2 downto 0);
signal set31, CarryO, set31_to_less0, ainvert, binvert: std_logic; -- 1 bit ainvert and binvert signals

signal slt_true : std_logic;
signal b0_temp : std_logic;

signal slt : std_logic_vector(31 downto 0);

signal LESS:STD_LOGIC_VECTOR(0 to n-1);
--signal SETInternal:STD_LOGIC

component ALU1bit is
  port( a,b,less,CarryIn: in std_logic;
        Ainvert, Binvert, Op1,Op0: in std_logic;
        Result, CarryOut,set: out std_logic);  
end component;

component NOR32 is
  port(x:in std_logic_vector(31 downto 0);
      z:out std_logic);
end component;

begin  
  
  ainvert <= Oper(3);
  binvert <= Oper(2);

  
  
  -- a,b,less,carryin,ainvert,binvert,op1,op0,result,carryout,set
  GEN1:      for i in 0 to n-1 generate
    --lsb
  GEN2:      if i=0 generate     
                gen1: ALU1bit port map(a(i),b(i),slt(i+1),Oper(2),ainvert,binvert,Oper(1),Oper(0),b0_temp,carry(i),slt_true);
             end generate GEN2;
        --middle
  GEN3:      if i>0 and i<n-1 generate
                gen2: ALU1bit port map(a(i),b(i),slt(i+1),carry(i-1),ainvert,binvert,Oper(1),Oper(0),Result(i),carry(i),slt(i)); 
             end generate GEN3;
        
        --msb
  GEN4:      if i=n-1 generate
                  gen3: ALU1bit port map(a(i),b(i),'0',carry(i-1),ainvert,binvert,Oper(1),Oper(0),Result(i),CarryO,slt(i)); 
             end generate GEN4;
  
  end generate GEN1;
  
  Overflow <= carry(n-2) xor CarryO;
  N1 : NOR32 port map(result,zero);
  
  
  Result(0) <= (slt_true and (oper(1) and oper(0))) or (b0_temp and (not (oper(1) and oper(0))));
  
end beh;