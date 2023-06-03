library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Ceas is
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
end entity;

architecture Arch_Ceas of Ceas is
signal sec, min : integer range 0 to 61 := 0;
signal h : integer range 0 to 25 := 0;  

signal ora_aux_1 : std_logic_vector(3 downto 0); 
signal minut_aux_1 : std_logic_vector(3 downto 0); 

begin 	
	process(clk, reset)
	begin
	if reset = '0' then 
		h <= to_integer(unsigned(ora_in_1)) * 10 + to_integer(unsigned(ora_in_0));
		min <= to_integer(unsigned(minut_in_1)) * 10 + to_integer(unsigned(minut_in_0));
		sec <= 0; 
	elsif rising_edge(clk) then
       sec <= sec + 1;
       if (sec >= 59) then 
       		min <= min + 1 ;
            sec <= 0 ;
            if (min >= 59) then 
                h <= h + 1;
                min <= 0;
                if (h  >= 24) then
                 	h <= 0;
                end if;
           	end if ;
       end if;                  
    end if;
	
	if h >= 20 then 
		ora_out_1 <= x"2";
		ora_aux_1 <= x"2";
	elsif h >= 10 then
		ora_out_1 <= x"1"; 
		ora_aux_1 <= x"1";
	else
		ora_out_1 <= x"0"; 
		ora_aux_1 <= x"0";
	end if;	
	
	if (h < 10) then 
		ora_out_0 <= std_logic_vector(to_unsigned(h, 4));
	else
		ora_out_0 <= std_logic_vector(to_unsigned((h - to_integer(unsigned(ora_aux_1)) * 10), 4));  
	end if;  
	
	if min >= 50 then
		minut_out_1 <= x"5";
		minut_aux_1 <= x"5";
	elsif min >= 40 then
		minut_out_1 <= x"4";
		minut_aux_1 <= x"4";	
	elsif min >= 30 then
		minut_out_1 <= x"3";
		minut_aux_1 <= x"3"; 
	elsif min >= 20 then
		minut_out_1 <= x"2";
		minut_aux_1 <= x"2";
	elsif min >= 10 then
		minut_out_1 <= x"1";
		minut_aux_1 <= x"1";
	else
		minut_out_1 <= x"0";
		minut_aux_1 <= x"0";
	end if;    
																						   
	if (min < 10) then 
		minut_out_0 <= std_logic_vector(to_unsigned(min, 4));
	else
		minut_out_0 <= std_logic_vector(to_unsigned((min - to_integer(unsigned(minut_aux_1)) * 10), 4));  
	end if;
	
	end process;
end architecture;