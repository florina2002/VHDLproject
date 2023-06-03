library ieee;
use ieee.std_logic_1164.all; 

entity agenda_de_birou is
port (clock : in std_logic;
	reset : in std_logic;
	ora_zeci : in std_logic_vector(1 downto 0);
	ora_unit : in std_logic_vector(3 downto 0);	 
	min_zeci : in std_logic_vector(3 downto 0);	 
	min_unit : in std_logic_vector(3 downto 0);	
	zi_zeci : in std_logic_vector(1 downto 0);	 
	zi_unit : in std_logic_vector(3 downto 0);	
	luna_zeci : in std_logic_vector(1 downto 0);   
	luna_unit : in std_logic_vector(3 downto 0);	
	an_1 : in std_logic_vector(3 downto 0);	 
	an_2 : in std_logic_vector(3 downto 0);	  
	ziua_din_saptamana : in std_logic_vector(3 downto 0); 
	al_ora_zeci : in std_logic_vector(1 downto 0);
	al_ora_unit : in std_logic_vector(3 downto 0);	 
	al_min_zeci : in std_logic_vector(3 downto 0);	 
	al_min_unit : in std_logic_vector(3 downto 0);	 
	al_on : in std_logic;
	temp_1 : in std_logic_vector(3 downto 0);	
	temp_2 : in std_logic_vector(3 downto 0);
	
	ora_zeci_out : out std_logic_vector(6 downto 0);
	ora_unit_out : out std_logic_vector(6 downto 0); 
	min_zeci_out : out std_logic_vector(6 downto 0);	 
	min_unit_out : out std_logic_vector(6 downto 0);	
	zi_zeci_out : out std_logic_vector(6 downto 0);	 
	zi_unit_out : out std_logic_vector(6 downto 0);	
	luna_zeci_out : out std_logic_vector(6 downto 0);   
	luna_unit_out : out std_logic_vector(6 downto 0);	
	an_1_out : out std_logic_vector(6 downto 0);	 
	an_2_out : out std_logic_vector(6 downto 0);  
	zi_lit_1 : out std_logic_vector(6 downto 0); 
	zi_lit_2 : out std_logic_vector(6 downto 0);
	alarma : out std_logic_vector(6 downto 0);
	temp_1_out : out std_logic_vector(6 downto 0);
	temp_2_out : out std_logic_vector(6 downto 0));
end entity;			 

architecture Arh_Agenda_Programabila of agenda_de_birou is

signal ora_zeci_aux : std_logic_vector(3 downto 0);
signal ora_unit_aux : std_logic_vector(3 downto 0);	 
signal min_zeci_aux : std_logic_vector(3 downto 0);	 
signal min_unit_aux : std_logic_vector(3 downto 0);	
signal zi_zeci_aux : std_logic_vector(3 downto 0); 	 
signal zi_unit_aux : std_logic_vector(3 downto 0); 	
signal luna_zeci_aux : std_logic_vector(3 downto 0); 
signal luna_unit_aux : std_logic_vector(3 downto 0);	
signal an_1_aux : std_logic_vector(3 downto 0);	 
signal an_2_aux : std_logic_vector(3 downto 0);	  
signal ziua_din_saptamana_aux : std_logic_vector(3 downto 0);  

signal bisect : std_logic; 
signal numar_de_zile_zeci : std_logic_vector(3 downto 0);	
signal numar_de_zile_unit : std_logic_vector(3 downto 0);	
signal alarma_aux : std_logic_vector(3 downto 0);
signal zi_lit_1_aux : std_logic_vector(3 downto 0);
signal zi_lit_2_aux : std_logic_vector(3 downto 0);

