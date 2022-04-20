library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity PWM is
    port (
        CLK : in std_logic;
        DC : in std_logic_vector(7 downto 0);
        PWM : out std_logic
    );
end PWM;

architecture Behavioral of PWM is
    signal value : std_logic := '1';
begin
    PWM <= value;
    process (CLK) is
        variable cycle_cnt : unsigned(7 downto 0) := (others => '0');
    begin
        -- optional: reset pwm signal & cnt when DC changed -> e.g. no overlap when going from DC=255 to DC=0
        --if(DC'event) then
        --    value <= '1';
        --    cycle_cnt := (others => '0');
        --end if;

        if rising_edge(CLK) then
            
            if (cycle_cnt = "11111110") then -- last bit is 0 because of 255 clk cycles
                value <= '1';
                cycle_cnt := (others => '0');
            end if;
            if cycle_cnt = unsigned(DC) then -- for both DC=254, DC=255 the PWM is 100%
                value <= '0';
            end if;
            cycle_cnt := cycle_cnt + 1;

        end if;
    end process;

end Behavioral;