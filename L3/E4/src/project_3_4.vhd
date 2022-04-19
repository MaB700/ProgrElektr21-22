library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity project_3_4 is
    port (
        CLK : in std_logic;
        BTN : in std_logic;
        C : out std_logic_vector (7 downto 0);
        A : out std_logic_vector (3 downto 0)
    );

end project_3_4;

architecture Behavioral of project_3_4 is
    signal edge : std_logic;
    signal counter : unsigned(13 downto 0) := (others => '0');
begin

    edge_detector : entity work.edge_detector
        port map(
            CLK => CLK,
            I => BTN,
            EDGE => edge
        );

    display : entity work.display_wrapper
        port map(
            CLK => CLK,
            BINARY => std_logic_vector(counter),
            SEG => C(6 downto 0),
            DP => C(7),
            AN => A
        );

    process (CLK) begin
        if rising_edge(CLK) then
            if edge = '1' then -- use the debounced button signal as trigger to increase the counter
                counter <= counter + 1;
            end if;
        end if;
    end process;

end Behavioral;