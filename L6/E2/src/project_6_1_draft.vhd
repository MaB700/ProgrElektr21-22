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
    constant minFreq : integer := 10;
    signal value : std_logic := '1';
    signal max_cnt : integer range 0 to 100e6/(2*minFreq)-1 := 100e6/(2*minFreq)-1;
    signal cnt : integer range 0 to 100e6/(2*minFreq)-1 := 0;
begin
    PWM <= value;
    max_cnt <= 100e6/(2*TO_INTEGER(unsigned(FREQ)))-1;
    process (CLK) is
    begin 
        if rising_edge(CLK) then
            cnt <= cnt + 1;            
            if ( cnt = max_cnt) then
                value <= '1';
                cnt <= 0;
            elsif ( cnt = max_cnt/2) then -- Duty cycle of 50%
                value <= '0';                
            end if;            
        end if;
    end process;

end Behavioral;
