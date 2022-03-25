library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_receiver is
    Port ( 
        CLK : in std_logic;
        RST : in std_logic;
        DOUT : out std_logic_vector(7 downto 0);
        VALID : out std_logic;
        FERR : out std_logic;
        RX : in std_logic
    );
end UART_receiver;

architecture Behavioral of UART_receiver is
type state_type is (s_idle, s_recieving, s_read);
signal state : state_type := s_idle;
signal timer_T : std_logic;
signal bit_counter : integer range 0 to 8 := 0;
signal input : std_logic_vector(8 downto 0) := (others => '0');
signal SREG : std_logic_vector(8 downto 0) := (others => '0');
signal count_8 : integer range 0 to 10 := 0;
signal count_16 : integer range 0 to 20 := 0;
begin

    timer : entity work.project_3_1 -- timer module
    generic map (
        FREQ_IN => 100e6,
        FREQ_OUT => 16*115200
    )
    port map (
        CLK => CLK,
        T => timer_T
    );

process (CLK) is 

begin
    if rising_edge(CLK) then
        if RST = '1' then
            bit_counter <= 0;
            SREG <= (others => '0');
            DOUT <= (others => '1');            
            state <= s_idle;
        else        
            case state is
            when s_idle =>
                FERR <= '0';
                bit_counter <= 0;
                VALID <= '0';
                if timer_T = '1' and RX = '0' then -- beginning of start bit                    
                    count_8 <= count_8 + 1;
                    if count_8 = 7 then -- wait 8 timer_t cycles to be in the middle of start bit
                        state <= s_recieving;
                        count_8 <= 0;
                    end if;
                    
                end if;
            when s_recieving =>
                VALID <= '0';
                if timer_T = '1' then
                    count_16 <= count_16 + 1;
                    if count_16 = 15 then -- wait 16 timer_T cycles till next middle of bit
                        --input(bit_counter) <= RX;
                        SREG(8 downto 0) <= RX & SREG(8 downto 1);
                        bit_counter <= bit_counter + 1;
                        count_16 <= 0;
                    end if;                  
                    if count_16 = 15 and bit_counter = 8 then
                        -- input(8) <= RX;
                        state <= s_read;
                        bit_counter <= 0;
                    end if;            
                end if;
            when s_read =>
                
                DOUT <= SREG(7 downto 0); -- first bit ( time wise) at 0 index, stop bit at last index (8)
                FERR <= not SREG(8);
                VALID <= '1'; --input(8);
                state <= s_idle;
                 
            end case; 
        end if;   
    end if;
end process;
end Behavioral;
