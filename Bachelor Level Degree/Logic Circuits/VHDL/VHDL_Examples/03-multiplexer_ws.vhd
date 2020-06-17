library ieee;
use ieee.std_logic_1164.all;
entity multiplexer_4_to_1_ws is
     port (S : in std_logic_vector(1 downto 0);
           I : in std_logic_vector(3 downto 0);
           Y : out std_logic);
end multiplexer_4_to_1_ws;

architecture function_table_ws of multiplexer_4_to_1_ws is
begin
  with S select
  Y <= I(0) when "00",
       I(1) when "01",
       I(2) when "10",
       I(3) when "11",
       'X' when others;
end function_table_ws;