begin
	ora_si_minut : entity work.Ceas port map(clk => clock, 
		reset => reset, 
		ora_in_1 => ora_zeci,  
		ora_in_0 => ora_unit,
		minut_in_1 => min_zeci,  
		minut_in_0 => min_unit,
		ora_out_1 => ora_zeci_aux,  
		ora_out_0 => ora_unit_aux,
		minut_out_1 => min_zeci_aux,  
		minut_out_0 => min_unit_aux);	
		
	este_bisect : entity work.Este_Bisect port map(clk => clock,
		reset => reset,
		an_in_1 => an_1,
		an_in_0 => an_2, 
		bisect => bisect);	   
	
	zile_din_luna : entity work.Numar_Zile_Din_Luna port map(clk => clock, 
		reset => reset,
		luna_1 => luna_zeci,  
		luna_0 => luna_unit,
		este_bisect => bisect,
		numar_de_zile_1 => numar_de_zile_zeci,
		numar_de_zile_0 => numar_de_zile_unit); 
		
	ziua_luna_si_anul : entity work.Calendar port map(clk => clock, 
		reset => reset,
		ora_1 => ora_zeci_aux,
		ora_0 => ora_unit_aux,
		numar_zile_1 => numar_de_zile_zeci,
		numar_zile_0 => numar_de_zile_unit,
		zi_in_1 => zi_zeci,
		zi_in_0 => zi_unit,
		luna_in_1 => luna_zeci,
		luna_in_0 => luna_unit,
		an_in_1 => an_1,
		an_in_0 => an_2, 
		ziua_din_saptamana_in => ziua_din_saptamana,
		zi_out_1 =>	zi_zeci_aux,
		zi_out_0 => zi_unit_aux,
		luna_out_1 => luna_zeci_aux,
		luna_out_0 => luna_unit_aux,   
		an_out_1 =>	an_1_aux,
		an_out_0 => an_2_aux,
		ziua_din_saptamana_out => ziua_din_saptamana_aux);	
		
	timer_alarma : entity work.Timer_Alarma port map(clk => clock,
		reset => reset,
		al_on => al_on,
		ora_in_1 => ora_zeci_aux,
		ora_in_0 => ora_unit_aux,
		minut_in_1 => min_zeci_aux,
		minut_in_0 => min_unit_aux,
		al_ora_in_1 => al_ora_zeci,
		al_ora_in_0 => al_ora_unit,
		al_minut_in_1 => al_min_zeci,
		al_minut_in_0 => al_min_unit,
		alarma => alarma_aux);		 
	
	coduri_zi_din_saptamana : entity work.Ziua_Din_Saptamana_Litere port map(clk => clock,
		reset => reset,
		numarul_zilei => ziua_din_saptamana_aux,
		zi_lit_1 =>	zi_lit_1_aux,
		zi_lit_0 => zi_lit_2_aux);
		
	
	cod_ora_zeci_out : entity work.Afisare_Cifra port map(cifra => ora_zeci_aux, cod_7_segment => ora_zeci_out);
	cod_ora_unit_out : entity work.Afisare_Cifra port map(cifra => ora_unit_aux, cod_7_segment => ora_unit_out);
	cod_min_zeci_out : entity work.Afisare_Cifra port map(cifra => min_zeci_aux, cod_7_segment => min_zeci_out);	 
	cod_min_unit_out : entity work.Afisare_Cifra port map(cifra => min_unit_aux, cod_7_segment => min_unit_out);
		
	cod_zi_zeci_out : entity work.Afisare_Cifra port map(cifra => zi_zeci_aux, cod_7_segment => zi_zeci_out); 
	cod_zi_unit_out : entity work.Afisare_Cifra port map(cifra => zi_unit_aux, cod_7_segment => zi_unit_out);
	cod_luna_zeci_out : entity work.Afisare_Cifra port map(cifra => luna_zeci_aux, cod_7_segment => luna_zeci_out);   
	cod_luna_unit_out : entity work.Afisare_Cifra port map(cifra => luna_unit_aux, cod_7_segment => luna_unit_out);	
	cod_an_1_out : entity work.Afisare_Cifra port map(cifra => an_1_aux, cod_7_segment => an_1_out); 
	cod_an_2_out : entity work.Afisare_Cifra port map(cifra => an_2_aux, cod_7_segment => an_2_out); 	
		
	cod_zi_lit_1 : entity work.Afisare_Litera port map(litera => zi_lit_1_aux, cod_7_segment => zi_lit_1);	
	cod_zi_lit_2 : entity work.Afisare_Litera port map(litera => zi_lit_2_aux, cod_7_segment => zi_lit_2);
		
	cod_alarma : entity work.Afisare_Cifra port map(cifra => alarma_aux, cod_7_segment => alarma);	 
		
	cod_temp_1_out : entity work.Afisare_Cifra port map(cifra => temp_1, cod_7_segment => temp_1_out);
	cod_temp_2_out : entity work.Afisare_Cifra port map(cifra => temp_2, cod_7_segment => temp_2_out);
	
end architecture;