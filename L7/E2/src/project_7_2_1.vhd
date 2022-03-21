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
type state_type is (s_send, s_idle, s_reset);
signal state : state_type := s_idle; 
signal count : integer range 0 to 100e6 - 1 := 0;
signal input : unsigned(7 downto 0) := (others => '0');
signal number_sent : integer range 0 to 9 := 0;
begin
    process (CLK) is
    begin
        if rising_edge(CLK) then
        
            case state is 
            when s_idle =>
                LED <= '0';
                if p_sent = 1 then --debouncer adden
                    input <= unsigned(DIN);
                    state <= s_send;
                end if;
            when s_sent =>
                
                count <= count + 115200;
                if count >= 100e6 then
                    count <= 0;
                    TX <= input(number_sent);
                    number_sent <= number_sent + 1;
                    if number_sent = 9 then
                        state <= s_idle;
                    end if;
                end if;
                
        end if;
    
    end process;


end Behavioral;
