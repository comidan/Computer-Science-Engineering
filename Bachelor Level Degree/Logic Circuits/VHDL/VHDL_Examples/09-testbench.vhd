library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture struct_1 of testbench is
   component adder_4
     port(B, A : in  std_logic_vector(3 downto 0);
            C0 : in std_logic;
             S : out std_logic_vector(3 downto 0);
            C4: out std_logic);
   end component;
   signal in2, in1, somma : std_logic_vector(3 downto 0);
   signal cin, cout : std_logic;
begin
  UUT: adder_4 port map(in2, in1, cin, somma, cout);

  stimuli1: process
  begin
     cin <= '0';
     in2 <= "0000";
     in1 <= "0001";
     wait for 10 ns;
     in2 <= "0000";
     in1 <= "0000";
     cin <= '1';
     wait for 15 ns;
     in2 <= "0001";
     in1 <= "0010";
     cin <= '0';
     wait for 5 ns;
     wait;
  end process stimuli1;
end struct_1;
