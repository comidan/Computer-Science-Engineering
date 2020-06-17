
entity dff is
	port(d, clk, reset: in bit;
		 q: out bit);
end entity;

architecture arch of dff is
begin
	process (reset, clk)
	begin
		if reset = '1' then
			q <= '0';
		elsif clk'event and clk = '1' then
			q <= d;
		end if;
	end process;
end architecture;


-- test code for freehdl

use work.all;

entity test is end;

architecture arch of test is
component dff is
	port(d, clk, reset: in bit;
		 q: out bit);
end component;
signal d, clk, reset, q: bit;
begin
	DEC0: dff port map(d,clk,reset,q);
	process
	begin
		reset <= '1';
		clk <= '0';
		d <= '0';
		wait for 10 ns;
		reset <= '0';
		wait for 10 ns;
		d <= '1';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
		d <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		d <= '1';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
		d <= '0';
		wait for 10 ns;
		reset <= '1';
		wait for 10 ns;
	end process;
end architecture;
