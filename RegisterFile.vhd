library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile is
    generic(BIT_DEPTH : integer := 8;
            LOG_PORT_DEPTH : integer := 3);
    port(
        clk_n : in std_logic;
        we : in std_logic;
        Addr1 : in std_logic_vector(Log_Port_Depth - 1 downto 0);
        Addr2 : in std_logic_vector(Log_Port_Depth - 1 downto 0);
        Addr3 : in std_logic_vector(Log_Port_Depth - 1 downto 0);
        wd : in std_logic_vector(bit_depth - 1 downto 0);
        RD1 : out std_logic_vector(bit_depth - 1 downto 0);   
        RD2 : out std_logic_vector(bit_depth - 1 downto 0) 
            
        );
end RegisterFile;

architecture behavioral of RegisterFile is 
        type mem_array is array (0 to 2**Log_Port_Depth - 1) of std_logic_vector(0 to Bit_depth - 1);
        signal memory : mem_array := (others => (others => '0'));
        

        begin
            process(clk_n) is begin
               if falling_edge(clk_n) then 
                    if(to_integer(unsigned(Addr3)) /= 0) then
                            if (we = '1') then
                                memory(to_integer(unsigned(Addr3))) <= wd;
                                
                end if;
            end if;
       end if;
    end process;
    
    RD1 <= memory(to_integer(unsigned(Addr1)));
    RD2 <= memory(to_integer(unsigned(Addr2)));
end behavioral;