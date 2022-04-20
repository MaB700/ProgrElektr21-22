library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Frequency_Generator is
    port (
        CLK : in std_logic;
        FREQ : in std_logic_vector(15 downto 0);
        SND : out std_logic := '1'
    );
end Frequency_Generator;

architecture Behavioral of Frequency_Generator is
    signal cycle_cnt : integer range 0 to 110e6 := 0; -- use a higher max value to avoid overflow
begin

    process (CLK) is
    begin
        if rising_edge(CLK) then
            cycle_cnt <= cycle_cnt + to_integer(unsigned(FREQ));
            -- count how often FREQ fits into 100e6 Hz, 
            -- same as counting to the value T_freq/T_clk and incremeting the count by only 1
            if cycle_cnt >= integer(100e6) then
                PWM <= '1';
                cycle_cnt <= 0;
            elsif cycle_cnt >= integer(50e6) then -- duty cycle of 50%
                PWM <= '0';
            end if;
        end if;
    end process;

end Behavioral;