library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_2_2_1 is
    port (
        SW : in std_logic_vector (7 downto 0);
        C : out std_logic_vector (7 downto 0);
        A : out std_logic_vector (3 downto 0)
    );
end project_2_2_1;

architecture Behavioral of project_2_2_1 is
begin
    project_2_2 : entity work.project_2_2
        port map(
            I => SW(3 downto 0), -- only use 4 switches to input 1 hex number
            C => C -- output from the entity is the 7 segment representation (appendix B)
        );
    A <= "1110";
end Behavioral;