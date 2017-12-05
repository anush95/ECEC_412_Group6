library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is
port(x: in std_logic_vector(31 downto 0);
	y: in std_logic_vector(31 downto 0);
	sum: out std_logic_vector(31 downto 0));
end Adder;

architecture Structural of Adder is
begin
sum <= std_logic_vector(unsigned(x) + unsigned(y));
end Structural;