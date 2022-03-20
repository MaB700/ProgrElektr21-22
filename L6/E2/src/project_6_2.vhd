library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_6_2 is
Port (
    CLK : in std_logic;
    SW : in std_logic_vector(15 downto 0);
    SPK : out std_logic
);

end project_6_2;

architecture Behavioral of project_6_2 is

begin
    
    freq_changer : entity work.Frequency_Generator
    port map (
        CLK => CLK,
        FREQ => SW,
        SND => SPK
    );

end Behavioral;
