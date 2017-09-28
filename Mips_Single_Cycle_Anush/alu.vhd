library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ALU is
generic (width: integer:=32);
port (	
	 CLK:in std_logic;
         A: in std_logic_vector((width-1) downto 0);
         B: in std_logic_vector((width-1) downto 0);
         Sel: in std_logic_vector(3 downto 0);
         Y: out std_logic_vector((width-1) downto 0);
         Z: out std_logic
);
end ALU;

architecture behv of ALU is
signal I: std_logic_vector(31 downto 0);
begin
 process(A,B,Sel,CLK)
 begin
 if CLK='0' and CLK'event then
   case Sel is
     when "0000" =>
       Y <= A and B;
       I <= A and B;
       if (I = (I'range => '0')) then
		Z <= '0';
	else
		Z <= '1';
	end if;
     when "0001" =>
	Y <= A or B;
	I <= A or B;
	if (I = (I'range => '0')) then	
		Z <= '0';
	else
		Z <= '1';
	end if;
     when "0010" =>
	Y <= A + B;
	I <= A + B;
	if (I = (I'range => '0')) then
		Z <= '0';
	else
		Z <= '1';
	end if;
     when "0110" =>
	Y <= A - B;
	I <= A - B;
	if (I = (I'range => '0')) then
		Z <= '0';
	else
		Z <= '1';
	end if;
     when "1100" =>
	Y <= A nor B;
	I <= A nor B;
	if (I = (I'range => '0')) then
		Z <= '0';
	else
		Z <= '1';
	end if;
     when "0111" =>
	if (A < B) then
		Y <= X"00000001";
	else
		Y <= X"00000000";
	end if;
     when others =>
       Y <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
   end case;
 end if;
end process;

end behv;