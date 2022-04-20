library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity project_6_4_tb is
end project_6_4_tb;

architecture Behavioral of project_6_4_tb is
    constant CLK_PERIOD : time := 10 ns;
    signal CLK : std_logic := '0';
    signal DC : std_logic_vector(7 downto 0) := (others => '0');
    signal PWM : std_logic;
begin
    uut : entity work.PWM_d_440
        port map(
            CLK => CLK,
            DUTY => DC,
            PWM => PWM
        );

    CLK_PROC : process is
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process CLK_PROC;

    DC_PROC : process is
        variable count : unsigned(7 downto 0) := "00000000";--(others => '0');
    begin
        DC <= std_logic_vector(count);
        wait for 2 * 255 * CLK_PERIOD; -- 2 PWM periods
        --count := count + 10;
    end process DC_PROC;
end Behavioral;