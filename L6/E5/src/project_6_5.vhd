library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_6_5 is
    port (
        CLK : in std_logic;
        DC : in std_logic_vector(7 downto 0); -- 8 switches for DC
        FREQ : in std_logic_vector(13 downto 6); -- 8 switches for freq
        SPK : out std_logic
    );
end project_6_5;

architecture Behavioral of project_6_5 is

begin

    sound : entity work.PWM_df
        port map(
            CLK => CLK,
            FREQ(15 downto 14) => "00",
            FREQ(13 downto 6) => FREQ(13 downto 6), -- only assign a freq region which is hearable
            FREQ(5 downto 0) => "000000",
            DUTY => DC,
            PWM => SPK
        );

end Behavioral;