library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mips is
    Port ( 
        clk,rst : in std_logic;
        writedata : out std_logic_vector(31 downto 0);
        result : out std_logic_vector(31 downto 0));
end Mips;

architecture Behavioral of Mips is
    
    component InstructionFetch is 
    port (
        clk : in std_logic;
        rst : in std_logic;
        Instruction : out std_logic_vector(31 downto 0)
    );
    end component InstructionFetch;
    
    signal Instruction , Instructionf : std_logic_vector(31 downto 0) := (others => ('0'));
    
    component InstructionDecode is
        port(
    --- Inputs
        Instruction : in std_logic_vector(31 downto 0);
        clk : in std_logic;
        RegWriteAddr : in std_logic_vector(4 downto 0);
        RegWriteData : in std_logic_vector(31 downto 0);
        RegWriteEn : in std_logic;
    --- Outputs
        RegWrite : out std_logic;   
        MemtoReg : out std_logic;   
        MemWrite : out std_logic;   
        ALUControl : out std_logic_vector(3 downto 0);
        ALUSrc : out std_logic;
        RegDst : out std_logic;
        RD1 : out std_logic_vector(31 downto 0);
        RD2 : out std_logic_vector(31 downto 0);
        RtDest : out std_logic_vector(4 downto 0) := (others => '0');
        RdDest : out std_logic_vector(4 downto 0) := (others => '0');
        ImmOut : out std_logic_vector(31 downto 0)
        );
        end component InstructionDecode;
    
    signal regwriteD , memtoregD , memwriteD , alusrcD , regdstD :  std_logic := '0';
    signal alucontrolD : std_logic_vector(3 downto 0) := (others => ('0'));
    signal rtD, rdD : std_logic_vector(4 downto 0) := (others => ('0'));
    signal rd1D, rd2D, immD : std_logic_vector(31 downto 0) := (others => ('0'));
    
    component ExecuteStage is
        Port (
        RegWrite, MemToReg, MemWrite : in std_logic;
        ALUControl : in std_logic_vector(3 downto 0);
        ALUSrc : in std_logic;
        RegDst : in std_logic;
        RegSrcA, RegSrcB : in std_logic_vector(31 downto 0);
        RtDest, RdDest : in std_logic_vector(4 downto 0);
        SignImm : in std_logic_vector(31 downto 0);
        RegWriteOut, MemToRegOut, MemWriteOut : out std_logic;
        ALUResult, WriteData : out std_logic_vector(31 downto 0);
        WriteReg : out std_logic_vector(4 downto 0)
    );
    end component ExecuteStage; 
    
    signal regwriteE , memtoregE, memwriteE, alusrcE, regdstE : std_logic := '0';
    signal alucontrolE : std_logic_vector(3 downto 0) := (others => ('0'));
    signal rd1E, rd2E, immE : std_logic_vector(31 downto 0) := (others => ('0'));
    signal rtE, rdE : std_logic_vector(4 downto 0) := (others => ('0'));
    signal aluresultE, writedataE : std_logic_vector(31 downto 0) := (others => ('0'));
    signal writeregE : std_logic_vector(4 downto 0) := (others => ('0'));
    
    component MemoryStage is 
        Port (
        clk, rst, MemWrite, MemToReg, RegWrite : in std_logic;
        WriteReg : in std_logic_vector(4 downto 0);
        ALUResult , WriteData : in std_logic_vector(31 downto 0);
        switches : in std_logic_vector(15 downto 0);
        RegWriteOut, MemToRegOut: out std_logic;
        ALUResultOut : out std_logic_vector(31 downto 0);
        ActiveDigit : out std_logic_vector(3 downto 0);
        SevenSegDigit : out std_logic_vector(6 downto 0);
        WriteRegOut : out std_logic_vector(4 downto 0);
        MemOut : out std_logic_vector(31 downto 0)
     );
    end component MemoryStage;
    signal switches : std_logic_vector(15 downto 0) := (others => ('0'));
    signal ActiveDigit : std_logic_vector(3 downto 0) := (others => ('0'));
    signal sevensegdigit : std_logic_vector(6 downto 0) := (others => ('0'));
    signal memwriteM , memtoregM , regwriteM : std_logic := '0';
    signal writeregM : std_logic_vector(4 downto 0) := (others => ('0'));
    signal aluresultM , writedataM , memoutM : std_logic_vector(31 downto 0) := (others => ('0'));
    
    component Writeback is
        Port (
        RegWrite, MemToReg : in std_logic;
        AluResult : in std_logic_vector(31 downto 0);
        ReadData : in std_logic_vector(31 downto 0);
        WriteReg : in std_logic_vector(4 downto 0);
        RegWriteOut : out std_logic;
        WriteRegOut : out std_logic_vector(4 downto 0);
        Result : out std_logic_vector(31 downto 0)
     );
    end component WriteBack;
    
    signal regwriteW, memtoregW : std_logic := '0';
    signal aluresultW , memoutW : std_logic_vector(31 downto 0)  := (others => ('0'));
    signal writeregW : std_logic_vector(4 downto 0) := (others => ('0'));
    signal resultw : std_logic_vector(31 downto 0) := (others => ('0')); 
    
    
