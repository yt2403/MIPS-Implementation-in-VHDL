library IEEE ;
use IEEE . STD_LOGIC_1164 . ALL ;
use IEEE . NUMERIC_STD . ALL ;
entity sraN is
GENERIC ( N : INTEGER := 32) ; -- shift bits
PORT (
          A : IN std_logic_vector (N -1 downto 0) ;
          SHIFT_AMT : IN std_logic_vector (N -1 downto 0) ;
          Y : OUT std_logic_vector (N -1 downto 0)
) ;
end sraN ;
architecture behavioral of sraN is
-- create array of vectors to hold each of n shifters
type shifty_array is array (N -1 downto 0) of std_logic_vector (N -1 downto 0) ;
signal aSRA : shifty_array ;
begin
        generateSLL : for i in 0 to N -1 generate
        aSRA ( i ) (N -1 - i downto 0 ) <= A (N -1 downto i) ;
        left_fill : if i > 0 generate
        aSRA ( i ) (n - 1 downto n - i) <= ( others => a(N-1));
end generate left_fill ;
end generate generateSLL ;

       Y <= aSRA(to_integer(unsigned(SHIFT_AMT))) when
        (to_integer(unsigned(SHIFT_AMT)) < N and to_integer(unsigned(SHIFT_AMT)) >= 0)
        else (others => '0');
end behavioral ;
