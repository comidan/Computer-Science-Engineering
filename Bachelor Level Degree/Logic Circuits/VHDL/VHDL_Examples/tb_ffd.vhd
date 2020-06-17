 

--use work.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity test is end;

architecture arch of test is
component dff is
	port(clk, reset: in std_logic;
		 --d: in std_logic_vector(7 downto 0);
		 q: out std_logic_vector(7 downto 0)
 );
end component;
signal clk, reset: std_logic;
signal q: std_logic_vector(7 downto 0);
--tutti i segnali DEVONO essere collegti direttamente o indirettamente al PRIMARY INPUT/OUTPUT altimenti vengono tagliati
--in sintesi i moduli che lo utilizzano
begin
	DEC0: dff port map(clk=>clk,reset=>reset,q=>q);
	
	
	process --nel test banch devo generare io il segnale di CLOCK, sfrutto un process senza sensitivity list per poter farlo
	begin   --eseguire parallelaente in loop
	  clk <= '0'; 
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
	end process;
	
	
	
	process
	begin
		reset <= '1';
		wait for 30 ns; --wait for NON è sintetizzabile
		reset <= '0';
		wait for 6000 ns;
		assert false report "simulation completed" severity failure; --necessario per terminare la simulazione di test
	end process;                                                     --altrimenti andrà avanti all'infinito
end architecture;
