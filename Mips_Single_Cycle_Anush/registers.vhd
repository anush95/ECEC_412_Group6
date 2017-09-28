library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity registers is
 port (
	CLK,RW:in STD_LOGIC;
	R1,R2,WR:in STD_LOGIC_VECTOR (4 downto 0); 
	Data:in STD_LOGIC_VECTOR (31 downto 0);
	RegData1,RegData2:out STD_LOGIC_VECTOR (31 downto 0)
);
end registers;

architecture behavioral of registers is
	type reg is array(0 to 31) of std_logic_vector(31 downto 0);
	signal regData:reg;


	-- set of registers for intialization 
	constant zero:integer:=0;
	constant t0:integer:=8;
	constant s4:integer:=20;
	constant s5:integer:=21;

	begin
	P1:process(CLK,RW,Data,R1,R2,WR)

		variable RS1:integer;
		variable RS2:integer;
		variable WI:integer;
		variable init:boolean:=true;

		begin
			if (init) then
			  -- init regs on startup
			  init := false;
			  regData(zero) <= X"00000000";
			  regData(t0) <= X"00000000";
			  regData(s4) <= (3=>'1',2=>'1',1=>'1',0=>'1',others=>'0');
			  regData(s5) <= (2=>'1',others=>'0');
			end if;


			-- Set register signals
			RS1:=conv_integer(unsigned(R1));
			RS2:=conv_integer(unsigned(R2));
			WI:=conv_integer(unsigned(WR));

			if CLK='1' and CLK'event then
			if RW='1' then
			  if ( not(WI=zero) ) then 
				regData(WI)<=Data;
			  end if;
			end if;
			end if;

			if CLK='0' and CLK'event then
				RegData1<=regData(RS1);
				RegData2<=regData(RS2);
			end if;

		end process P1;

end behavioral;


