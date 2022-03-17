library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_4_4_3 is
    Port ( 
        CLK : in std_logic;
        SW : in std_logic_vector(31 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0)
    );
end project_4_4_3;

architecture Behavioral of project_4_4_3 is

begin
    Display : entity work.project_4_4_3_1
    port map (
        CLK => CLK,
        SW => SW,
        C => C, 
        A => A
    );
    
    
    
end Behavioral;