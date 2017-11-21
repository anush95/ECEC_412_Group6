library ieee;
use ieee.std_logic_1164.all;

entity EXMEMPR is
port(clk, RegWrite_in, MemToReg_in, Branch_in, MemRead_in, MemWrite_in, Zero_in:in std_logic;
	WriteReg_in: in std_logic_vector(4 downto 0);
   	Address_in, ALURes_in, WriteData_in: in std_logic_vector(31 downto 0);
	RegWrite_out, MemToReg_out, Branch_out, MemRead_out, MemWrite_out, Zero_out: out std_logic;
	WriteReg_out: out std_logic_vector(4 downto 0);
	Address_out, ALURes_out, WriteData_out: out std_logic_vector(31 downto 0));
end EXMEMPR;
-- Again not using the provided Entity Descriptions, they don't match my control

architecture beh of EXMEMPR is
signal RegWrite, MemToReg, Branch, MemRead, MemWrite, Zero: std_logic := '0';
signal WriteReg: std_logic_vector(4 downto 0) := "00000";
signal Address, ALURes, WriteData: std_logic_vector(31 downto 0) := X"00000000";
begin
  RegWrite_out <= RegWrite;
  MemToReg_out <= MemToReg;
  Branch_out <= Branch;
  MemRead_out <= MemRead;
  MemWrite_out <= MemWrite;
  Zero_out <= Zero;
  WriteReg_out <= WriteReg;
  Address_out <= Address;
  ALURes_out <= ALURes;
  WriteData_out <= WriteData;
process(clk)
begin
  if rising_edge(clk) then
    RegWrite_out <= RegWrite_in;
    MemToReg_out <= MemToReg_in;
    Branch_out <= Branch_in;
    MemRead_out <= MemRead_in;
    MemWrite_out <= MemWrite_in;
    Zero_out <= Zero_in;
    WriteReg_out <= WriteReg_in;
    Address_out <= Address_in;
    ALURes_out <= ALURes_in;
    WriteData_out <= WriteData_in;
  end if;
end process;
end beh;