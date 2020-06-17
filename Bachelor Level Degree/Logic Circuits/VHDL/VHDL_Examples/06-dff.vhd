-- Positive Edge-Triggered D Flip-Flop with Reset:
-- VHDL Process Description
library ieee;
use ieee.std_logic_1164.all;
entity dff is
   port(CLK, RESET, D: in std_logic;
        Q, Q_n: out std_logic);
end dff;

architecture pet_pr of dff is
-- Implements positive edge-triggered bit state storage
-- with asynchronous reset.
   signal state: std_logic;
begin
   Q <= state;
   Q_n <= not state;
   process (CLK, RESET)
   begin
     if (RESET = '1') then
       state <= '0';
     else
        if (CLK'event and ClK = '1') then
           state <= D;
        end if;
     end if;
   end process;
end;
