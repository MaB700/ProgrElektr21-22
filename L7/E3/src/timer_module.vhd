library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity timer_module is
    Port (
        CLK : in std_logic;
        FREQ : in std_logic_vector(7 downto 0);
        NEW_CLK : out std_logic
    );
end timer_module;

architecture Behavioral of timer_module is
signal counter : integer range 110e6 to 0;
signal clk_out : std_logic;
begin
process (CLK) is
begin
    if rising_edge(CLK) then
        counter <= counter + to_integer(unsigned(FREQ));
        if counter >= 100e6 - 1 then
            counter <= 0;
            NEW_CLK <= '1';
        else 
            NEW_CLK <= '0';
        end if;
    end if;
end process;

end Behavioral;
