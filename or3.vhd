library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or3 is
        GENERIC (N : INTEGER := 32); -- bit width
        PORT(
            A : IN std_logic_vector(N-1 downto 0);
            B : IN std_logic_vector(N-1 downto 0);
            Y : OUT std_logic_vector(N-1 downto 0)
);
end or3;


architecture dataflow of or3 is
begin
            Y <= A or B;
end dataflow;





            