library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_1_2 is
    Port (
        sw : in std_logic_vector(5 downto 0);
        led : out std_logic_vector(0 downto 0)
    );
end project_1_2;

architecture Behavioral of project_1_2 is
begin
    led(0) <= (sw(5) and sw(2)) or (sw(4) and sw(1)) or (sw(3) and sw(0));
end Behavioral;
