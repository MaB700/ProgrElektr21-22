library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_4_4_1 is
    Port ( 
        CLK : in std_logic;
        INP : in std_logic_vector(31 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0)
    );
end project_4_4_1;

architecture Behavioral of project_4_4_1 is
signal wire_C0, wire_C1, wire_C2, wire_C3 : std_logic_vector(7 downto 0);
begin
    multiplex_C : entity work.project_4_1_1
    port map (
        CLK => CLK,
        C0 => wire_C0,
        C1 => wire_C1,
        C2 => wire_C2,
        C3 => wire_C3,
        C  => C,
        A  => A
    );
    
    display_0 : entity work.project_2_2
    port map (
        I => INP(3 downto 0),
        C => wire_C0
    );
    
    display_1 : entity work.project_2_2
    port map (
        I => INP(7 downto 4),
        C => wire_C1
    );
    
    display_2 : entity work.project_2_2
    port map (
        I => INP(11 downto 8),
        C => wire_C2
    );
    
    display_3 : entity work.project_2_2
    port map (
        I => INP(15 downto 12),
        C => wire_C3
    );

end Behavioral;
