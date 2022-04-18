library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity UART_sender is
    port (
        CLK : in std_logic;
        RST : in std_logic;
        SEND : in std_logic;
        DIN : in std_logic_vector(7 downto 0);
        IDLE : out std_logic;
        TX : out std_logic
    );
end UART_sender;

architecture Behavioral of UART_sender is
    type state_type is (s_send, s_idle);
    signal state : state_type := s_idle;
    signal input : unsigned(7 downto 0) := (others => '0');
    signal number_sent : integer range 0 to 9 := 0;
    signal timer_T : std_logic;
begin

    timer : entity work.project_3_1 -- timeer module 
        generic map(
            FREQ_IN => 100e6,
            FREQ_OUT => 115200
        )
        port map(
            CLK => CLK,
            T => timer_T
        );

    process (CLK) is
    begin
        if rising_edge(CLK) then
            if RST = '1' then -- RST is debounced input
                number_sent <= 0;
                input <= (others => '0'); -- might not be needed
                state <= s_idle;
            else
                case state is
                    when s_idle =>
                        TX <= '1'; -- TX permanent '1' in idle
                        IDLE <= '1';
                        if SEND = '1' then -- SEND is debounced input
                            input <= unsigned(DIN);
                            state <= s_send;
                            IDLE <= '0';
                        end if;
                    when s_send =>
                        if timer_T = '1' then
                            number_sent <= number_sent + 1;
                            if number_sent = 0 then
                                TX <= '0'; -- 1 bit start
                            elsif number_sent < 9 then
                                TX <= input(number_sent - 1); -- 8 bit data
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