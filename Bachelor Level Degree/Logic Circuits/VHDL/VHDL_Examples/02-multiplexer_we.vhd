library ieee;
use ieee.std_logic_1164.all;
entity multiplexer_4_to_1_we is
port (S : in std_logic_vector(1 downto 0);
      I : in std_logic_vector(3 downto 0);
      Y : out std_logic);
end multiplexer_4_to_1_we;

architecture function_table of multiplexer_4_to_1_we is
begin
   Y <=  I(0) when S = "00" else
         I(1) when S = "01" else
         I(2) when S = "10" else
         I(3) when S = "11" else
         'X';
end function_table;
