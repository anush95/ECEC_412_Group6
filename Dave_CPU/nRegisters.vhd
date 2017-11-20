library ieee;
use ieee.std_logic_1164.all, ieee.std_logic_arith.all;

entity registers is
  port(RR1,RR2,WR:in std_logic_vector(4 downto 0);
       WD:in std_logic_vector(31 downto 0);
       RegWrite,ck:in std_logic;
       RD1,RD2:out std_logic_vector(31 downto 0));
end registers;

architecture behavior of registers is
type DontPlayYourself is array(0 to 31) of std_logic_vector(31 downto 0);
signal registerData : DontPlayYourself;
begin
process(ck)
variable JustKnow,AnotherOne,WinMore: integer;
variable flag : boolean := FALSE;
begin

if flag = FALSE then
  registerData(0) <= (others => '0');
  registerData(8) <= (others => '0');
  registerData(9)<="00000000000000000000000000000100";
  registerData(10)<="00000000000000000000000000000100";
  registerData(20)<="00000000000000000000000000001110";
  registerData(21)<="00000000000000000000000000000101";
  registerData(22)<="00000000000000000000000000001000";
  registerData(23)<="00000000000000000000000000000011";

  flag := TRUE;
end if;

JustKnow := conv_integer(unsigned(RR1));
AnotherOne := conv_integer(unsigned(RR2));
WinMore := conv_integer(unsigned(WR));

if ck = '0' then
  RD1 <= registerData(JustKnow);
  RD2 <= registerData(AnotherOne);
elsif ck = '1' and RegWrite = '1' and winmore /= 0 then
  registerData(WinMore) <= WD;
end if;

end process;
end behavior;