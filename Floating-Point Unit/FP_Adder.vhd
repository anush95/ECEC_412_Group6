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
begin
process(clk)
-- Floating Point A broken down
variable sign_a:std_logic;
variable exp_a:unsigned(7 downto 0);
variable fract_a:unsigned(24 downto 0);
-- Floating Point B broken down
variable sign_b:std_logic;
variable exp_b:unsigned(7 downto 0);
variable fract_b:unsigned(24 downto 0);

variable sign_result:std_logic := '0';
variable exp_result:unsigned(7 downto 0) := "00000000";
variable fract_result:unsigned(24 downto 0) := "0000000000000000000000000";
variable overflow_result:std_logic := '0';

variable align_counter:unsigned(7 downto 0) := "00000000";
begin

if clk'event and clk='1' then
sign_a := fp_a(31);
exp_a := unsigned(fp_a(30 downto 23));
fract_a := unsigned('0' & '1' & fp_a(22 downto 0));
sign_b := fp_b(31);
exp_b := unsigned(fp_b(30 downto 23));
fract_b := unsigned('0' & '1' & fp_b(22 downto 0));

if (exp_a < exp_b) then
  align_counter := (exp_b - exp_a);
  while (align_counter /= 0) loop
    fract_a := unsigned('0' & fract_a(24 downto 1));
    align_counter := (align_counter - 1);
  end loop;
  exp_result := exp_b;
elsif (exp_b < exp_a) then
  align_counter := (exp_a - exp_b);
  while(align_counter /= 0) loop
    fract_b := unsigned('0' & fract_b(24 downto 1));
    align_counter := (align_counter - 1);
  end loop;
  exp_result := exp_a;
else
  exp_result := exp_a;
end if;

if(sign_a = sign_b) then
  if sign_a = '1' then
    sign_result := '1';
  else
    sign_result := '0';
  end if;
elsif (sign_a = '1' and sign_b = '0') then
  if(fract_a < fract_b) then
    sign_result := '0';
  else
    sign_result := '1';
  end if;
elsif (sign_a = '0' and sign_b = '1') then
  if(fract_a < fract_b) then
    sign_result := '1';
  else
    sign_result := '0';
  end if;
end if;

fract_result := (fract_a + fract_b);

if(fract_result(24) ='1') then
  if(exp_result = 254) then
    overflow_result := '1';
  end if;

  fract_result := unsigned('0' & fract_result(24 downto 1));
  exp_result := exp_result + 1;
end if;

fp_result(31) <= sign_result;
fp_result(30 downto 23) <= std_logic_vector(exp_result);
fp_result(22 downto 0) <= std_logic_vector(fract_result(22 downto 0));
overflow <= overflow_result;

end if;
end process;
end beh;