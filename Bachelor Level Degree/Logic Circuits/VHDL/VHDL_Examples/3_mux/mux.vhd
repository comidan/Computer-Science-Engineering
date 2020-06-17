
entity mux is
	port(a, b, c, d, s0, s1: in bit;
		 y: out bit);
end entity;

-- architecture dataflow of mux is
-- begin
-- 	y <= (a and (not s1) and (not s0)) or
-- 		 (b and (not s1) and      s0 ) or
-- 		 (c and      s1  and (not s0)) or
-- 		 (d and      s1  and      s0 );
-- end architecture;

-- architecture arch2 of mux is
-- begin
-- 	y <= a when s1 = '0' and s0 = '0' else
-- 		 b when s1 = '0' and s0 = '1' else
-- 		 c when s1 = '1' and s0 = '0' else
-- 		 d;
-- end architecture;

-- architecture arch3 of mux is
-- signal s: bit_vector(1 downto 0);
-- begin
-- 	s <= s1 & s0;
-- 	
-- 	with s select
-- 		y <= a when "00",
-- 			 b when "01",
-- 			 c when "10",
-- 			 d when others;
-- end architecture;

-- architecture arch4 of mux is
-- signal s: bit_vector(1 downto 0);
-- begin
-- 	s <= s1 & s0;
-- 	process(s,a,b,c,d)
-- 	begin
-- 		if    s = "00" then
-- 			y <= a;
-- 		elsif s = "01" then
-- 			y <= b;
-- 		elsif s = "10" then
-- 			y <= c;
-- 		else
-- 			y <= d;
-- 		end if;
-- 	end process;
-- end architecture;

-- architecture arch5 of mux is
-- signal s: bit_vector(1 downto 0);
-- begin
-- 	s <= s1 & s0;
-- 	process(s,a,b,c,d)
-- 	begin
-- 		case s is
-- 			when "00"   => y <= a;
-- 			when "01"   => y <= b;
-- 			when "10"   => y <= c;
-- 			when others => y <= d;
-- 		end case;
-- 	end process;
-- end architecture;


-- test code for freehdl

use work.all;

entity test is end;

architecture arch of test is
component mux is
	port(a, b, c, d, s0, s1: in bit;
		 y: out bit);
end component;
signal s: bit_vector(1 downto 0);
signal a, b, c, d, y: bit;
begin
	MUX0: mux port map(a,b,c,d,s(0),s(1),y);
	process
	begin
		a <= '0'; b <= '0'; c <= '0'; d <= '0';
		s <= "00";
		wait for 10 ns;
		a <= '1';
		wait for 10 ns;
		s <= "01";
		wait for 10 ns;
		b <= '1';
		wait for 10 ns;
		s <= "10";
		wait for 10 ns;
		c <= '1';
		wait for 10 ns;
		s <= "11";
		wait for 10 ns;
		d <= '1';
		wait for 10 ns;
	end process;
end architecture;
