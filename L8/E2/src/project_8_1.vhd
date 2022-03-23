library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity project_8_1 is
    Port ( 
        CLK : in std_logic;
        SW : in std_logic_vector(7 downto 0);
        BTN : in std_logic;
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0);
        RX : in std_logic
    );
end project_8_1;

architecture Behavioral of project_8_1 is
constant awidth : integer := 8;
constant dwidth : integer := 8;
signal s_wen, s_ren : std_logic;
signal s_wadd, s_radd : std_logic_vector(awidth-1 downto 0);
signal s_din, s_dout : std_logic_vector(dwidth-1 downto 0);
signal s_err, s_valid : std_logic;
begin

s_wen <= '1' when ((s_valid='1') and (s_err='0')) else '0'; 
    
    ram : entity work.ram
    generic map (
        AWIDTH => awidth,
        DWIDTH => dwidth
    )    
    port map ( 
        CLK => CLK,        
        WEN => s_wen,-- enable input
        DIN => s_din, -- DWIDTH bit's input        
        REN => s_ren, -- enable output
        DOUT => s_dout -- output bits from ram(adressNr) 
    );
    
    UART_receiver : entity work.UART_receiver
    Port map ( 
        CLK => CLK,
        RST => '0',
        DOUT => s_din, 
        VALID => s_valid,
        FERR => s_err,
        RX => RX
    );
    
    debouncer : entity work.edge_detector
    port map (
        CLK => CLK,
        I => BTN,
        EDGE => s_ren
    );
    
    disp : entity work.project_4_4
    port map (
        CLK => CLK,
        I(7 downto 0) => s_dout,
        I(31 downto 8) => (others => '1'),
        MODE => "11",
        C => C,
        A => A
    );
    
    process (CLK) is
    begin
        if rising_edge(CLK) then
            if s_wen = '1' then
                s_wadd <= std_logic_vector(unsigned(s_wadd) + 1);
            end if;
            if BTN = '1' then
                s_radd <= SW;                
            end if;
        end if;
    end process;
    
end Behavioral;
