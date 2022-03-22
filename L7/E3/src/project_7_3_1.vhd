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
signal bit_counter : integer range 0 to 9 := 0;
signal input : std_logic_vector( 8 downto 0) := (others => '0');
begin

    timer : entity work.project_3_1 -- timer module
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
        if RST = '1' then
            bit_counter <= 0;
            input <= (others => '0');
            DOUT <= (others => '1');            
            state <= s_idle;
        else        
            case state is
            when s_idle =>
                FERR <= '0';
                bit_counter <= 0;
                VALID <= '0';
                if timer_T = '1' and RX = '0' then
                    state <= s_recieving;
                end if;
            when s_recieving =>
                VALID <= '0';
                if timer_T = '1' then
                
                    input(bit_counter) <= RX;
                    bit_counter <= bit_counter + 1;
                    
                    if bit_counter = 8 then
                        state <= s_read;
                        bit_counter <= 0;
                    end if;            
                end if;
            when s_read =>
                DOUT <= input(7 downto 0); --x"30";--input(7 downto 0);
                FERR <= not input(8);
                VALID <= '1'; --input(8);
                state <= s_idle;
            end case; 
        end if;   
    end if;
end process;
end Behavioral;
