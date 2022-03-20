library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity PWM is
    Port ( 
        CLK : in std_logic;
        FREQ : in std_logic_vector(15 downto 0);
        PWM : out std_logic
    );
end PWM;

architecture Behavioral of PWM is
signal value : std_logic := '1';
begin
    PWM <= value;
    process (CLK) is
    variable cycle_cnt : unsigned(7 downto 0) := (others => '0');
    variable real_time : unsigned(31 downto 0) := (others => '0');
    begin   
        
        real_time := 1 / unsigned(FREQ) * 100e6; -- Conversion MHz to Hz into counter
        
        if rising_edge(CLK) then
                                
            if (cycle_cnt = unsigned(FREQ)) then
                value <= '1';
                cycle_cnt := (others => '0');
            end if;
            if cycle_cnt = real_time / 2 then -- Duty cycle of 50%
                value <= '0';                  
            end if;
            cycle_cnt := cycle_cnt + 1;   
                    
        end if;
    end process;

end Behavioral;
