library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_1_1 is
    Port ( 
        sw : in std_logic_vector(15 downto 0) ;
        led : out std_logic_vector(15 downto 0)
    );
end project_1_1;

architecture behavioral of project_1_1 is
begin
    led(15 downto 0) <= sw(15 downto 0);
end behavioral;
