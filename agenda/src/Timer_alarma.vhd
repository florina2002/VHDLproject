library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Timer_Alarma is
port (clk : in std_logic;  
	reset : in std_logic;
	al_on : in std_logic;
	ora_in_1 : in std_logic_vector(3 downto 0); 
	ora_in_0 : in std_logic_vector(3 downto 0);
	minut_in_1 : in std_logic_vector(3 downto 0); 
	minut_in_0 : in std_logic_vector(3 downto 0);
	al_ora_in_1 : in std_logic_vector(1 downto 0); 
	al_ora_in_0 : in std_logic_vector(3 downto 0);
	al_minut_in_1 : in std_logic_vector(3 downto 0); 
	al_minut_in_0 : in std_logic_vector(3 downto 0);
	
	alarma : out std_logic_vector(3 downto 0));
end entity;	   

architecture Arh_Timer_Alarma of Timer_Alarma is

signal sec : integer := 0;
signal ora : integer := 0;
signal min : integer := 0;	  

signal ora_alarma : integer := 0;
signal min_alarma : integer := 0;

signal secunde_pana_la_alarma : integer := 0;
signal secunde_in : integer := 0;
signal secunde_alarma : integer := 0;	  

signal reset_alarma : std_logic := '0';

begin	
	process (clk, reset)
	begin
		if (reset_alarma = '1') then
		   alarma <= x"0"; 
		end if;
		
		if (al_on = '1') and (reset_alarma = '0') then
			if reset = '0' then 
					ora <= to_integer(unsigned(ora_in_1)) * 10 + to_integer(unsigned(ora_in_0));
					min <= to_integer(unsigned(minut_in_1)) * 10 + to_integer(unsigned(minut_in_0));  
					ora_alarma <= to_integer(unsigned(al_ora_in_1)) * 10 + to_integer(unsigned(al_ora_in_0));
					min_alarma <= to_integer(unsigned(al_minut_in_1)) * 10 + to_integer(unsigned(al_minut_in_0));
					
					if (ora_alarma > ora) then
						secunde_in <= 3600 * ora + 60 * min;	  
						secunde_alarma <= 3600 * ora_alarma + 60 * min_alarma;  
						secunde_pana_la_alarma <= secunde_alarma - secunde_in;	  
					else
						secunde_in <= 3600 * 24 - (3600 * ora + 60 * min);	  
						secunde_alarma <= 3600 * ora_alarma + 60 * min_alarma;  
						secunde_pana_la_alarma <= secunde_alarma + secunde_in;
					end if;
			elsif rising_edge(clk) then
				sec <= sec + 1;
				if (sec = secunde_pana_la_alarma) then
					alarma <= x"1";
					reset_alarma <= '1';
				end if;
	    	end if;	
	   end if;	
	
	end process;
end architecture;