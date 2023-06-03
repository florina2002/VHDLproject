library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Calendar is
   port(clk : in std_logic;	
	 reset : in std_logic;
	 ora_1 : in std_logic_vector(3 downto 0); 
	 ora_0 : in std_logic_vector(3 downto 0);
	 numar_zile_1 : in std_logic_vector(3 downto 0); 
	 numar_zile_0 : in std_logic_vector(3 downto 0);
	 zi_in_1 : in std_logic_vector(1 downto 0); 
	 zi_in_0 : in std_logic_vector(3 downto 0);
	 luna_in_1 : in std_logic_vector(1 downto 0); 
	 luna_in_0 : in std_logic_vector(3 downto 0);
	 an_in_1 : in std_logic_vector(3 downto 0); 
	 an_in_0 : in std_logic_vector(3 downto 0);
	 ziua_din_saptamana_in : in std_logic_vector(3 downto 0);
	 
	 zi_out_1 : out std_logic_vector(3 downto 0); 
	 zi_out_0 : out std_logic_vector(3 downto 0);
	 luna_out_1 : out std_logic_vector(3 downto 0); 
	 luna_out_0 : out std_logic_vector(3 downto 0);
	 an_out_1 : out std_logic_vector(3 downto 0); 
	 an_out_0 : out std_logic_vector(3 downto 0);
	 ziua_din_saptamana_out : out std_logic_vector(3 downto 0));
end entity;

architecture Arh_Calendar of Calendar is
signal ora : integer range 0 to 100 := 0; 
signal numar_zile : integer range 0 to 32 := 1;
signal ziua : integer range 1 to 100 := 1;
signal luna : integer range 1 to 13 := 1;
signal an : integer range 20 to 99 := 20;  
signal ziua_din_sapt : integer range 0 to 7 := 0;

signal ora_aux_1 : std_logic_vector(3 downto 0); 
signal zi_aux_1 : std_logic_vector(3 downto 0); 
signal luna_aux_1 : std_logic_vector(3 downto 0); 
signal an_aux_1 : std_logic_vector(3 downto 0);  

begin
    process(clk, reset)
    begin 
        if reset = '0' then
			ora <= to_integer(unsigned(ora_1)) * 10 + to_integer(unsigned(ora_0)); 
			numar_zile <= to_integer(unsigned(numar_zile_1)) * 10 + to_integer(unsigned(numar_zile_0));
			ziua <= to_integer(unsigned(zi_in_1)) * 10 + to_integer(unsigned(zi_in_0)); 
			luna <= to_integer(unsigned(luna_in_1)) * 10 + to_integer(unsigned(luna_in_0));
			an <= to_integer(unsigned(an_in_1)) * 10 + to_integer(unsigned(an_in_0));
			ziua_din_sapt <= to_integer(unsigned(ziua_din_saptamana_in));
		elsif rising_edge(clk) then
	            if (ora = 1) then 
	                ziua <= ziua + 1 ;	 
					ziua_din_sapt <= ziua_din_sapt + 1;
					
					if (ziua_din_sapt >= 6)	then
						ziua_din_sapt <= 0;
					end if;
					
	                if (ziua = numar_zile + 1) then 
	                    ziua <= 1;			
	                    luna <= luna + 1 ;
	                    if (luna >= 13) then 
	                        luna <= 1 ;
	                        an <= an + 1;
	                        if (an = 99) then 
	                            an <= 20;
	                        end if;
	                    end if;
	                end if;
	            end if;	 
        end if;
		
		if ziua >= 20 then 
			zi_out_1 <= x"2";
			zi_aux_1 <= x"2";
		elsif ziua >= 10 then
			zi_out_1 <= x"1"; 
			zi_aux_1 <= x"1";
		else
			zi_out_1 <= x"0"; 
			zi_aux_1 <= x"0";
		end if;		   

		if (ziua < 10) then 
			zi_out_0 <= std_logic_vector(to_unsigned(ziua, 4));
		else
			zi_out_0 <= std_logic_vector(to_unsigned((ziua - to_integer(unsigned(zi_aux_1)) * 10), 4));  
		end if;  
	
		if luna >= 10 then 
			luna_out_1 <= x"1";
			luna_aux_1 <= x"1";
		else
			luna_out_1 <= x"0"; 
			luna_aux_1 <= x"0";
		end if;
		
		if (luna < 10) then 
			luna_out_0 <= std_logic_vector(to_unsigned(luna, 4));
		else
			luna_out_0 <= std_logic_vector(to_unsigned((luna - to_integer(unsigned(luna_aux_1)) * 10), 4));  
		end if;	
		
		if an >= 90 then 
			an_out_1 <= x"9";
			an_aux_1 <= x"9";
		elsif an >= 80 then
			an_out_1 <= x"8"; 
			an_aux_1 <= x"8";
		elsif an >= 70 then
			an_out_1 <= x"7"; 
			an_aux_1 <= x"7";
		elsif an >= 60 then
			an_out_1 <= x"6"; 
			an_aux_1 <= x"6";
		elsif an >= 50 then
			an_out_1 <= x"5"; 
			an_aux_1 <= x"5";	
		elsif an >= 40 then
			an_out_1 <= x"4"; 
			an_aux_1 <= x"4";
		elsif an >= 30 then
			an_out_1 <= x"3"; 
			an_aux_1 <= x"3"; 
		elsif an >= 20 then
			an_out_1 <= x"2"; 
			an_aux_1 <= x"2";
		end if;
		
		an_out_0 <= std_logic_vector(to_unsigned((an - to_integer(unsigned(an_aux_1)) * 10), 4)); 
		
		ziua_din_saptamana_out <= std_logic_vector(to_unsigned(ziua_din_sapt, 4));
		
    end process;      
end architecture;