library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_4_3 is
    port (
        CLK : in std_logic;
        SW : in std_logic_vector(15 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0)
    );
end project_4_3;

architecture Behavioral of project_4_3 is
    signal wire_C0, wire_C1, wire_C2, wire_C3 : std_logic_vector(7 downto 0);
begin
    multiplex_C : entity work.project_4_1_1
        port map(
            CLK => CLK,
            C0 => wire_C0,
            C1 => wire_C1,
            C2 => wire_C2,
            C3 => wire_C3,
            C => C,
            A => A
        );

    display_0 : entity work.project_2_3_2 -- display first ASCII symbol on first 2 display segments
        port map(
            I => SW(7 downto 0),
            C => wire_C0
        );

    display_1 : entity work.project_2_3_2
        port map(
            I => SW(7 downto 0), -- alternative: show constant value, e.g. x"00" (empty)
            C => wire_C1
        );

    display_2 : entity work.project_2_3_2 -- display second ASCII symbol on last 2 display segments
        port map(
            I => SW(15 downto 8),
            C => wire_C2
        );

    display_3 : entity work.project_2_3_2
        port map(
            I => SW(15 downto 8), -- alternative: show constant value, e.g. x"00" (empty)
            C => wire_C3
        );

end Behavioral;