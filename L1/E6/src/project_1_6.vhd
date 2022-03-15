library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity project_1_6 is
    port(
        A : in std_logic_vector (7 downto 0);
        B : in std_logic_vector (7 downto 0);
        S : out std_logic_vector (8 downto 0)
    );
end project_1_6;

architecture Behavioral of project_1_6 is
begin
    S <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B)); 
    -- need to add extra bit to be able to calculate the possible overflow from only A + B
    -- unsinged in order to tell the + operator to add A and B as unsigned bit vector
end Behavioral;
