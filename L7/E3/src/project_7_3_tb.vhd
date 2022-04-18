library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_7_3_tb is
end project_7_3_tb;

architecture Behavioral of project_7_3_tb is
    signal CLK : std_logic;
    -- signal BTN :  std_logic;
    signal led : std_logic_vector(7 downto 0);
    --signal C :  std_logic_vector(7 downto 0);
    --signal A :  std_logic_vector(3 downto 0);
    signal RX : std_logic;

    constant CLK_PERIOD : time := 10ns;

    signal s_val : std_logic;
    signal s_err : std_logic;
begin
    uut : entity work.UART_receiver
        port map(
            CLK => CLK,
            RST => '0',
            DOUT => led,
            VALID => s_val,
            FERR => s_err,
            RX => RX
        );

    CLK_PROC : process is
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process CLK_PROC;

    RX_PROC : process is
    begin
        RX <= '1';
        wait for 8.68 us;
        RX <= '0'; -- start bit
        wait for 8.68 us;
        RX <= '1';
        wait for 8.68 us;
        RX <= '0';
        wait for 8.68 us;
        RX <= '0';
        wait for 8.68 us;
        RX <= '0';
        wait for 8.68 us;
        RX <= '0'; --
        wait for 8.68 us;
        RX <= '0';
        wait for 8.68 us;
        RX <= '1';
        wait for 8.68 us;
        RX <= '0';
        wait for 8.68 us;
        RX <= '1'; -- stop bit
        wait for 8.68 us;
    end process RX_PROC;

end Behavioral;