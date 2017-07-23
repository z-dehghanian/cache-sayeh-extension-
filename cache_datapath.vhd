library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity cache_datapath is port(
    clk, readmem, writemem,wr_en_dataArray0,wr_en_dataArray1,wr_en_tag0,reset,wr_en_tag1 : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : out std_logic_vector (15 downto 0);
		databus1 : in std_logic_vector (15 downto 0);
		write,hit_cache,valid0,valid1 : out std_logic 

); end entity ;

architecture func of cache_datapath is
  component dataArray is port (

  clk,wr_en : in std_logic;
  address : in std_logic_vector(5 downto 0 ) ;
  wr_data: in std_logic_vector(15 downto 0 ) ; 
  data : out std_logic_vector(15 downto 0 )

);
end component ;

component missHitLogic is port (

  hit,w0_valid,w1_valid : out std_logic;
 -- address : in std_logic_vector(5 downto 0 ) ;
  tag: in std_logic_vector(3 downto 0 ) ; 
  w0,w1 : in std_logic_vector(4 downto 0 )

);
end component ;
component MRU is port (
  w0_valid,w1_valid,hit,reset : in std_logic;
  address : in std_logic_vector(5 downto 0 ) ;
  write : out std_logic

);
end component ;
component memory is
	generic (blocksize : integer := 1024);

	port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus: out std_logic_vector (15 downto 0);
		databus1 : in std_logic_vector (15 downto 0);
		memdataready : out std_logic);
end component;
component tagValidArray is port (

   clk,reset,wr_en,invalidate : in std_logic;
  address : in std_logic_vector(5 downto 0 ) ;
  wr_data: in std_logic_vector(3 downto 0 ) ; 
  data : out std_logic_vector(4 downto 0 );
  valid : out std_logic
);
end component ;
signal hit,zeroSignal,rm,w0_valid1,w1_valid1,valid00,valid11 : std_logic ;
signal data0,data1,databus_mem : std_logic_vector(15 downto 0 ); 
signal w0,w1 :std_logic_vector(4 downto 0 ); 
begin 
  zeroSignal <= '0' ;
  memory0 : memory port map (clk,readmem,writemem,addressbus,databus_mem,databus1,rm);
  dataArray0 : dataArray port map(clk,wr_en_dataArray0,addressbus(5 downto 0 ) ,databus_mem,data0);
  dataArray1 : dataArray port map(clk,wr_en_dataArray1,addressbus(5 downto 0 ) ,databus_mem,data1);
  tagValid0 : tagValidArray port map (clk ,reset,wr_en_tag0,zeroSignal,addressbus(5 downto 0 ),addressbus(9 downto 6 ),w0,valid00);
  tagValid1 : tagValidArray port map (clk ,reset,wr_en_tag1,zeroSignal,addressbus(5 downto 0 ),addressbus(9 downto 6 ),w1,valid11);
  missHitLogic0 : missHitLogic port map (hit,w0_valid1,w1_valid1,addressbus(9 downto 6 ),w0,w1);
  MRU0 : MRU port map (w0_valid1,w1_valid1,hit,reset,addressbus(5 downto 0),write);
    valid1<=valid11;
    valid0<=valid00;
  hit_cache <= hit ;
  process(clk)
  begin 
   if(hit ='1' and w1_valid1='1')then databus <= data1; --if(writemem='1')then wr_en_dataArray1<='1';end if ;
   elsif(hit ='1' and w0_valid1='1')then databus <= data0 ; --if(writemem='1')then wr_en_dataArray0<='1';end if ;
 else databus <= databus_mem ;
   
 end if ;
 end process ;   

  
end func ;