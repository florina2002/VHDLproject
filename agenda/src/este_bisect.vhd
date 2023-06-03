library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
	  
entity Este_Bisect is
port (clk : in std_logic;  
	reset : in std_logic;
	an_in_1 : in std_logic_vector(3 downto 0); 
	an_in_0 : in std_logic_vector(3 downto 0);	
	
	bisect : out std_logic);
end entity;	   

architecture Arh_Este_Bisect of Este_Bisect is

signal an : integer := 0;	 
signal an_final : integer := 0;

begin
	process(clk, reset)
	begin
	if reset = '0' then 
		an <= to_integer(unsigned(an_in_1)) * 10 + to_integer(unsigned(an_in_0)); 
		an_final <= 2000 + an;
	elsif rising_edge(clk) then
		if (((an_final mod 4 = 0) and (an_final mod 100 /= 0)) or (an_final mod 400 = 0)) then
			bisect <= '1';
		else
			bisect <= '0';
		end if;
	end if;
	
	end process;
end architecture;
	