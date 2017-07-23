library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity MRU is port (

  w0_valid,w1_valid,hit,reset : in std_logic;
  address : in std_logic_vector(5 downto 0 ) ;
  write : out std_logic

);
end entity ;

architecture func of MRU is
    signal ArrayZ : std_logic_vector(63 downto 0 ) ;
    begin
      process(hit,reset)
        begin
      
        if(reset ='1') then 
          ArrayZ <= ("0000000000000000000000000000000000000000000000000000000000000000");
        elsif(hit ='1') then
       ArrayZ(to_integer(unsigned(address))) <=( (not w0_valid ) and w1_valid);
      end if;
      end process;
      write <= ArrayZ(to_integer(unsigned(address))) ;
  
end func ;