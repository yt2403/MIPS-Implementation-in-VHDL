library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionDecode is
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
        
end entity;


architecture behavioral of InstructionDecode is

   
    signal Imm : std_logic_vector(15 downto 0);
    
    component RegisterFile is
        generic (
            BIT_DEPTH : integer := 8;
            LOG_PORT_DEPTH : integer := 3
        );
        port (
            clk_n : in std_logic;
            we : in std_logic;
            Addr1 : in std_logic_vector(LOG_PORT_DEPTH - 1 downto 0);
            Addr2 : in std_logic_vector(LOG_PORT_DEPTH - 1 downto 0);
            Addr3 : in std_logic_vector(LOG_PORT_DEPTH - 1 downto 0);
            wd : in std_logic_vector(BIT_DEPTH - 1 downto 0);
            RD1 : out std_logic_vector(BIT_DEPTH - 1 downto 0);
            RD2 : out std_logic_vector(BIT_DEPTH - 1 downto 0)
        );
    end component;

    component ControlUnit is
        port (
            Opcode : in std_logic_vector(5 downto 0);
            Funct : in std_logic_vector(5 downto 0);
            RegWrite : out std_logic;
            MemtoReg : out std_logic;
            MemWrite : out std_logic;
            ALUControl : out std_logic_vector(3 downto 0);
            ALUSrc : out std_logic;
            RegDst : out std_logic
        );
    end component;

begin
    
    control_unit : ControlUnit
    port map(
        Opcode => Instruction(31 downto 26),
        Funct => Instruction(5 downto 0),
        RegWrite => RegWrite,
        MemtoReg => MemtoReg,
        MemWrite => MemWrite,
        ALUControl => ALUControl,
        ALUSrc => ALUSrc,
        RegDst => RegDst
    );

    reg_file : RegisterFile
    generic map(
        BIT_DEPTH => 32,
        LOG_PORT_DEPTH => 5
    )
    port map(
        clk_n => clk,
        Addr1 => Instruction(25 downto 21),
        Addr2 => Instruction(20 downto 16),
        Addr3 => RegWriteAddr,
        we => RegWriteEn,
        wd => RegWriteData,
        RD1 => RD1,
        RD2 => RD2
    );
    
    RtDest <= Instruction(20 downto 16);
    RdDest <= Instruction(15 downto 11);
    Imm <= Instruction(15 downto 0);
    process(Imm)
    begin
        if (Imm(15) = '0') then --if the msb is 0, then no need to sign extend.
            ImmOut <= x"0000" & Imm;
        else
            ImmOut <= x"FFFF" & Imm;
        end if;
    end process;

end behavioral;
