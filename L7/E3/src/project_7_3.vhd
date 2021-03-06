library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity project_7_3 is
    port (
        CLK : in std_logic;
        BTN : in std_logic;
        led : out std_logic_vector(7 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0);
        RX : in std_logic
    );
end project_7_3;

architecture Behavioral of project_7_3 is
    signal s_dout : std_logic_vector(7 downto 0);
    signal s_feer : std_logic;
    signal err_count : unsigned(13 downto 0) := (others => '0');
    signal s_valid : std_logic;
begin

    receiver : entity work.UART_receiver
        port map(
            CLK => CLK,
            RST => BTN,
            DOUT => s_dout,
            VALID => s_valid,
            FERR => s_feer,
            RX => RX
        );

    test : entity work.project_4_4 -- display number of framing errors
        port map(
            CLK => CLK,
            I(13 downto 0) => std_logic_vector(err_count),
            I(31 downto 14) => (others => '0'),
            MODE => "10",
            C => C,
            A => A
        );

    process (CLK) is
    begin
        if rising_edge(CLK) then
            if s_feer = '1' then -- count number of errors signals from the receiver entity
                err_count <= err_count + 1;
            end if;
            if s_valid = '1' then -- last received byte is displayed
                led <= s_dout;
            end if;
        end if;
    end process;

end Behavioral;