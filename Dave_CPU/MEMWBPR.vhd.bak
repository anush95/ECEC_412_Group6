library ieee;
use ieee.std_logic_1164.all;

entity MEMWBPR is
port(clk, RegWrite_in, MemToReg_in: in std_logic;
	WriteReg_in: std_logic_vector(4 downto 0);
	ReadData_in, ALURes_in: in std_logic_vector(31 downto 0);
	RegWrite_out, MemToReg_out: out std_logic;
	WriteReg_out: out std_logic_vector(4 downto 0);
	ReadData_out, ALURes_out: out std_logic_vector(31 downto 0));
end MEMWBPR;
-- Again not using provided entity due to not matching up nicely with my control
architecture beh of MEMWBPR is
signal RegWrite, MemToReg: std_logic := '0';
signal WriteReg: std_logic_vector(4 downto 0) := "00000";
signal ReadData, ALURes: std_logic_vector(31 downto 0) := X"00000000";
begin
  RegWrite_out <= RegWrite;
  MemToReg_out <= MemToReg;
  WriteReg_out <= WriteReg;
  ReadData_out <= ReadData;
  ALURes_out <= ALURes;
process(clk)
begin
  if rising_edge(clk) then
    RegWrite_out <= RegWrite_in;
    MemToReg_out <= MemToReg_in;
    WriteReg_out <= WriteReg_in;
    ReadData_out <= ReadData_in;
    ALURes_out <= ALURes_in;
  end if;
end process;
end beh;