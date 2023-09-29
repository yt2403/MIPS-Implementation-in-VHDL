library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity DataMemory is
    generic (Width : integer := 32;
             ADDR_SPACE : integer := 10);

    Port ( 
        clk , w_en : in std_logic;
        addr : in std_logic_vector(ADDR_SPACE - 1 downto 0);
        d_in : in std_logic_vector(Width - 1 downto 0);
        switches : in std_logic_vector(15 downto 0);
        d_out : out std_logic_vector(WIDTH - 1 downto 0);
        seven_seg : out std_logic_vector(15 downto 0)
    );
end DataMemory;

architecture Behavioral of DataMemory is
  type mips_mem_type is array(2**addr_space -1 downto 0) of std_logic_vector(WIDTH-1 downto 0);
  signal mips_mem : mips_mem_type := (others => (others => '0'));
  
begin
  process (clk) is
  begin
    if (rising_edge(clk)) then
        if (w_en = '1') then
            mips_mem(to_integer(unsigned(addr))) <= d_in;
        end if;
        if addr = 10ux"3ff" then
            if w_en = '1' then
                seven_seg <= D_in(15 downto 0);
            end if;
        elsif addr = 10ux"3fe" then
            d_out <= (others => '0');
            d_out(15 downto 0) <= switches;
            
        else
            d_out <= mips_mem(to_integer(unsigned(addr)));
    end if;
    end if;
  end process;

 
end Behavioral;