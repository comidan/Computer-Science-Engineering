
entity fsm is
	port(clock, reset, e: in bit;
		 u: out bit);
end entity;

architecture arch of fsm is
type S is (S1,S2,S3);
signal cur_state, next_state : S;
begin
	process(clock, reset)
	begin
		if(reset = '1') then
			cur_state <= S1;
		elsif clock'event and clock='1' then
			cur_state <= next_state;
		end if;
	end process;

	process(cur_state, e)
	begin
		case cur_state is
			when S1 =>
				if(e = '0')
				then
					next_state <= S1;
					u <= '0';
				else
					next_state <= S2;
					u <= '1';
				end if;
			when S2 =>
				if(e = '0')
				then
					next_state <= S1;
					u <= '0';
				else
					next_state <= S3;
					u <= '1';
				end if;
			when S3 =>
				if(e = '0')
				then
					next_state <= S3;
					u <= '1';
				else
					next_state <= S1;
					u <= '1';
				end if;
		end case;
	end process;
end architecture;


-- test code for freehdl

use work.all;

entity test is end;

architecture arch of test is
component fsm is
	port(clock, reset, e: in bit;
		 u: out bit);
end component;
signal reset, clock, e, u: bit;
begin
	FSM0: fsm port map(clock,reset,e,u);
	process
	begin
		reset <= '1';
		clock <= '0';
		e <= '0';
		wait for 10 ns;
		reset <= '0';

		wait for 10 ns;
		clock <= '1';
		wait for 10 ns;
		clock <= '0';

		wait for 5 ns;
		e <= '1';
		wait for 5 ns;
		clock <= '1';
		wait for 10 ns;
		clock <= '0';

		wait for 5 ns;
		e <= '0';
		wait for 5 ns;
		e <= '1';
		wait for 5 ns;
		clock <= '1';
		wait for 10 ns;
		clock <= '0';

		wait for 5 ns;
		e <= '0';
		wait for 5 ns;
		e <= '1';
		wait for 5 ns;
		clock <= '1';
		wait for 10 ns;
		clock <= '0';

		e <= '0';
		wait for 10 ns;

		wait for 200 ns;
	end process;
end architecture;
