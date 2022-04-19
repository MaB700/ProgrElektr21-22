library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_2_3_1 is
    port (
        SW : in std_logic_vector (7 downto 0);
        C : out std_logic_vector (7 downto 0);
        A : out std_logic_vector (3 downto 0)
    );
end project_2_3_1;

architecture Behavioral of project_2_3_1 is
begin
    project_2_3_2 : entity work.project_2_3_2
        port map(
            I => SW, -- input 2 hex numbers forming a ASCII char
            C => C -- corresponding SEG7
        );
    A <= "1110";
end Behavioral;