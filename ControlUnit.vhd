library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
    port(
        Opcode : in std_logic_vector(5 downto 0);
        Funct : in std_logic_vector(5 downto 0);
        RegWrite : out std_logic;
        MemtoReg : out std_logic;
        MemWrite : out std_logic;
        ALUControl : out std_logic_vector(3 downto 0);
        ALUSrc : out std_logic;
        RegDst : out std_logic);
end entity ControlUnit;
        
architecture behavioral of ControlUnit is
       
begin
        
    
    
    process(Opcode)
    begin
       if Opcode = "000000" then
            RegDst <= '1';
        else 
            RegDst <= '0';
            
        end if;
    end process;

    process(Opcode)
    begin
        if Opcode = "000000" or Opcode = "100101" or Opcode = "100011" or Opcode = "000010" or Opcode = "000011" or Opcode = "000100" or Opcode = "000101" or Opcode = "001000" or Opcode = "001101" then
            RegWrite <= '1';
        else
            RegWrite <= '0';
        end if;
    end process;
    
    process(Opcode)
    begin
        if Opcode = "101011" then
            MemWrite <= '1';
        else
            MemWrite <= '0';
        end if;
    end process;
    
    process(Opcode)
    begin
        if Opcode = "100011" then
            MemtoReg <= '1';
        else
            MemtoReg <= '0';
        end if;
    end process;
    
    process(Opcode, Funct)
    begin
    if Opcode = "000000" then
        case Funct is 
            when "100000" => ALUControl <= "0100"; --add
            when "100100" => ALUControl <= "1010"; --and
            when "011001" => ALUControl <= "0110"; --multu   
            when "100101" => ALUControl <= "1000"; --or
            when "000000" => ALUControl <= "1100"; --sll
            when "000011" => ALUControl <= "1110"; --sra
            when "000010" => ALUControl <= "1101"; --srl
            when "100010" => ALUControl <= "0101"; --sub
            when "100110" => ALUControl <= "1011"; --xor                
            when others => ALUControl <= "XXXX"; 
        end case;
    else
        case Opcode is
            when "001000" => ALUControl <= "0100"; --addi
            when "001100" => ALUControl <= "1010"; --andi
            when "001101" => ALUControl <= "1000"; --ori
            when "001110" => ALUControl <= "1011"; --xori
            when "101011" => ALUControl <= "0100"; --sw
            when "100011" => ALUControl <= "0100"; --lw
            when others => ALUControl <= "XXXX"; 
        end case;
    end if;
end process;

    
    process(Opcode)
    begin
       if Opcode = "001000" or Opcode = "001101" or Opcode = "001100" or Opcode = "001110" or Opcode = "101011" or Opcode = "100011" then 
            ALUSrc <= '1';
        else
            ALUSrc <= '0';
        end if;
    end process;                
end behavioral;
