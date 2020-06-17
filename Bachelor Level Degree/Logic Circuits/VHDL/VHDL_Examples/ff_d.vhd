library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all; --lib per WRITE e REPORT
use std.textio.all; --lib per WRITE e REPORT

entity dff is
	port(
		 clk, reset: in std_logic;  --std_logic sono da convertire in signed o unsigned per fare operazioni
		 --d: in std_logic_vector(7 downto 0);           --usare in genere solo 3 tipi : std_logic(_vector), signed e unsigned
		 q: out std_logic_vector(7 downto 0)
 	);
end entity;
--evitare l'uso delle variabili, solo segnali, perchè non hanno una propria interpretazione fisica a differenza di signal
--l'hardware ha un processo di sviluppo molto più lento e più complesso del software : la comunità è piccola ci sono pochi tool
--poco supporto e si cerca di usare SOLO funzionalità stabili perchè un bug nell'HW è molto più costoso e difficile da orreggere
--rispetto ad un bug software
--WRITE e REPORT : due primitive utulizzate durante l'interpretazione VHDL in C++ per poter effettuare del controllo su segnali
--attraverso verilog REPORT è molto più verboso, WRITE fa un formato più utile/semplice
--WRITE accetta solo stringhe, quindi TUTTI i tipo NON stringhe sono da convertire in stringhe per poter stampare i corrispettivi
--valori, per poter concatenare stringhe utilizza l'operatore '&'
--i segnali non possono essere assegnati da due processi diversi contemporaneamente, altrimenti si ha uno stato di overdrive
--o virtuale alta impedenza (nonostante puoi implementare dei meccanismi di lock è comunque da EVITARE avere
--più processi su stesso segnale)
--"No constraint will be written out" come warning significa che non è ben gestito il timing
--i warning li considero tutti come errori, li devo risolvere sempre perchè portano ad un comportamento non previsto e non voluto
--verificare SEMPRE che la simulazione behavourial funzioni bene ALTRIMENTI la sintesi potrebbe essere, nonostante non lo sembri, non funzionante
architecture arch of dff is
signal q_r: std_logic_vector(7 downto 0) := "00000000";
begin
	process (reset, clk)
	begin
	--write( OUTPUT, time'image(now) & " "& "q_r: " & integer'image(to_integer(unsigned'('0' & q_r))) & "" & LF );
	    --q_r <= d;
		if reset = '1' then
			q_r <= "00000000";
		elsif clk'event and clk = '1' and q_r < "11111111" then
			q_r <= std_logic_vector(to_unsigned(to_integer(unsigned(q_r)) + 1, 8));
			write( OUTPUT, time'image(now) & " "& "q_r: " & integer'image(to_integer(unsigned(q_r))) & "" & LF );
	    elsif (q_r = "11111111") then
	       q_r <= "00000000";
		end if;
	end process;
	q<=q_r;
end architecture;