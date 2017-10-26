library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MulticycleControl_output is
port(Opcode:in std_logic_vector(5 downto 0);
     clk:in std_logic;
     RegDst,RegWrite,ALUSrcA,IRWrite,MemtoReg,MemWrite,MemRead,IorD,PCWrite,PCWriteCond:out std_logic;
     ALUSrcB,ALUOp,PCSource:out std_logic_vector(1 downto 0));
end MulticycleControl_output;

architecture behave of MulticycleControl_output is
begin

process(clk, Opcode)
type state is (state0,state1,state2,state3,state4,state5,state6,state7,state8,state9);
variable n_s : state := state0;
variable Control_output:std_logic_vector(15 downto 0);
begin

if clk='1' and clk'event then
    case n_s is
        when state0 => 
	    Control_output := "UU01UU101U010000";
            n_s := state1;
        when state1 =>
            Control_output := "UU0UUUUUUU1100UU";
            if (Opcode="100011") or (Opcode="101011") then
                n_s := state2; -- LW or SW
            elsif Opcode="000000" then
                n_s := state6; -- R-Type
            elsif Opcode="000100" then
                n_s := state8; -- BEQ
            elsif Opcode="000010" then
                n_s := state9; -- Jump
            end if;
        when state2 =>
            Control_output := "UU1UUUUUUU1000UU";
            if Opcode="100011" then
                n_s := state3; -- LW
            elsif Opcode="101011" then
                n_s := state5; -- SW
            end if;
        when state3 =>
            Control_output := "UUUUUU11UUUUUUUU";
            n_s := state4;
        when state4 =>
            Control_output := "01UU1UUUUUUUUUUU";
            n_s := state0;
        when state5 =>
            Control_output := "UUUUU1U1UUUUUUUU";
            n_s := state0;
        when state6 =>
            Control_output := "UU1UUUUUUU0010UU";
            n_s := state7;
        when state7 =>
            Control_output := "11UU0UUUUUUUUUUU";
            n_s := state0;
        when state8 =>
            Control_output := "UU1UUUUUU1000101";
            n_s := state0;
        when state9 =>
            Control_output := "UUUUUUUU1UUUUU10";
            n_s := state0;
        when others =>
            null;
    end case;

    RegDst <= Control_output(15);
    RegWrite <= Control_output(14);
    ALUSrcA <= Control_output(13);
    IRWrite <= Control_output(12);
    MemtoReg <= Control_output(11);
    MemWrite <= Control_output(10);
    MemRead <= Control_output(9);
    IorD <= Control_output(8);
    PCWrite <= Control_output(7);
    PCWriteCond <= Control_output(6);
    ALUSrcB <= Control_output(5 downto 4);
    ALUOp <= Control_output(3 downto 2);
    PCSource <= Control_output(1 downto 0);

end if;

end process;

end behave;
