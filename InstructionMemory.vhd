library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory is
    port(
        addr : in std_logic_vector(27 downto 0);
        d_out : out std_logic_vector(31 downto 0)
        );
end InstructionMemory;


architecture behavioral of InstructionMemory is
        type mem_array is array (0 to 1023) of std_logic_vector(7 downto 0);
        constant instr : mem_array := (
           x"20", x"01", x"FE", x"FE", -- addi r1 0xFEFE
            x"20", x"02", x"CE", x"CE", -- addi r2 0xCECE
            x"00", x"00", x"00", x"00", -- nop
            x"00" , x"00" , x"00" , x"00",
            x"00" , x"00" , x"00" , x"00",
            x"AC" , x"01" , x"00" , x"10", --sw r1 0x10(r0)
            x"00" , x"22" , x"18" , x"25", -- or r3 r1 r2
            x"00" , x"22" , x"20" , x"24", -- and r4 r1 r2
            x"00",  x"22",  x"28", x"26", -- xor r5 r1 r2
            x"00", x"22", x"30" ,x"20", -- add r6 r1 r2
            x"00", x"22", x"38", x"19", -- mul r8 r1 r2
            x"00", x"60", x"20", x"00", -- sll r8 0 r3
       
            x"30", x"4B" , x"00", x"08", -- and r12 r2 0x8
            x"34" , x"4D", x"00", x"07", -- ori r13 r2 0x7
            x"38" , x"4E", x"00", x"07", -- xori r14 r2 0x7
            x"00", x"60", x"20", x"02", --srl r8 0 r3
            x"00", x"60", x"20", x"03", --srA r8 0 r3
            x"8c", x"0f" , x"00", x"10", --lw r15 0x10(r0)

            others => (others => '0')
           
        );
        
            
        
        begin
            
        process(addr)
            

            variable temp_addr : integer range 0 to 1023;
            
        begin
          
         
           if unsigned(addr) < 1024 then
                    d_out <= instr(to_integer(unsigned(addr))) &
                    instr(to_integer(unsigned(addr)) + 1) &
                    instr(to_integer(unsigned(addr)) + 2) &
                    instr(to_integer(unsigned(addr)) + 3);
           else                   
                    d_out <= (others => '0');         
                             
           end if;
           end process;
           end behavioral;                
                    
                                          
                         
                    