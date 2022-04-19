library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_3_1_1 is
    port (
        CLK : in std_logic;
        LED : out std_logic
    );
end project_3_1_1;

architecture Behavioral of project_3_1_1 is
    signal led_out : std_logic := '0';
    signal timer_T : std_logic;
begin

    timer : entity work.project_3_1
        generic map(
            FREQ_IN => 100e6, -- CLK frequncy
            FREQ_OUT => 2 -- 2Hz
        )
        port map(
            CLK => CLK,
            T => timer_T -- "slower" clock signal
        );

    process (CLK) is
    begin
        if rising_edge(CLK) then
            if timer_T = '1' then -- led signal invertes now with the slower clock signal
                led_out <= not led_out;
            end if;
        end if;
    end process;
    LED <= led_out;
end Behavioral;