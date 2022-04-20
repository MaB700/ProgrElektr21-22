library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Project_6_4 is
    port (
        CLK : in std_logic;
        SW : in std_logic_vector(7 downto 0);
        SND : out std_logic
    );
end Project_6_4;

architecture Behavioral of Project_6_4 is
begin

    pwm : entity work.PWM_d_440
        port map(
            CLK => CLK,
            DUTY => SW,
            PWM => SND
        );

end architecture Behavioral;