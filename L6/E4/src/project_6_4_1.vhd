library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity PWM_d_440 is
    port (
        CLK : in std_logic;
        DUTY : in std_logic_vector(7 downto 0);
        PWM : out std_logic := '1'
    );
end PWM_d_440;

architecture Behavioral of PWM_d_440 is
    signal cycle_cnt : integer range 0 to 110e6 := 0;
    signal duty_th : integer range 0 to 110e6 := 0;
begin
    duty_th <= 110e6 when DUTY = "11111111" else -- more accuracy for full duty case, calc below would be a bit smaller than 100e6
              (100e6/255)*to_integer(unsigned(DUTY)); -- order of numbers is important to not overflow
    
    process (CLK) is
    begin
        if rising_edge(CLK) then
            cycle_cnt <= cycle_cnt + integer(440); -- 440Hz fixed value
            if cycle_cnt >= integer(100e6) then
                PWM <= '1';
                cycle_cnt <= 0;
            elsif cycle_cnt >= duty_th then
                PWM <= '0';
            end if;
        end if;
    end process;

end Behavioral;