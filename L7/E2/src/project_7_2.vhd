library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_7_2 is
    Port ( 
        CLK : in std_logic;
        SW : in std_logic_vector(7 downto 0);
        BTN : in std_logic_vector(1 downto 0);
        LED : out std_logic;
        TX : out std_logic;
        L2 : out std_logic -- to see the signals in the Saleae Logic Software
    );
end project_7_2;

architecture Behavioral of project_7_2 is
signal s_send, s_rst : std_logic := '0';
signal s_idle : std_logic ;
signal s_tx : std_logic;
begin
TX <= s_tx;
L2 <= s_tx;
LED <= not s_idle;  -- if idle: LED is off, on if data is sent
    
    UART : entity work.UART
    port map (
        CLK => CLK,
        RST => s_rst, -- <U17>
        SEND => s_send, -- <T17>
        DIN => SW,
        IDLE => s_idle,
        TX => s_tx    
    );
    
    debouncer_send : entity work.edge_detector
    port map (
        CLK => CLK,
        I => BTN(0),
        EDGE => s_send
    );
    
    debouncer_rst : entity work.edge_detector
    port map (
        CLK => CLK,
        I => BTN(1),
        EDGE => s_rst
    );

end Behavioral;
