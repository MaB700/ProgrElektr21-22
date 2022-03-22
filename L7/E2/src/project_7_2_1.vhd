library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity UART is
    Port ( 
        CLK : in std_logic;
        RST : in std_logic;
        SEND : in std_logic;
        DIN : in std_logic_vector(7 downto 0);
        IDLE : out std_logic;
        TX : out std_logic
    );
end UART;

architecture Behavioral of UART is
type state_type is (s_send, s_idle);
signal state : state_type := s_idle; 
signal count : integer range 0 to 130e6 - 1 := 0;
signal input : unsigned(7 downto 0) := (others => '0');
signal number_sent : integer range 0 to 9 := 0;
signal timer_T : std_logic;
begin
    timer : entity work.project_3_1
    generic map (
        FREQ_IN => 100e6,
        FREQ_OUT => 115200
    )
    port map (
        CLK => CLK,
        T => timer_T
    );
    
    process (CLK) is
    begin
        if rising_edge(CLK) then
            if RST = '1' then -- RST is debounced input
                -- count <= 0;
                number_sent <= 0;
                input <= (others => '0'); -- might not be needed
                state <= s_idle;
            else
                case state is 
                when s_idle =>
                    TX <= '1';
                    IDLE <= '1'; 
                    if SEND = '1' then -- SEND is debounced input
                        input <= unsigned(DIN);
                        state <= s_send;
                        IDLE <= '0';
                    end if;
                when s_send =>                
                    --count <= count + 115200;
                    if timer_T = '1' then -- count >= 100e6
                        -- count <= 0;
                        number_sent <= number_sent + 1;
                        if number_sent = 0 then
                            TX <= '0'; -- 1 bit start
                        elsif number_sent < 9 then --9
                            TX <= input(number_sent - 1); -- 7 downto 0
                        else
                            TX <= '1'; -- 1 bit stop
                            state <= s_idle;
                            number_sent <= 0;
                        end if;                    
                    end if;
                end case;  
            end if;
        end if;
    
    end process;


end Behavioral;
