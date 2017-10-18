library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX3Way is
port(w,x,y:in std_logic_vector(31 downto 0);
     sel: in std_logic_vector(1 downto 0);
     z:out std_logic_vector(31 downto 0));
end MUX3Way;

architecture b of MUX3Way is
begin

process(w,x,y,sel)
begin
	case(sel) is
		when "00" => z <= w;
		when "01" => z <= x;
		when "10" => z <= y;
		when others => NULL;
	end case;
end process;

end b;
