library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity PWM_df is
    port (
        CLK : in std_logic;
        DUTY : in std_logic_vector(7 downto 0); -- duty and freq are inputs now
        FREQ : in std_logic_vector(15 downto 0);
        PWM : out std_logic := '1'
    );
end PWM_df;

architecture Behavioral of PWM_df is
    signal cycle_cnt : integer range 0 to 110e6 := 0;
    signal duty_th : integer range 0 to 110e6 := 0;
begin
    duty_th <= 110e6 when DUTY = "11111111" else -- same as in project_6_4_1.vhd
              (100e6/255) * to_integer(unsigned(DUTY));

    process (CLK) is
    begin
        if rising_edge(CLK) then
            cycle_cnt <= cycle_cnt + to_integer(unsigned(FREQ)); -- same as in project_6_2_1.vhd
            if cycle_cnt >= integer(100e6) then
                PWM <= '1';
                cycle_cnt <= 0;
            elsif cycle_cnt >= duty_th then
                PWM <= '0';
            end if;
        end if;
    end process;

end Behavioral;