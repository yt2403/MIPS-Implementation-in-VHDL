library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XOR32 is
        GENERIC (N : INTEGER := 32); -- bit width
        PORT(
            A : IN std_logic_vector(N-1 downto 0);
            B : IN std_logic_vector(N-1 downto 0);
            Y : OUT std_logic_vector(N-1 downto 0)
);
end XOR32;


architecture dataflow of XOR32 is
begin
            Y <= A XOR B;
end dataflow;





            