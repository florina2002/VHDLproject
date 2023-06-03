library	ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Numar_Zile_Din_Luna is
port (clk : in std_logic;
	reset : in std_logic;
	luna_1 : in std_logic_vector(1 downto 0);  
	luna_0 : in std_logic_vector(3 downto 0);
	este_bisect : in std_logic;					
	
	numar_de_zile_1 : out std_logic_vector(3 downto 0);
	numar_de_zile_0 : out std_logic_vector(3 downto 0));
end entity;

architecture Arh_Numar_Zile_Din_Luna of Numar_Zile_Din_Luna is
 
signal luna : integer := 1;

begin		 
	process(clk, reset)
	begin
		if (reset = '0') then
			luna <= to_integer(unsigned(luna_1)) * 10 + to_integer(unsigned(luna_0));	 
		elsif rising_edge(clk) then
			if (luna = 2 and este_bisect = '1') then
				numar_de_zile_1 <= x"2";   
				numar_de_zile_0 <= x"9";
			elsif (luna = 2 and este_bisect = '0') then
				numar_de_zile_1 <= x"2";   
				numar_de_zile_0 <= x"8";
			elsif (luna = 4 or luna = 6 or luna = 9 or luna = 11) then
				numar_de_zile_1 <= x"3";   
				numar_de_zile_0 <= x"0";
			else
				numar_de_zile_1 <= x"3";   
				numar_de_zile_0 <= x"1";
			end if;
		end if;	   
		
	end process;
end architecture;