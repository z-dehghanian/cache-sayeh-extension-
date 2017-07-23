library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity missHitLogic is port (

  hit,w0_valid,w1_valid : out std_logic;
 -- address : in std_logic_vector(5 downto 0 ) ;
  tag: in std_logic_vector(3 downto 0 ) ; 
  w0,w1 : in std_logic_vector(4 downto 0 )

);
end entity ;

architecture func of missHitLogic is 
  begin 
    process(w0,w1,tag)
      begin
    if((w0(4) = '1') and  (w0(3 downto 0)=tag)) then 
      w0_valid <='1';
      w1_valid <='0';
      hit <= '1' ; 
  elsif((w1(4) = '1') and  (w1(3 downto 0)=tag)) then 
      w1_valid <='1';
      w0_valid <='0';
      hit <= '1' ;
  else 
      w1_valid <='0';
      w0_valid <='0';
      hit <='0' ;
  end if ;
  
end process ;

end func ;