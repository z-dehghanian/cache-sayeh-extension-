library IEEE;
use IEEE.std_logic_1164.all;

entity cache is
	port (clk,writemem,reset : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : out std_logic_vector (15 downto 0);
		databus1 : in std_logic_vector (15 downto 0);
		memdataready : out std_logic);

end entity ;

architecture rtl of cache is 
component cache_controller is
	port ( dataIsReady,wr_en_dataArray0,wr_en_dataArray1,wr_en_tag0,wr_en_tag1,readmem : out std_logic;
	       hit,write,reset,clk,valid0,valid1,writemem : in std_logic );
end component;
component cache_datapath is port(
    clk, readmem, writemem,wr_en_dataArray0,wr_en_dataArray1,wr_en_tag0,reset,wr_en_tag1 : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : out std_logic_vector (15 downto 0);
		databus1 : in std_logic_vector (15 downto 0);
		write,hit_cache,valid0,valid1 : out std_logic 

); end component ;
signal dataIsReady,readmem,wr_en_dataArray0,wr_en_dataArray1,wr_en_tag0,wr_en_tag1,write,hit,valid00,valid11 :std_logic;
 begin
   z0 : cache_datapath port map (clk,readmem,writemem,wr_en_dataArray0,wr_en_dataArray1,wr_en_tag0,reset,wr_en_tag1,addressbus,databus,databus1,write,hit,valid00,valid11 );
   z1 : cache_controller port map (dataIsReady,wr_en_dataArray0,wr_en_dataArray1,wr_en_tag0,wr_en_tag1,readmem,hit,write,reset,clk,valid00,valid11,writemem);    
   memdataready <= dataIsReady ;
end architecture ;