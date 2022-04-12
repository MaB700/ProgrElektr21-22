library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_4_1 is
    port (
        CLK : in std_logic;
        SW : in std_logic_vector(15 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0)
    );
end project_4_1;

architecture Behavioral of project_4_1 is
    signal wire_C0, wire_C1, wire_C2, wire_C3 : std_logic_vector(7 downto 0); -- outputs from each display_i entity
begin
    multiplex_C : entity work.project_4_1_1
        port map(
            CLK => CLK,
            C0 => wire_C0, -- constantly providing all 4 wire signals, the multiplexer then decides which
            C1 => wire_C1, -- wire_Ci signal to forward into C
            C2 => wire_C2,
            C3 => wire_C3,
            C => C,
            A => A
        );

    display_0 : entity work.project_2_2
        port map(
            I => SW(3 downto 0),
            C => wire_C0
        );

    display_1 : entity work.project_2_2
        port map(
            I => SW(7 downto 4),
            C => wire_C1
        );

    display_2 : entity work.project_2_2
        port map(
            I => SW(11 downto 8),
            C => wire_C2
        );

    display_3 : entity work.project_2_2
        port map(
            I => SW(15 downto 12),
            C => wire_C3
        );

end Behavioral;