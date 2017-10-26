library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity registers is
port(RR1, RR2, WR : in  std_logic_vector(4 downto 0);
     WD           : in  std_logic_vector(31 downto 0);
     RegWrite     : in  std_logic;
     RD1,RD2      : out std_logic_vector(31 downto 0));
end registers;

architecture behave of registers is
type array2d is array(0 to 31) of std_logic_vector(31 downto 0);
signal Register_contents:array2d;
begin

process(RR1, RR2, WR, WD)
variable temp_1,temp_2,temp_3:integer;
variable flag:boolean:=FALSE;
begin
	if flag=FALSE then
		Register_contents(0)<=(others=>'0');
		Register_contents(8)<="00000000000000000000000000000000";
		Register_contents(20)<="00000000000000000000000000001110";
		Register_contents(21)<="00000000000000000000000000000101";
		flag:=TRUE;
	end if;
	temp_1:=conv_integer(unsigned(RR1));
	temp_2:=conv_integer(unsigned(RR2));
	temp_3:=conv_integer(unsigned(WR));
	RD1<=Register_contents(temp_1);
	RD2<=Register_contents(temp_2);
        if RegWrite='1' and (temp_3 /= 0) then	
		Register_contents(temp_3) <= WD;
	end if;
    
end process;

end behave;