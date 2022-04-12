library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_4_4_0 is
    port (
        CLK : in std_logic;
        INP : in std_logic_vector(31 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0)
    );
end project_4_4_0;

architecture Behavioral of project_4_4_0 is
begin
    multiplex_C : entity work.project_4_1_1
        port map(
            CLK => CLK,
            C0 => INP(7 downto 0), -- direct connection from INP to SEG7+1 display
            C1 => INP(15 downto 8),
            C2 => INP(23 downto 16),
            C3 => INP(31 downto 24),
            C => C,
            A => A
        );
end Behavioral;