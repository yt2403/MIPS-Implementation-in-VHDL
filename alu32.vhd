library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu32 is
generic( N : integer := 32); 
        PORT(
            A : IN std_logic_vector(N-1 downto 0);
            B : IN std_logic_vector(N-1 downto 0);
            OP : IN std_logic_vector(3 downto 0);
            P : OUT std_logic_vector(N-1 downto 0)
           );
end alu32;

architecture structural of alu32 is    
        Component carry_save_mul is
            generic(N : integer := 32);
                port(
                    A , B : in std_logic_vector(N/2 - 1 downto 0);
                    Product : out std_logic_vector(N - 1 downto 0));
        end component carry_save_mul;            
                      
        Component ripple_carry_fa is 
            generic(N : Integer := 32);
                Port( 
                    A, B : in std_logic_vector(N - 1 downto 0);
                    OP : in std_logic;
                    Sum : out std_logic_vector(N - 1 downto 0)
            );
        end component ripple_carry_fa;

        Component or3 is
                GENERIC (N : INTEGER := 32);
                PORT(
                    A : IN std_logic_vector(N-1 downto 0);
                    B : IN std_logic_vector(N-1 downto 0);
                    Y : OUT std_logic_vector(N-1 downto 0));
end Component;
        Component and32 is
                GENERIC (N : INTEGER := 32);
                PORT(
                    A: IN std_logic_vector(N-1 downto 0);
                    B : IN std_logic_vector(N-1 downto 0);
                    Y : OUT std_logic_vector(N-1 downto 0));
end Component;              
        Component XOR32 is
                GENERIC (N : INTEGER := 32);
                PORT(
                    A : IN std_logic_vector(N-1 downto 0);
                    B : IN std_logic_vector(N-1 downto 0);
                    Y : OUT std_logic_vector(N-1 downto 0));
end component;
        
        signal not_result : std_logic_vector(N-1 downto 0);
        signal sll_result : std_logic_vector(N-1 downto 0);
        signal srl_result : std_logic_vector(N-1 downto 0);
        signal sra_result : std_logic_vector(N-1 downto 0);
        signal or_result : std_logic_vector(N-1 downto 0);
        signal and_result : std_logic_vector(N-1 downto 0);
        signal xor_result : std_logic_vector(N-1 downto 0);
        signal ra_result : std_logic_vector(N-1 downto 0);
        signal mul_result : std_logic_vector(N-1 downto 0);
       
begin
        not_comp: entity work.notN
                generic map(N => N)
                port map (A => A, Y => not_result);
                
        add_result : ripple_carry_fa
                generic map(N => N)
                port map(A => A, B => B ,OP => OP(0), Sum => ra_result);

        slr_comp: entity work.srlN
               generic map(N => N)
               port map (A => A, SHIFT_AMT => B, Y => srl_result);
                   
        sll_comp: entity work.sllN
               generic map(N => N)
               port map ( A => A, SHIFT_AMT => B, Y => sll_result);
               
        sra_comp: entity work.sraN
               generic map(N => N)
               port map (A => A, SHIFT_AMT => B, Y => sra_result);
        
        
--        or_comp : or3
--               generic map (N => N)
--               port map (A => in1 , B => in2 , Y => or_result); 
         or_result <= A or B;      
        --xor_comp : XOR32
               --generic map (N => N)
               --port map (A => in1 , B => in2 , Y => xor_result);      
        xor_result <= A xor B;
        and_comp : AND32
               generic map (N => N)
               port map (A => A , B => B , Y => and_result);   
        mul_comp : carry_save_mul
               generic map(N => N)
               port map(A => A(N/2 - 1 downto 0), B => B(N/2 - 1 downto 0), Product => mul_result);      
        
        process(not_result,sll_result,srl_result,sra_result,or_result,and_result,xor_result,ra_result,mul_result, OP)        
            begin 
            CASE OP (3 downto 0) is
                when "1000" => 
                    p <= or_result;
                when "1010" =>
                    p <= and_result;
                when "1011" =>
                    p <= xor_result;
                when "1100" =>
                    p <= sll_result;
                when "1101" =>
                    p <= srl_result;
                when "1110" =>
                    p <= sra_result;
                when "0100" =>
                    p <= ra_result;
                when "0101" =>
                    p <= ra_result;
                when "0110" =>
                    p <= mul_result;
                when others =>
                    p <= x"00000000";
     end case;
     end process;
                 
end structural;