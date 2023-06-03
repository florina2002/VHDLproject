library ieee;
use ieee.std_logic_1164.all; 

entity Afisare_Litera is
port (litera : in std_logic_vector(3 downto 0); 

	cod_7_segment : out std_logic_vector(6 downto 0));
end entity;	

architecture Arh_Afisare_Litera of Afisare_Litera is 

type segment_type is array (0 to 9) of std_logic_vector(6 downto 0);

signal cod_out : segment_type := ("0001000", "1000010", "1001111", "1000011",
			"1110001", "0101011", "1100010", "0100100", "1000001", "1100011");
			
begin
	process(litera)
	begin	   
		case litera is
				when "0000" => cod_7_segment <= cod_out(0); 	-- A
				when "0001" => cod_7_segment <= cod_out(1); 	-- d 
				when "0010" => cod_7_segment <= cod_out(2); 	-- I
				when "0011" => cod_7_segment <= cod_out(3); 	-- J
				when "0100" => cod_7_segment <= cod_out(4); 	-- L
				when "0101" => cod_7_segment <= cod_out(5); 	-- M 
				when "0110" => cod_7_segment <= cod_out(6); 	-- o
				when "0111" => cod_7_segment <= cod_out(7); 	-- S 
				when "1000" => cod_7_segment <= cod_out(8); 	-- U
				when "1001" => cod_7_segment <= cod_out(9); 	-- v  
				when others => cod_7_segment <= "1111111";  	-- toate segmentele dezactivate
			end case;																		   
		
	end process;
end architecture;