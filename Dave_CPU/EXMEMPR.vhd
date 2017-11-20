library ieee;
use ieee.std_logic_1164.all;

entity EXMEMPR is
port(CLK:in std_logic;
     WBCTRLIN:in std_logic_vector(1 downto 0);
     MCTRLIN: in std_logic_vector(2 downto 0);
     MIN:in std_logic_vector(31 downto 0);
     ZIN:in std_logic;
     GIN,DIN:in std_logic_vector(31 downto 0);
     BIN:in std_logic_vector(4 downto 0);
     WBCTRLOUT:out std_logic_vector(1 downto 0);
     MCTRLOUT: out std_logic_vector(2 downto 0);
     MOUT:out std_logic_vector(31 downto 0);
     ZOUT:out std_logic;
     GOUT,DOUT:out std_logic_vector(31 downto 0);
     BOUT:out std_logic_vector(4 downto 0));
end EXMEMPR;

architecture beh of EXMEMPR is
signal WBCTRLData: std_logic_vector(1 downto 0);
signal MCTRLData: std_logic_vector(2 downto 0);
signal MData: std_logic_vector(31 downto 0);
signal ZData: std_logic;
signal GData, DData: std_logic_vector(31 downto 0);
signal BData: std_logic_vector(4 downto 0);
begin
	process(CLK)
	begin
		if CLK'event and CLK='1' then
			WBCTRLData <= WBCTRLIN;
			MCTRLData <= MCTRLIN;
			MData <= MIN;
			ZData <= ZIN;
			GData <= GIN;
			DData <= DIN;
			BData <= BIN;
		end if;
		if CLK'event and CLK='0' then
			WBCTRLOUT <= WBCTRLData;
			MCTRLOUT <= MCTRLData;
			MOUT <= MData;
			ZOUT <= ZData;
			GOUT <= GData;
			DOUT <= DData;
			BOUT <= BData;
		end if;
	end process;
end beh;