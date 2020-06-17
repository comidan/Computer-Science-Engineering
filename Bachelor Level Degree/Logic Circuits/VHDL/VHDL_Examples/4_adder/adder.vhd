
entity adder is
	port(a, b, cin: in bit;
		 s, cout: out bit);
end entity;

architecture arch1 of adder is
begin
	s    <= a xor b xor cin;
	cout <= (a and b) or (a and cin) or (b and cin);
end architecture;

-- architecture arch2 of adder is
-- signal sum: bit_vector(1 downto 0);
-- begin
-- 	sum  <= ('0' & a) + ('0' & b) + ('0' & cin);
-- 	s    <= sum(0);
-- 	cout <= sum(1);
-- end architecture;


-- test code for freehdl

use work.all;

entity test is end;

architecture arch of test is
component adder is
	port(a, b, cin: in bit;
		 s, cout: out bit);
end component;
signal a, b, cin, s, cout: bit;
begin
	ADD0: adder port map(a,b,cin,s,cout);
	process
	begin
		a <= '0'; b <= '0'; cin <= '0';
		wait for 10 ns;
		a <= '1';
		wait for 10 ns;
		a <= '0'; b<= '1';
		wait for 10 ns;
		a <= '1';
		wait for 10 ns;
		a <= '0'; cin <= '1';
		wait for 10 ns;
		a <= '1';
		wait for 10 ns;
	end process;
end architecture;
