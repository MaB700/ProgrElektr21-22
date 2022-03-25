library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_4_4_test is
    Port ( 
        CLK : in std_logic; 
        I : in std_logic_vector(13 downto 0);
        MODE : in std_logic_vector(1 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0)
    );
end project_4_4_test;

architecture Behavioral of project_4_4_test is

begin
    
    test : entity work.project_4_4
    port map (
        CLK => CLK,
        I(13 downto 0) => I,
        I(31 downto 14) => (others=>'0'),
        MODE => MODE,
        C => C,
        A => A
    );

end Behavioral;
