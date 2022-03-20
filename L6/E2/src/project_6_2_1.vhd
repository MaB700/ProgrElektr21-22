library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Frequency_Generator is
    Port ( 
        CLK : in std_logic;
        FREQ : in std_logic_vector(15 downto 0);
        SND : out std_logic
    );
end Frequency_Generator;

architecture Behavioral of Frequency_Generator is
signal pwm : std_logic := '0';
--signal clock : std_logic := '0';
constant CLK_PERIOD : time := 25.6 ms;

begin
    SND <= pwm;
    
    pwm_half : entity work.PWM
    port map (
        CLK => CLK,
        FREQ => FREQ,
        PWM => pwm
    );

--    frequency : process is
--    begin
--        clock <= '0';
--        wait for TO_INTEGER(1 / unsigned(FREQ)) * CLK_PERIOD / 2;
--        clock <= '1';
--        wait for TO_INTEGER(1 / unsigned(FREQ)) * CLK_PERIOD / 2;
--    end process frequency;
end Behavioral;
