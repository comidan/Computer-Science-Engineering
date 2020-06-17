-- 4-bit Binary Counter with Reset
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity count_4_r is
   port(CLK, RESET, EN : in std_logic;
       Q : out std_logic_vector(3 downto 0);
       CO : out std_logic);
end count_4_r;

architecture behavioral of count_4_r is
signal count : std_logic_vector(3 downto 0);
begin
process (RESET, CLK)
begin
   if (RESET = '1') then
      count <= "0000";
   elsif (CLK'event and (CLK = '1') and (EN = '1')) then
       count <= count + "0001";
   end if;
end process;
CO <= '1' when count = "1111" and EN = '1' else '0';
Q <= count;
end behavioral;
