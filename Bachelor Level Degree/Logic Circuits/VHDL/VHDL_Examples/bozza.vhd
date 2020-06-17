library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity count_4_r is
   port(CLK, RESET, EN : in std_logic;
       Q : out std_logic_vector(3 downto 0);
       CO : out std_logic);
end count_4_r;

architecture behavioral of count_4_r is
signal addr : std_logic_vector(4 downto 0);
begin
process (RESET, CLK)
M,P1x,P1y,P2x,P2y,P3x,P3y,P4x,P4y,P5x,P5y,P6x,P6y,P7x,P7y,P8x,P8y,Px,Py,Mo,T : std_logic_vector(7 down to 0)
M1,M2,M3,M4,M5,M6,M7,M8 : std_logic_vector(8 down to 0)
SoC : std_logic
begin
  if(Soc != 1) then  
    if (RESET = '1') then
        addr <= "00000";
    elsif (CLK'event and (CLK = '1') and (EN = '1')) then
        addr <= addr + "00001";
    end if;
    -- READ MEMORY AT ADDR (per ora, molto naive, fai uno switch e leggi ciò che c'è in memoria salvandolo nel corrispettivo dato dichiarato nel process, modi migliori?)
    if(addr = "11111") then
            addr <= "00000";
            std_logic <= 1;
        end if;
  else
    -- FAI SWITCH CON DISTANZA MANHATTAN COSI' CODIFICATA ATTRAVERSO UN FOR :
    -- if(Pix > Px) then
    --   T <= Px;
    --   Px <= Pix;
    --   Pix <= T;
    -- endif
    -- if(Piy > Py) then
    --   T <= Py;
    --   Py <= Piy;
    --   Piy <= T;
    -- endif
    -- Mi <= (Px - Pix) + (Py - Piy);
    -- ciclo per trovare minore min
    -- sommo allo std_logic_vector Mo inizialmente a 00000000 il corrispettivo bit posizionale se Mi = min
    -- mando in uscita Mo e metto DONE = 1
end process;
end behavioral;

entity diff_8_b is
   port(B, A : in std_logic_vector(7 downto 0);
           S : out std_logic_vector(7 downto 0););
end diff_8_b;

architecture behavioral of diff_8_b is
signal sum : std_logic_vector(7 downto 0);
begin
   diff <= A - B;
   S <= diff
end behavioral;