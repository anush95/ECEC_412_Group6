library ieee;
use ieee.std_logic_1164.all;

entity IDEXPR is
port(CLK:in std_logic;
     WBCTRLIN:in std_logic_vector(1 downto 0);
     MCTRLIN:in std_logic_vector(2 downto 0);
     EXCTRLIN:in std_logic_vector(3 downto 0);
     LIN,CIN,DIN,EIN:in std_logic_vector(31 downto 0);
     RTIN,RDIN:in std_logic_vector(4 downto 0);
     WBCTRLOUT:out std_logic_vector(1 downto 0);
     MCTRLOUT:out std_logic_vector(2 downto 0);
     EXCTRLOUT:out std_logic_vector(3 downto 0);
     LOUT,COUT,DOUT,EOUT:out std_logic_vector(31 downto 0);
     RTOUT,RDOUT:out std_logic_vector(4 downto 0));
end IDEXPR;

architecture beh of IDEXPR is
signal WBCTRLData: std_logic_vector(1 downto 0);
signal MCTRLData: std_logic_vector(2 downto 0);
signal EXCTRLData: std_logic_vector(3 downto 0);
signal LData, CData, DData, EData: std_logic_vector(31 downto 0);
signal RTData, RDData: std_logic_vector(4 downto 0);
begin
	process(CLK)
	begin
		if CLK'event and CLK='1' then
			WBCTRLData <= WBCTRLIN;
			MCTRLData <= MCTRLIN;
			EXCTRLData <= EXCTRLIN;
			LData <= LIN;
			CData <= CIN;
			DData <= DIN;
			EData <= EIN;
			RTData <= RTIN;
			RDData <= RDIN;
		end if;
		if CLK'event and CLK='0' then
			WBCTRLOUT <= WBCTRLData;
			MCTRLOUT <= MCTRLData;
			EXCTRLOUT <= EXCTRLData;
			LOUT <= LData;
			COUT <= CData;
			DOUT <= DData;
			EOUT <= EData;
			RTOUT <= RTData;
			RDOUT <= RDData;
		end if;
	end process;
end beh;