library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4Way is
port(v,w,x,y:in std_logic_vector(31 downto 0);
     sel: in std_logic_vector(1 downto 0);
     z:out std_logic_vector(31 downto 0));
end MUX4Way;

architecture beh of MUX4Way is
begin
	process(sel, v, w, x, y)
	begin
		case(sel) is
			when "00" => z <= v;
			when "01" => z <= w;
			when "10" => z <= x;
			when "11" => z <= y;
			when others => NULL;
		end case;
	end process;
end beh;