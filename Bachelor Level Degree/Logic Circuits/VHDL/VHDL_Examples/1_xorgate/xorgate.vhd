
entity xorgate is
	port(a, b: in bit; c: out bit);
end entity;

architecture arch of xorgate is
begin
	c <= a xor b;
end architecture;


-- test code for freehdl

use work.all;

entity test is end;

architecture arch of test is
component xorgate is
	port(a, b: in bit; c: out bit);
end component;
signal a: bit_vector(1 downto 0);
signal c: bit;
begin
	XOR0: xorgate port map(a(0),a(1),c);
	process
	begin
		a <= "00";
		wait for 10 ns;
		a <= "01";
		wait for 10 ns;
		a <= "10";
		wait for 10 ns;
		a <= "11";
		wait for 10 ns;
	end process;
end architecture;
