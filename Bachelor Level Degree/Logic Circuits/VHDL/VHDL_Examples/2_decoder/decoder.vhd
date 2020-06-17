
entity decoder is
	port(a0, a1: in bit;
		 d0, d1, d2, d3: out bit);
end entity;

architecture arch of decoder is
signal dec_in:  bit_vector(1 downto 0);
signal dec_out: bit_vector(3 downto 0);
begin
	dec_in <= a1 & a0;
	
	with dec_in select
		dec_out <= "0001" when "00",
				   "0010" when "01",
				   "0100" when "10",
				   "1000" when others;
	
	d0 <= dec_out(0);
	d1 <= dec_out(1);
	d2 <= dec_out(2);
	d3 <= dec_out(3);
end architecture;


-- test code for freehdl

use work.all;

entity test is end;

architecture arch of test is
component decoder is
	port(a0, a1: in bit;
		 d0, d1, d2, d3: out bit);
end component;
signal a: bit_vector(1 downto 0);
signal d0, d1, d2, d3: bit;
begin
	DEC0: decoder port map(a(0),a(1),d0,d1,d2,d3);
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
