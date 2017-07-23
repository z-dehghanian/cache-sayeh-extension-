library IEEE;
use IEEE.std_logic_1164.all;



entity cache_controller is
	port ( dataIsReady,wr_en_dataArray0,wr_en_dataArray1,wr_en_tag0,wr_en_tag1,readmem : out std_logic;
	       hit,write,reset,clk,valid0,valid1,writemem : in std_logic );
end entity;


architecture rtl of cache_controller is
	type state is (S0,S1,S2,FS);
	signal current_state : state;
	signal next_state : state;
	signal m,z,y : std_logic ;
	begin 
	process (clk, reset)
	begin
		if reset = '1' then
			current_state <= S0;
    elsif clk'event and clk = '1' then
			current_state <= next_state;
		end if;
		end process ;	
	process (current_state,hit,clk)
	begin
		case current_state is
			when S0 =>
			  dataIsReady <='0' ;
			  m <= '0' ; z<='0';y<='0';
			  wr_en_dataArray0<='0';wr_en_dataArray1<='0';wr_en_tag0<='0';wr_en_tag1<='0' ;
			--   if hit = '1' and writemem = '0'  then
			  --   next_state <= FS;
			  --elsif (hit = '0' or writemem = '1'  ) then
			   -- readmem<='1';
	       -- next_state <= S1;
		  if ((hit = '0') or (writemem = '1'))  then  readmem<='1';next_state <= S1 ;
			  
		 else
		  next_state <= FS ;
		--   next_tate <= (hit and  FS) or (not hit and s1);
			 end if ;
			when S1 =>
			  readmem <= '1' ;
			  next_state <= S2 ;
			 when S2 =>
			 if ( ( valid0='0' ) ) then m <='1'; wr_en_dataArray0<='1';wr_en_tag0<='1';
       elsif(m ='0' and(valid0='1') and ( valid1='0')) then z<='1'; wr_en_dataArray1<='1';wr_en_tag1<='1' ;
			  elsif (z='0' and m ='0' and write ='0' ) then y<='1'; wr_en_dataArray0<='1';wr_en_tag0<='1';
			  elsif(y='0' and z='0' and m ='0' and write ='1' ) then wr_en_dataArray1<='1';wr_en_tag1<='1' ;
			  end if ;
			  next_state <= FS ;
			  when FS => 
			    dataIsReady <= '1' ;
			    next_state <= S0 ;
		 end case ;
		 end process ;
	end rtl ;