begin
    fetch_decode : InstructionFetch
        port map(
            clk => clk,
            rst => rst,
            instruction => instruction);
    register1 : process(clk) is
    begin
        if (rising_edge(clk)) then
            instructionf <= instruction;
            end if;
            end process;
            
    decode : InstructionDecode                       
        port map(
            clk => clk,
            Instruction => Instructionf,
            RegWriteAddr => writeregW,
            regwriteData => resultW,
            RegwriteEn => RegWriteW,
            RegWrite => RegWriteD,
            MemToReg => MemToRegD,
            MemWrite => MemWriteD,
            AluControl => AluControlD,
            AluSrc => AluSrcD,
            RegDst => RegDstD,
            RD1 => rd1D,
            RD2 => rd2D,
            RtDest => rtD,
            RdDest => rdD,
            ImmOut => immD);
            
      decode_to_execute : process(clk) is
      begin
        if (rising_edge(clk)) then       
            regwriteE <= regwriteD;
            MemToRegE <= memtoregD;
            memwriteE <= memwriteD;
            AluControlE <= AluControlD;
            AluSrcE <= AluSrcD;
            regDstE <= regdstD;
            rd1e <= rd1d;
            rd2e <= rd2d;
            rte <= rtd;
            rde <= rdd;
            imme <= immd;
            end if;
            end process;
            
      execute : ExecuteStage
        port map(
            RegWrite => RegWriteE,
            MemToReg => MemToRegE,
            MemWrite => MemWriteE,
            AluControl => AluControlE,
            AluSrc => ALuSrcE,
            RegDst => RegDstE,
            RegSrcA => Rd1e,
            RegSrcB => Rd2e,
            RtDest => RtE,
            RdDest => RdE,
            SignImm => Imme,
            AluResult => AluResultE,
            WriteData => WriteDataE,
            WriteReg => WriteRegE);
            
      Execute_to_memory : process(clk) is
      begin
        if (rising_edge(clk)) then
            regwriteM <= regwriteE;
            memtoregM <= memtoregE;
            memwriteM <= memwriteE;
            aluresultM <= AluresultE;
            writedataM <= writedataE;
            writeregM <= writeregE;
            end if;
            end process;
            
      memory : memorystage
        port map(
            switches => switches,
            sevensegdigit => sevensegdigit,
            ActiveDigit => ActiveDigit,
            clk => clk,
            rst => rst,
            memtoreg => memtoregM,
            regwrite => regwriteM,
            writereg => writeregM,
            memwrite => memwriteM,
            aluresult => aluresultM,
            writedata => writedataM,
            memout => memoutM);      
            
       memory_to_writeback : process(clk) is begin
       if rising_edge(clk) then
            regwriteW <= regwriteM;
            memtoregW <= memtoregM;
            aluresultW <= aluresultM;
            memoutW <= memoutM;
            writeregW <= writeregM;
                
            end if;
            end process;
            
       writebackstage : writeback
            port map(
                memtoreg => memtoregW,
                aluresult => aluresultw,
                readdata => memoutW,
                result => resultW,
                regwrite => regwriteW,
                writeReg => writeregW);
                
                writedata <= resultw;
                result <= aluresultw;
end Behavioral;
