library ieee;
use ieee.std_logic_1164.all; 

entity Afisare_Cifra is
port (cifra : in std_logic_vector(3 downto 0); 

	cod_7_segment : out std_logic_vector(6 downto 0));
end entity;	

architecture Arh_Afisare_Cifra of Afisare_Cifra is 

type segment_type is array (0 to 9) of std_logic_vector(6 downto 0);

signal cod_out : segment_type := ("0000001", "1001111", "0010010", "0000110", 
			"1001100", "0100100", "0100000", "0001111", "0000000", "0000100");
			
begin
	process(cifra)
	begin
		case cifra is
			when "0000" => cod_7_segment <= cod_out(0); 	-- 0 
			when "0001" => cod_7_segment <= cod_out(1); 	-- 1 
			when "0010" => cod_7_segment <= cod_out(2); 	-- 2
			when "0011" => cod_7_segment <= cod_out(3); 	-- 3
			when "0100" => cod_7_segment <= cod_out(4); 	-- 4
			when "0101" => cod_7_segment <= cod_out(5); 	-- 5 
			when "0110" => cod_7_segment <= cod_out(6); 	-- 6
			when "0111" => cod_7_segment <= cod_out(7); 	-- 7 
			when "1000" => cod_7_segment <= cod_out(8); 	-- 8
			when "1001" => cod_7_segment <= cod_out(9); 	-- 9  
			when others => cod_7_segment <= "1111111";  	-- toate segmentele dezactivate
		end case; 
		
	end process;
end architecture;