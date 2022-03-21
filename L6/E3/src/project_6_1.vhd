library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity PWM is
    Port ( 
        CLK : in std_logic;
        DUTY : in std_logic_vector(7 downto 0);
        FREQ : in std_logic_vector(15 downto 0);
        PWM : out std_logic := '1'
    );
end PWM;

--architecture Behavioral of PWM is
--    constant minFreq : integer := 1;
--    signal value : std_logic := '1';
--    signal max_cnt : integer range 0 to 100e6/(2*minFreq)-1 := 100e6/(2*minFreq)-1;
--    signal cnt : integer range 0 to 100e6/(2*minFreq)-1 := 0;
    
--begin
--    -- PWM <= '1';
--    max_cnt <= 0 when unsigned(FREQ) = 0 else
--                 100e6/(2*TO_INTEGER(unsigned(FREQ)))-1;             
--    process (CLK) is
--    begin 
--        if rising_edge(CLK) then
--            cnt <= cnt + 1;          
--            if ( cnt = max_cnt/2) then -- Duty cycle of 50%
--                PWM <= '0'; 
--            elsif ( cnt = max_cnt) then
--                PWM <= '1';
--                cnt <= 0;               
--            end if; 
----            if unsigned(FREQ) = 0 then
----                value <= '0';
----            end if;           
--        end if;
--    end process;

--end Behavioral;

architecture Behavioral of PWM is
signal cycle_cnt : integer range 0 to 110e6 := 0;
begin
    
    process (CLK) is
    begin   
        
        if rising_edge(CLK) then
            cycle_cnt <= cycle_cnt + to_integer(unsigned(FREQ));                                
            if cycle_cnt >= integer(100e6) then
                PWM <= '1';
                cycle_cnt <= 0;
            elsif cycle_cnt >= to_integer(unsigned(DUTY))*195e3 then 
                PWM <= '0';                  
            end if;
        end if;
    end process;

end Behavioral;
