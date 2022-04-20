library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity project_6_2_tb is
end project_6_2_tb;

architecture Behavioral of project_6_2_tb is
    constant CLK_PERIOD : time := 10 ns;
    signal CLK : std_logic := '0';
    signal FREQ : unsigned (15 downto 0) := (others => '0');
    signal PWM : std_logic;
begin
    uut : entity work.Frequency_Generator
        port map(
            CLK => CLK,
            FREQ => std_logic_vector(FREQ),
            SND => PWM
        );

    CLK_PROC : process is
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process CLK_PROC;

    FREQ_PROC : process is
    begin
        FREQ <= TO_UNSIGNED(integer(100), 16);
        wait for 20 ms;
        FREQ <= TO_UNSIGNED(integer(1000), 16);
        wait for 2 ms;
        FREQ <= TO_UNSIGNED(integer(10000), 16);
        wait for 200 us;
    end process FREQ_PROC;

end Behavioral;