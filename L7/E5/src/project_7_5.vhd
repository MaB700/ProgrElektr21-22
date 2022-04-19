library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity project_7_4 is
    port (
        CLK : in std_logic;
        BTN : in std_logic;
        led : out std_logic_vector(7 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0);
        RX : in std_logic
    );
end project_7_4;

architecture Behavioral of project_7_4 is
    signal s_dout : std_logic_vector(7 downto 0);
    signal s_feer : std_logic;
    signal s_valid : std_logic;
    signal chars : std_logic_vector(31 downto 0) := (others => '1');
begin
    receiver : entity work.UART_receiver_os
        port map(
            CLK => CLK,
            RST => BTN,
            DOUT => s_dout,
            VALID => s_valid,
            FERR => s_feer,
            RX => RX
        );

    multi_display : entity work.project_4_4 -- display 4 ASCII chars
        port map(
            CLK => CLK,
            I => chars,
            MODE => "11",
            C => C,
            A => A
        );

    process (CLK) is
    begin
        if rising_edge(CLK) then
            if s_valid = '1' then
                led <= s_dout;
                chars(31 downto 0) <= chars(23 downto 0) & s_dout; -- shift register for four bytes
            end if;
        end if;
    end process;

end Behavioral;