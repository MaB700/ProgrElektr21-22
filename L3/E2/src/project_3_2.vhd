library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_3_2 is
    port (
        CLK : in std_logic;
        SW : in std_logic_vector (13 downto 0);
        C : out std_logic_vector (7 downto 0);
        A : out std_logic_vector (3 downto 0)
    );
end project_3_2;

architecture Behavioral of project_3_2 is

begin
    display : entity work.display_wrapper
        port map(
            CLK => CLK,
            BINARY => SW, -- input in binary from switches
            SEG => C(6 downto 0), -- SEG7
            DP => C(7), -- dot
            AN => A -- display element
        );
end Behavioral;