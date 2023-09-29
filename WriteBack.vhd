library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity WriteBack is
    Port (
        RegWrite, MemToReg : in std_logic;
        AluResult : in std_logic_vector(31 downto 0);
        ReadData : in std_logic_vector(31 downto 0);
        WriteReg : in std_logic_vector(4 downto 0);
        RegWriteOut : out std_logic;
        WriteRegOut : out std_logic_vector(4 downto 0);
        Result : out std_logic_vector(31 downto 0)
     );
end WriteBack;
architecture Behavioral of WriteBack is

begin
    process(ReadData, MemtoReg, ALUResult) is begin
        if MemToReg = '1' then
            Result <= ReadData;
        else
            Result <= ALUResult;
        end if;
        end process;
        WriteRegOut <= WriteReg;
        RegWriteOut <= RegWrite;

end Behavioral;
