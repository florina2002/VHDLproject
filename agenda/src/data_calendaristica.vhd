library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_calendaristica is
   port(clk : in std_logic;
   	  numar_zile : in integer;
      zi : out integer;
	  luna : out integer;
	  an : out integer);
end entity;

architecture Arh_Calendaristic of data_calendaristica is
	signal ziua_curenta : integer range 1 to 32 := 1;
    signal luna_curenta : integer range 1 to 13 := 1;
    signal an_curent : integer range 2020 to 2100 := 2020; 
	signal reset: std_logic;	  
	signal ora_in_1 : std_logic_vector(1 downto 0); 
	signal ora_in_0 : std_logic_vector(3 downto 0);
	signal minut_in_1 : std_logic_vector(3 downto 0); 
	signal minut_in_0 : std_logic_vector(3 downto 0);  
	
	signal ora_out_1 :  std_logic_vector(3 downto 0); 
	signal ora_out_0 :  std_logic_vector(3 downto 0);
	signal minut_out_1 :  std_logic_vector(3 downto 0); 
	signal minut_out_0 : std_logic_vector(3 downto 0);
	
component Ceas is
port (clk : in std_logic;  
	reset : in std_logic;
	ora_in_1 : in std_logic_vector(1 downto 0); 
	ora_in_0 : in std_logic_vector(3 downto 0);
	minut_in_1 : in std_logic_vector(3 downto 0); 
	minut_in_0 : in std_logic_vector(3 downto 0);  
	
	ora_out_1 : out std_logic_vector(3 downto 0); 
	ora_out_0 : out std_logic_vector(3 downto 0);
	minut_out_1 : out std_logic_vector(3 downto 0); 
	minut_out_0 : out std_logic_vector(3 downto 0));
end component;

begin 
	
	ora_curenta : entity work.Ceas port map (clk => clk,reset=>reset,ora_in_1 => ora_in_1,ora_in_0=>ora_in_0,minut_in_1=>minut_in_1,minut_in_0=>minut_in_0,ora_out_1=>ora_out_1,ora_out_0=>ora_out_0);
	
	zi <= ziua_curenta;
	luna <= luna_curenta;
	an <= an_curent;
	
    process (clk, ora_in_1,ora_in_0)
    begin 
        if (clk'event and clk = '1') then
            if (to_integer(unsigned(ora_in_1))=2 and to_integer(unsigned(ora_in_0))=3) then 
                ziua_curenta <= ziua_curenta + 1;
                
				if (ziua_curenta = numar_zile) then 
                    ziua_curenta <= 1;
                    luna_curenta <= luna_curenta + 1 ;
                    
					if (luna_curenta + 1 = 13) then 
                        luna_curenta <= 1 ;
                        an_curent <= an_curent + 1;
                        
						if (an_curent = 2100) then 
                            an_curent <= 2020;
                        end if;
						
                    end if;
                
				end if;	 
				
            end if;
			
        end if;
    end process;      
end architecture;