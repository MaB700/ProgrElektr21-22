library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_2_2 is
  Port ( 
        I : in std_logic_vector (3 downto 0);
        C : out std_logic_vector (7 downto 0)
        );
end project_2_2;

architecture Behavioral of project_2_2 is

begin
    
    with I select C <=  
        b"1100_0000" when x"0" ,
        b"1111_1001" when x"1" ,
        b"1010_0100" when x"2" ,
        b"1011_0000" when x"3" ,
        b"1001_1001" when x"4" ,
        b"1001_0010" when x"5" ,
        b"1000_0010" when x"6" ,
        b"1101_1000" when x"7" ,
        b"1000_0000" when x"8" ,
        b"1001_0000" when x"9" ,
        b"1000_1000" when x"A" ,
        b"1000_0011" when x"B" ,
        b"1010_0111" when x"C" ,
        b"1010_0001" when x"D" ,
        b"1000_0110" when x"E" ,
        b"1000_1110" when x"F" ;
        

end Behavioral;
