library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity tagValidArray is port (

  clk,reset,wr_en,invalidate : in std_logic;
  address : in std_logic_vector(5 downto 0 ) ;
  wr_data: in std_logic_vector(3 downto 0 ) ; 
  data : out std_logic_vector(4 downto 0 );
  valid : out std_logic
);
end entity ;

architecture func of tagValidArray is 
  type tagArr is array (63 downto 0) of std_logic_vector (4 downto 0);
  signal ArrayZ : tagArr;
    begin
      valid <=ArrayZ(to_integer(unsigned(address)))(4);
      data <= ArrayZ(to_integer(unsigned(address)));
      process(clk)
      begin
        if(wr_en = '1') then
            ArrayZ(to_integer(unsigned(address))) <= '1' & wr_data;
        end if;
        if(reset ='1') then 
          ArrayZ <= (others => "00000");
        end if ;
        if (invalidate = '1') then
          ArrayZ(to_integer(unsigned(address)))(4) <= '0';
        end if ;
      end process;
  
  
 




end func ;