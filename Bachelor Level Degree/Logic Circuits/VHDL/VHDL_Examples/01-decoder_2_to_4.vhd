-- 2-to-4 Line Decoder: Dataflow VHDL Description

library ieee;
use ieee.std_logic_1164.all;
entity decoder_2_to_4_w_enable is
   port(EN, A0, A1: in std_logic;
        D0, D1, D2, D3: out std_logic);
end decoder_2_to_4_w_enable;

architecture dataflow_1 of decoder_2_to_4_w_enable is

signal A0_n, A1_n: std_logic;
begin
   A0_n <= not A0;
   A1_n <= not A1;
   D0 <= A0_n and A1_n and EN;
   D1 <= A0 and A1_n and EN;
   D2 <= A0_n and A1 and EN;
   D3 <= A0 and A1 and EN;
end dataflow_1;

