library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity FP_ADDER is
port ( fp_a, fp_b: in std_logic_vector(31 downto 0);
	clk, operator: in std_logic;
	overflow: out std_logic;
	fp_result: out std_logic_vector(31 downto 0));
end FP_ADDER;

architecture beh of FP_ADDER is
-- Floating Point A broken down
signal sign_a:std_logic;
signal exp_a:std_logic_vector(7 downto 0);
signal fract_a:std_logic_vector(24 downto 0);
-- Floating Point B broken down
signal sign_b:std_logic;
signal exp_b:std_logic_vector(7 downto 0);
signal fract_b:std_logic_vector(24 downto 0);

signal exp_result:std_logic_vector(7 downto 0);
signal fract_result:std_logic_vector(24 downto 0);
signal overflow_result:std_logic := '0';

signal align_counter:std_logic_vector(7 downto 0);

begin

process(clk)
begin

if clk'event and clk='1' then
sign_a <= fp_a(31);
exp_a <= std_logic_vector(unsigned(fp_a(30 downto 23)));
fract_a <= std_logic_vector(unsigned('0' & '1' & fp_a(22 downto 0)));
sign_b <= fp_b(31);
exp_b <= std_logic_vector(unsigned(fp_b(30 downto 23)));
fract_b <= std_logic_vector(unsigned('0' & '1' & fp_b(22 downto 0)));



if (exp_a < exp_b) then
align_counter <= exp_b - exp_a;
while (align_counter /= 0) loop
fract_a <= std_logic_vector(unsigned('0' & fract_a(24 downto 1)));
align_counter <= align_counter -1;
end loop;
exp_result <= exp_b;
elsif (exp_b < exp_a) then
align_counter <= exp_a - exp_b;
while(align_counter /= 0) loop
fract_b <= std_logic_vector(unsigned('0' & fract_b(24 downto 1)));
align_counter <= align_counter -1;
end loop;
exp_result <= exp_a;
else
exp_result <= exp_a;
end if;

fract_result <= fract_a + fract_b;

if(fract_result(24) ='1') then
if(exp_result = 254) then
overflow_result <= '1';
end if;

fract_result <= std_logic_vector(unsigned('0' & fract_result(24 downto 1)));
exp_result <= exp_result + 1;
end if;

fp_result(31) <= '0';
fp_result(30 downto 23) <= exp_result;
fp_result(22 downto 0) <= fract_result(22 downto 0);
overflow <= overflow_result;

end if;
end process;
end beh;