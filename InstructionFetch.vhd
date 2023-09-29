library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionFetch is 
    port (
        clk : in std_logic;
        rst : in std_logic;
        Instruction : out std_logic_vector(31 downto 0)
    );
end InstructionFetch;

architecture behavioral of InstructionFetch is 

    signal PC : std_logic_vector(27 downto 0) := (others => '0');
    signal MemOut : std_logic_vector(31 downto 0);
    component InstructionMemory is
        port (
            addr : in std_logic_vector(27 downto 0);
            d_out : out std_logic_vector(31 downto 0)
        );
    end component;
    
begin
    instmem : InstructionMemory
        port map (
            addr => std_logic_vector(PC(27 downto 0)),
            d_out => MemOut
        );
      
    process (clk,rst)
    begin
        if rst = '1' then
            PC <= (others => '0');
            
           
        elsif rising_edge(clk) then                                
            PC <= std_logic_vector(unsigned(PC)+4);
        end if;
    end process;
    Instruction <= MemOut;
end behavioral;
