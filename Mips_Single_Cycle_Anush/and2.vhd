library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity and2 is
Port ( 
           A   : in  STD_LOGIC;
           B   : in  STD_LOGIC;
           C   : out STD_LOGIC
);
end and2;

architecture df of and2 is
begin
c<=a and b;
end df;

