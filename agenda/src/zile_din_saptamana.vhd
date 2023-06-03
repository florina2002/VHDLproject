library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

entity Ziua_Din_Saptamana_Litere is
port(clk : in std_logic; 
	reset : in std_logic;
	numarul_zilei : in std_logic_vector(3 downto 0);
	
	zi_lit_1 : out std_logic_vector(3 downto 0);   
	zi_lit_0 : out std_logic_vector(3 downto 0));
end entity;	 

architecture Arh_Ziua_Din_Saptamana_Litere of Ziua_Din_Saptamana_Litere is	 

signal nr_zi : integer := 0;

begin
	process(clk, reset)
	begin
		if reset = '0' then
			nr_zi <= to_integer(unsigned(numarul_zilei));
		elsif rising_edge(clk) then
			case nr_zi is
				when 0 => 
					zi_lit_1 <= x"2";	--d
					zi_lit_0 <= x"9";	--u
				when 1 =>
					zi_lit_1 <= x"5";	--l
					zi_lit_0 <= x"9"; 	--u
				when 2 =>
					zi_lit_1 <= x"6";	--m
					zi_lit_0 <= x"0";	--a
				when 3 =>
					zi_lit_1 <= x"6";	--m
					zi_lit_0 <= x"3";  	--i	
				when 4 =>
					zi_lit_1 <= x"4";	--j
					zi_lit_0 <= x"7";	--o
				when 5 =>
					zi_lit_1 <= x"A";	--v
					zi_lit_0 <= x"3";	--i
				when 6 =>
					zi_lit_1 <= x"8";	--s
					zi_lit_0 <= x"0";	--a	
				when others => 
					zi_lit_1 <= x"C";	--altele	
					zi_lit_0 <= x"C";	--altele
			end case;
		end if;	 
		
	end process;
end architecture;