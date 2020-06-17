entity fsm is
	port(clock, reset: in bit;
		 e: in  bit_vector(2 downto 0);
		 u: out bit_vector(1 downto 0));
end entity;

architecture arch of fsm is
type S is (A,B,C);
signal cur_state, next_state : S;
begin
	process(clock, reset)
	begin
		if(reset = '1') then
			cur_state <= A;
		elsif clock'event and clock='1' then
			cur_state <= next_state;
		end if;
	end process;

	process(cur_state, e)
	begin
		case cur_state is
			when A =>
				case e is
					when "001"  => next_state <= B;
					when "010"  => next_state <= C;
					when others => next_state <= A;
				end case;
			when B =>
				case e is
					when "001"  => next_state <= B;
					when "000"  => next_state <= C;
					when "010"  => next_state <= C;
					when "011"  => next_state <= C;
					when others => next_state <= A;
				end case;
			when C =>
				case e is
					when "010"  => next_state <= C;
					when "000"  => next_state <= B;
					when "001"  => next_state <= B;
					when "011"  => next_state <= B;
					when others => next_state <= A;
				end case;
		end case;
	end process;

	process(cur_state)
	begin
		case cur_state is
			when A      => u <= "00";
			when B      => u <= "01";
			when others => u <= "10";
		end case;
	end process;
end architecture;


-- test code for freehdl

use work.all;

entity test is end;

architecture arch of test is
component fsm is
	port(clock, reset: in bit;
		 e: in  bit_vector(2 downto 0);
		 u: out bit_vector(1 downto 0));
end component;
signal reset, clock: bit;
signal e: bit_vector(2 downto 0);
signal u: bit_vector(1 downto 0);
begin
	FSM0: fsm port map(clock,reset,e,u);
	process
	begin
		reset <= '1';
		clock <= '0';
		e <= "000";
		wait for 10 ns;
		reset <= '0';

		wait for 10 ns;
		clock <= '1';
		wait for 10 ns;
		clock <= '0';
		wait for 10 ns;

		e <= "001";
		wait for 10 ns;
		clock <= '1';
		wait for 10 ns;
		clock <= '0';
		wait for 10 ns;

		wait for 10 ns;
		clock <= '1';
		wait for 10 ns;
		clock <= '0';
		wait for 10 ns;

		e <= "000";
		wait for 10 ns;
		clock <= '1';
		wait for 10 ns;
		clock <= '0';
		wait for 10 ns;

		wait for 10 ns;
		clock <= '1';
		wait for 10 ns;
		clock <= '0';
		wait for 100 ns;
	end process;
end architecture;