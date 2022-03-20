library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity project_6_1_tb is
end project_6_1_tb;

architecture Behavioral of project_6_1_tb is
constant CLK_PERIOD : time := 10 ns;
signal CLK : std_logic := '0';
signal DC : std_logic_vector(7 downto 0) := (others=> '0');
signal PWM : std_logic;
begin
    uut : entity work.PWM
    port map (
        CLK => CLK,
        DC => DC,
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
    variable count : unsigned(7 downto 0) := (others => '0');
    begin
        count := count + 1;
        
        DC <= std_logic_vector(count) ;
        wait for 512*CLK_PERIOD;
        -- DC <= (others => '0') after 512 * CLK_PERIOD;
    end process DC_PROC;
end Behavioral;
