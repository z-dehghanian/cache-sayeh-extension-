library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity dataArray is port (

  clk,wr_en : in std_logic;
  address : in std_logic_vector(5 downto 0 ) ;
  wr_data: in std_logic_vector(15 downto 0 ) ; 
  data : out std_logic_vector(15 downto 0 )

);
end entity ;

architecture func of dataArray is
  type dataArr is array (63 downto 0) of std_logic_vector (15 downto 0);
   signal dataArrayZ : dataArr;
    begin
      data <= dataArrayZ(to_integer(unsigned(address)));
      process(clk)
      begin
        if(wr_en = '1') then
            dataArrayZ(to_integer(unsigned(address))) <= wr_data;
        end if;

      end process;
  
  
  
end func ;