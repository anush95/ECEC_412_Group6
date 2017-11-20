library ieee;
use ieee.std_logic_1164.all;

entity MEMWBPR is
port(CLK: in std_logic;
	WBCTRLIN:in std_logic_vector(1 downto 0);
	HIN,DIN:in std_logic_vector(31 downto 0);
	BIN:in std_logic_vector(4 downto 0);
	WBCTRLOUT:out std_logic_vector(1 downto 0);
	HOUT,DOUT:out std_logic_vector(31 downto 0);
	BOUT:out std_logic_vector(4 downto 0));
end MEMWBPR;

architecture beh of MEMWBPR is
signal WBCTRLData: std_logic_vector(1 downto 0);
signal HData, DData: std_logic_vector(32 downto 0);
signal BData: std_logic_vector(4 downto 0);
begin
	process(CLK)
	begin
		if CLK'event and CLK='1' then
			WBCTRLData <= WBCTRLIN;
			HData <= HIN;
			DData <= DIN;
			BData <= BIN;
		end if;
		if CLK'event and CLK='0' then
			WBCTRLOUT <= WBCTRLData;
			HOUT <= HData;
			DOUT <= DData;
			BOUT <= BData;
		end if;
	end process;
end beh;