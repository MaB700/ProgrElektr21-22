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
type state_type is (s_idle, s_recieving, s_read, s_oversample_eval);
signal state : state_type := s_idle;
signal timer_T : std_logic;
signal bit_counter : integer range 0 to 129 := 0;
signal input : std_logic_vector(128 downto 0) := (others => '0');
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
variable count_0 : integer range 0 to 16 := 0;
variable count_1 : integer range 0 to 16 := 0;
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
                    
                    if bit_counter = 128 then
                        state <= s_read;
                        bit_counter <= 0;
                    end if;            
                end if;
            when s_read =>
                DOUT <= input(7 downto 0); --x"30";--input(7 downto 0);
                FERR <= not input(8);
                VALID <= '1'; --input(8);
                state <= s_idle;
            when s_oversample_eval =>
                for i in 7 downto 0 loop
                    for j in 15 downto 0 loop
                        if input(16*i+j) = '1' then
                            count_1 := count_1 + 1;
                        else
                            count_0 := count_0 + 1;
                        end if;
                        if i = 0 and j = 0 then
                            loop_done := 1;
                        end if;
                    end loop;                    
                end loop;
                 
            end case; 
        end if;   
    end if;
end process;
end Behavioral;
